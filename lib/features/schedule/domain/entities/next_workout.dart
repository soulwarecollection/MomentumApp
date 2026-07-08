import 'package:momentum/features/routines/domain/entities/plan.dart';
import 'package:momentum/features/routines/domain/entities/plan_day.dart';
import 'package:momentum/features/routines/domain/entities/plan_exercise.dart';

class NextWorkout {
  const NextWorkout({
    required this.plan,
    required this.dayIndex,
    required this.day,
    required this.exercises,
    this.scheduledDate,
  });

  final Plan plan;
  final int dayIndex;
  final PlanDay day;
  final List<PlanExercise> exercises;
  final DateTime? scheduledDate;
}
