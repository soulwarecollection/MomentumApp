import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:momentum/core/di/injection.dart';
import 'package:momentum/features/routines/domain/entities/plan.dart';
import 'package:momentum/features/routines/domain/entities/plan_day.dart';
import 'package:momentum/features/routines/domain/entities/plan_exercise.dart';
import 'package:momentum/features/routines/domain/repositories/routines_repository.dart';
import 'package:momentum/features/routines/presentation/pages/plan_editor_page.dart';

class _MockRoutinesRepository extends Mock implements RoutinesRepository {}

void main() {
  const planId = 1;
  const pushDay = PlanDay(
    id: 10,
    planId: planId,
    orderIndex: 0,
    isRest: false,
    focus: 'Push',
  );
  const pullDay = PlanDay(
    id: 11,
    planId: planId,
    orderIndex: 1,
    isRest: false,
    focus: 'Pull',
  );
  const benchPress = PlanExercise(
    id: 100,
    planDayId: 10,
    orderIndex: 0,
    name: 'Bench Press',
  );
  const overheadPress = PlanExercise(
    id: 101,
    planDayId: 10,
    orderIndex: 1,
    name: 'Overhead Press',
  );
  const row = PlanExercise(
    id: 102,
    planDayId: 11,
    orderIndex: 0,
    name: 'Barbell Row',
  );

  late _MockRoutinesRepository repo;

  setUpAll(() {
    registerFallbackValue(<int>[]);
  });

  setUp(() async {
    await getIt.reset();
    repo = _MockRoutinesRepository();

    when(() => repo.getPlan(planId)).thenAnswer(
      (_) => TaskEither.of(
        Plan(
          id: planId,
          name: 'PPL',
          isActive: false,
          currentDayIndex: 0,
          createdAt: DateTime(2026),
          updatedAt: DateTime(2026),
        ),
      ),
    );
    when(() => repo.watchPlanDays(planId)).thenAnswer(
      (_) => Stream.value(right([pushDay, pullDay])),
    );
    when(() => repo.watchAllExercisesForPlan(planId)).thenAnswer(
      (_) => Stream.value(
        right([benchPress, overheadPress, row]),
      ),
    );
    when(() => repo.reorderDays(planId, any())).thenAnswer(
      (_) => TaskEither.of(unit),
    );
    when(() => repo.reorderExercises(any(), any())).thenAnswer(
      (_) => TaskEither.of(unit),
    );

    getIt.registerSingleton<RoutinesRepository>(repo);
  });

  tearDown(getIt.reset);

  Future<void> pumpEditor(WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: PlanEditorPage(planId: planId)),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('a workout can collapse to a compact reorder row', (
    tester,
  ) async {
    await pumpEditor(tester);

    expect(find.text('Bench Press'), findsOneWidget);
    expect(find.byTooltip('Minimize workout'), findsNWidgets(2));

    await tester.tap(find.byTooltip('Minimize workout').first);
    await tester.pump();

    expect(find.text('Bench Press'), findsNothing);
    expect(find.text('Barbell Row'), findsOneWidget);
    expect(find.byTooltip('Expand workout'), findsOneWidget);
    expect(find.byTooltip('Drag to reorder workout'), findsNWidgets(2));
  });

  testWidgets('dragging a workout updates its persisted order', (
    tester,
  ) async {
    await pumpEditor(tester);

    await tester.tap(find.byTooltip('Minimize workout').first);
    await tester.pump();
    await tester.tap(find.byTooltip('Minimize workout').first);
    await tester.pump();

    final handles = find.byTooltip('Drag to reorder workout');
    final firstCenter = tester.getCenter(handles.at(0));
    final secondCenter = tester.getCenter(handles.at(1));
    final gesture = await tester.startGesture(firstCenter);
    await tester.pump();
    await gesture.moveTo(
      Offset(firstCenter.dx, secondCenter.dy + 80),
    );
    await tester.pump(const Duration(milliseconds: 300));
    await gesture.up();
    await tester.pumpAndSettle();

    final orderedIds =
        verify(
              () => repo.reorderDays(planId, captureAny()),
            ).captured.single
            as List<int>;
    expect(orderedIds, [11, 10]);
  });

  testWidgets('dragging an exercise updates its workout order', (
    tester,
  ) async {
    await pumpEditor(tester);

    await tester.drag(
      find.byTooltip('Drag to reorder exercise').first,
      const Offset(0, 120),
    );
    await tester.pumpAndSettle();

    final captured = verify(
      () => repo.reorderExercises(captureAny(), captureAny()),
    ).captured;
    expect(captured.first, pushDay.id);
    expect(captured.last, [overheadPress.id, benchPress.id]);
  });
}
