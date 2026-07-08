import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/features/onboarding/domain/entities/onboarding_focus.dart';
import 'package:momentum/features/onboarding/domain/onboarding_templates.dart';
import 'package:momentum/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:momentum/features/routines/domain/repositories/routines_repository.dart';

@immutable
class OnboardingState {
  const OnboardingState({
    this.step = 0,
    this.focus = OnboardingFocus.strength,
    this.splitDays = 4,
    this.isSaving = false,
    this.error,
  });

  /// 0 welcome, 1 focus, 2 split (skipped for cardio), 3 confirm.
  final int step;
  final OnboardingFocus focus;
  final int splitDays;
  final bool isSaving;
  final String? error;

  List<OnboardingDayTemplate> get preview =>
      buildOnboardingPlan(focus: focus, splitDays: splitDays);

  OnboardingState copyWith({
    int? step,
    OnboardingFocus? focus,
    int? splitDays,
    bool? isSaving,
    String? error,
    bool clearError = false,
  }) => OnboardingState(
    step: step ?? this.step,
    focus: focus ?? this.focus,
    splitDays: splitDays ?? this.splitDays,
    isSaving: isSaving ?? this.isSaving,
    error: clearError ? null : error ?? this.error,
  );
}

@injectable
class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit(this._routinesRepo, this._onboardingRepo)
    : super(const OnboardingState());

  final RoutinesRepository _routinesRepo;
  final OnboardingRepository _onboardingRepo;

  static const _lastStep = 3;
  static const _splitStep = 2;

  void selectFocus(OnboardingFocus focus) => emit(state.copyWith(focus: focus));

  void selectSplitDays(int days) => emit(state.copyWith(splitDays: days));

  void nextStep() {
    if (state.step >= _lastStep) return;
    final target = state.step + 1;
    final next = target == _splitStep && state.focus == OnboardingFocus.cardio
        ? target + 1
        : target;
    emit(state.copyWith(step: next));
  }

  void back() {
    if (state.step <= 0) return;
    final target = state.step - 1;
    final prev = target == _splitStep && state.focus == OnboardingFocus.cardio
        ? target - 1
        : target;
    emit(state.copyWith(step: prev));
  }

  /// Creates the previewed plan, activates it, and marks onboarding
  /// complete. Returns the new plan id on success, `null` on failure.
  Future<int?> confirmAndCreatePlan() async {
    emit(state.copyWith(isSaving: true, clearError: true));
    final days = state.preview;
    final planName = '${state.focus.label} · ${days.length}-day split';

    final planResult = await _routinesRepo.createPlan(planName).run();
    final planId = planResult.fold((_) => null, (id) => id);
    if (planId == null) {
      emit(
        state.copyWith(
          isSaving: false,
          error: 'Could not create your plan. Try again.',
        ),
      );
      return null;
    }

    for (final day in days) {
      final dayResult = await _routinesRepo
          .addDay(planId, isRest: false, focus: day.label)
          .run();
      final dayId = dayResult.fold((_) => null, (id) => id);
      if (dayId == null) continue;
      for (final exercise in day.exercises) {
        await _routinesRepo
            .addExercise(
              dayId,
              name: exercise.name,
              equipment: exercise.equipment,
              targetSets: 3,
            )
            .run();
      }
    }

    await _routinesRepo.setActivePlan(planId).run();
    await _onboardingRepo.completeOnboarding(justOnboarded: true);

    emit(state.copyWith(isSaving: false));
    return planId;
  }
}
