import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/features/routines/domain/entities/plan.dart';

part 'plans_state.freezed.dart';

@freezed
sealed class PlansState with _$PlansState {
  const factory PlansState.initial() = PlansInitial;
  const factory PlansState.loading() = PlansLoading;
  const factory PlansState.loaded(List<Plan> plans) = PlansLoaded;
  const factory PlansState.error(String message) = PlansError;
}
