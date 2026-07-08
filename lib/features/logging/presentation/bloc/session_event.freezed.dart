// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SessionEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SessionEvent()';
}


}

/// @nodoc
class $SessionEventCopyWith<$Res>  {
$SessionEventCopyWith(SessionEvent _, $Res Function(SessionEvent) __);
}


/// Adds pattern-matching-related methods to [SessionEvent].
extension SessionEventPatterns on SessionEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SessionStarted value)?  started,TResult Function( ExercisePreFilled value)?  exercisePreFilled,TResult Function( SetRowValue value)?  setRowValue,TResult Function( StepRowValue value)?  stepRowValue,TResult Function( RowToggled value)?  rowToggled,TResult Function( SetAdded value)?  setAdded,TResult Function( SetRemoved value)?  setRemoved,TResult Function( ExerciseReordered value)?  exerciseReordered,TResult Function( ExerciseToggled value)?  exerciseToggled,TResult Function( AdhocExerciseAdded value)?  adhocExerciseAdded,TResult Function( StopwatchToggled value)?  stopwatchToggled,TResult Function( RestTimerStarted value)?  restTimerStarted,TResult Function( RestTimerAdjusted value)?  restTimerAdjusted,TResult Function( RestTimerTicked value)?  restTimerTicked,TResult Function( RestTimerSkipped value)?  restTimerSkipped,TResult Function( SetRowExpanded value)?  setRowExpanded,TResult Function( ExerciseEquipmentChanged value)?  exerciseEquipmentChanged,TResult Function( ExerciseNoteChanged value)?  exerciseNoteChanged,TResult Function( ExerciseTargetChanged value)?  exerciseTargetChanged,TResult Function( CelebrationDismissed value)?  celebrationDismissed,TResult Function( FinishRequested value)?  finishRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SessionStarted() when started != null:
return started(_that);case ExercisePreFilled() when exercisePreFilled != null:
return exercisePreFilled(_that);case SetRowValue() when setRowValue != null:
return setRowValue(_that);case StepRowValue() when stepRowValue != null:
return stepRowValue(_that);case RowToggled() when rowToggled != null:
return rowToggled(_that);case SetAdded() when setAdded != null:
return setAdded(_that);case SetRemoved() when setRemoved != null:
return setRemoved(_that);case ExerciseReordered() when exerciseReordered != null:
return exerciseReordered(_that);case ExerciseToggled() when exerciseToggled != null:
return exerciseToggled(_that);case AdhocExerciseAdded() when adhocExerciseAdded != null:
return adhocExerciseAdded(_that);case StopwatchToggled() when stopwatchToggled != null:
return stopwatchToggled(_that);case RestTimerStarted() when restTimerStarted != null:
return restTimerStarted(_that);case RestTimerAdjusted() when restTimerAdjusted != null:
return restTimerAdjusted(_that);case RestTimerTicked() when restTimerTicked != null:
return restTimerTicked(_that);case RestTimerSkipped() when restTimerSkipped != null:
return restTimerSkipped(_that);case SetRowExpanded() when setRowExpanded != null:
return setRowExpanded(_that);case ExerciseEquipmentChanged() when exerciseEquipmentChanged != null:
return exerciseEquipmentChanged(_that);case ExerciseNoteChanged() when exerciseNoteChanged != null:
return exerciseNoteChanged(_that);case ExerciseTargetChanged() when exerciseTargetChanged != null:
return exerciseTargetChanged(_that);case CelebrationDismissed() when celebrationDismissed != null:
return celebrationDismissed(_that);case FinishRequested() when finishRequested != null:
return finishRequested(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SessionStarted value)  started,required TResult Function( ExercisePreFilled value)  exercisePreFilled,required TResult Function( SetRowValue value)  setRowValue,required TResult Function( StepRowValue value)  stepRowValue,required TResult Function( RowToggled value)  rowToggled,required TResult Function( SetAdded value)  setAdded,required TResult Function( SetRemoved value)  setRemoved,required TResult Function( ExerciseReordered value)  exerciseReordered,required TResult Function( ExerciseToggled value)  exerciseToggled,required TResult Function( AdhocExerciseAdded value)  adhocExerciseAdded,required TResult Function( StopwatchToggled value)  stopwatchToggled,required TResult Function( RestTimerStarted value)  restTimerStarted,required TResult Function( RestTimerAdjusted value)  restTimerAdjusted,required TResult Function( RestTimerTicked value)  restTimerTicked,required TResult Function( RestTimerSkipped value)  restTimerSkipped,required TResult Function( SetRowExpanded value)  setRowExpanded,required TResult Function( ExerciseEquipmentChanged value)  exerciseEquipmentChanged,required TResult Function( ExerciseNoteChanged value)  exerciseNoteChanged,required TResult Function( ExerciseTargetChanged value)  exerciseTargetChanged,required TResult Function( CelebrationDismissed value)  celebrationDismissed,required TResult Function( FinishRequested value)  finishRequested,}){
final _that = this;
switch (_that) {
case SessionStarted():
return started(_that);case ExercisePreFilled():
return exercisePreFilled(_that);case SetRowValue():
return setRowValue(_that);case StepRowValue():
return stepRowValue(_that);case RowToggled():
return rowToggled(_that);case SetAdded():
return setAdded(_that);case SetRemoved():
return setRemoved(_that);case ExerciseReordered():
return exerciseReordered(_that);case ExerciseToggled():
return exerciseToggled(_that);case AdhocExerciseAdded():
return adhocExerciseAdded(_that);case StopwatchToggled():
return stopwatchToggled(_that);case RestTimerStarted():
return restTimerStarted(_that);case RestTimerAdjusted():
return restTimerAdjusted(_that);case RestTimerTicked():
return restTimerTicked(_that);case RestTimerSkipped():
return restTimerSkipped(_that);case SetRowExpanded():
return setRowExpanded(_that);case ExerciseEquipmentChanged():
return exerciseEquipmentChanged(_that);case ExerciseNoteChanged():
return exerciseNoteChanged(_that);case ExerciseTargetChanged():
return exerciseTargetChanged(_that);case CelebrationDismissed():
return celebrationDismissed(_that);case FinishRequested():
return finishRequested(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SessionStarted value)?  started,TResult? Function( ExercisePreFilled value)?  exercisePreFilled,TResult? Function( SetRowValue value)?  setRowValue,TResult? Function( StepRowValue value)?  stepRowValue,TResult? Function( RowToggled value)?  rowToggled,TResult? Function( SetAdded value)?  setAdded,TResult? Function( SetRemoved value)?  setRemoved,TResult? Function( ExerciseReordered value)?  exerciseReordered,TResult? Function( ExerciseToggled value)?  exerciseToggled,TResult? Function( AdhocExerciseAdded value)?  adhocExerciseAdded,TResult? Function( StopwatchToggled value)?  stopwatchToggled,TResult? Function( RestTimerStarted value)?  restTimerStarted,TResult? Function( RestTimerAdjusted value)?  restTimerAdjusted,TResult? Function( RestTimerTicked value)?  restTimerTicked,TResult? Function( RestTimerSkipped value)?  restTimerSkipped,TResult? Function( SetRowExpanded value)?  setRowExpanded,TResult? Function( ExerciseEquipmentChanged value)?  exerciseEquipmentChanged,TResult? Function( ExerciseNoteChanged value)?  exerciseNoteChanged,TResult? Function( ExerciseTargetChanged value)?  exerciseTargetChanged,TResult? Function( CelebrationDismissed value)?  celebrationDismissed,TResult? Function( FinishRequested value)?  finishRequested,}){
final _that = this;
switch (_that) {
case SessionStarted() when started != null:
return started(_that);case ExercisePreFilled() when exercisePreFilled != null:
return exercisePreFilled(_that);case SetRowValue() when setRowValue != null:
return setRowValue(_that);case StepRowValue() when stepRowValue != null:
return stepRowValue(_that);case RowToggled() when rowToggled != null:
return rowToggled(_that);case SetAdded() when setAdded != null:
return setAdded(_that);case SetRemoved() when setRemoved != null:
return setRemoved(_that);case ExerciseReordered() when exerciseReordered != null:
return exerciseReordered(_that);case ExerciseToggled() when exerciseToggled != null:
return exerciseToggled(_that);case AdhocExerciseAdded() when adhocExerciseAdded != null:
return adhocExerciseAdded(_that);case StopwatchToggled() when stopwatchToggled != null:
return stopwatchToggled(_that);case RestTimerStarted() when restTimerStarted != null:
return restTimerStarted(_that);case RestTimerAdjusted() when restTimerAdjusted != null:
return restTimerAdjusted(_that);case RestTimerTicked() when restTimerTicked != null:
return restTimerTicked(_that);case RestTimerSkipped() when restTimerSkipped != null:
return restTimerSkipped(_that);case SetRowExpanded() when setRowExpanded != null:
return setRowExpanded(_that);case ExerciseEquipmentChanged() when exerciseEquipmentChanged != null:
return exerciseEquipmentChanged(_that);case ExerciseNoteChanged() when exerciseNoteChanged != null:
return exerciseNoteChanged(_that);case ExerciseTargetChanged() when exerciseTargetChanged != null:
return exerciseTargetChanged(_that);case CelebrationDismissed() when celebrationDismissed != null:
return celebrationDismissed(_that);case FinishRequested() when finishRequested != null:
return finishRequested(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( List<ExerciseEntry> exercises,  int? planId,  int? dayIndex,  int? planTotalDays,  String? focus)?  started,TResult Function( String exerciseLocalId,  List<Map<String, double>> setMetrics)?  exercisePreFilled,TResult Function( String exerciseLocalId,  String setLocalId,  String metricKey,  double value)?  setRowValue,TResult Function( String exerciseLocalId,  String setLocalId,  String metricKey,  double delta)?  stepRowValue,TResult Function( String exerciseLocalId,  String setLocalId)?  rowToggled,TResult Function( String exerciseLocalId)?  setAdded,TResult Function( String exerciseLocalId,  String setLocalId)?  setRemoved,TResult Function( int oldIndex,  int newIndex)?  exerciseReordered,TResult Function( String exerciseLocalId)?  exerciseToggled,TResult Function( ExerciseEntry exercise)?  adhocExerciseAdded,TResult Function()?  stopwatchToggled,TResult Function( int seconds)?  restTimerStarted,TResult Function( int delta)?  restTimerAdjusted,TResult Function()?  restTimerTicked,TResult Function()?  restTimerSkipped,TResult Function( String exerciseLocalId,  String setLocalId,  bool expanded)?  setRowExpanded,TResult Function( String exerciseLocalId,  EquipmentType? equipment)?  exerciseEquipmentChanged,TResult Function( String exerciseLocalId,  String? note)?  exerciseNoteChanged,TResult Function( String exerciseLocalId,  double? targetWeight)?  exerciseTargetChanged,TResult Function()?  celebrationDismissed,TResult Function()?  finishRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SessionStarted() when started != null:
return started(_that.exercises,_that.planId,_that.dayIndex,_that.planTotalDays,_that.focus);case ExercisePreFilled() when exercisePreFilled != null:
return exercisePreFilled(_that.exerciseLocalId,_that.setMetrics);case SetRowValue() when setRowValue != null:
return setRowValue(_that.exerciseLocalId,_that.setLocalId,_that.metricKey,_that.value);case StepRowValue() when stepRowValue != null:
return stepRowValue(_that.exerciseLocalId,_that.setLocalId,_that.metricKey,_that.delta);case RowToggled() when rowToggled != null:
return rowToggled(_that.exerciseLocalId,_that.setLocalId);case SetAdded() when setAdded != null:
return setAdded(_that.exerciseLocalId);case SetRemoved() when setRemoved != null:
return setRemoved(_that.exerciseLocalId,_that.setLocalId);case ExerciseReordered() when exerciseReordered != null:
return exerciseReordered(_that.oldIndex,_that.newIndex);case ExerciseToggled() when exerciseToggled != null:
return exerciseToggled(_that.exerciseLocalId);case AdhocExerciseAdded() when adhocExerciseAdded != null:
return adhocExerciseAdded(_that.exercise);case StopwatchToggled() when stopwatchToggled != null:
return stopwatchToggled();case RestTimerStarted() when restTimerStarted != null:
return restTimerStarted(_that.seconds);case RestTimerAdjusted() when restTimerAdjusted != null:
return restTimerAdjusted(_that.delta);case RestTimerTicked() when restTimerTicked != null:
return restTimerTicked();case RestTimerSkipped() when restTimerSkipped != null:
return restTimerSkipped();case SetRowExpanded() when setRowExpanded != null:
return setRowExpanded(_that.exerciseLocalId,_that.setLocalId,_that.expanded);case ExerciseEquipmentChanged() when exerciseEquipmentChanged != null:
return exerciseEquipmentChanged(_that.exerciseLocalId,_that.equipment);case ExerciseNoteChanged() when exerciseNoteChanged != null:
return exerciseNoteChanged(_that.exerciseLocalId,_that.note);case ExerciseTargetChanged() when exerciseTargetChanged != null:
return exerciseTargetChanged(_that.exerciseLocalId,_that.targetWeight);case CelebrationDismissed() when celebrationDismissed != null:
return celebrationDismissed();case FinishRequested() when finishRequested != null:
return finishRequested();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( List<ExerciseEntry> exercises,  int? planId,  int? dayIndex,  int? planTotalDays,  String? focus)  started,required TResult Function( String exerciseLocalId,  List<Map<String, double>> setMetrics)  exercisePreFilled,required TResult Function( String exerciseLocalId,  String setLocalId,  String metricKey,  double value)  setRowValue,required TResult Function( String exerciseLocalId,  String setLocalId,  String metricKey,  double delta)  stepRowValue,required TResult Function( String exerciseLocalId,  String setLocalId)  rowToggled,required TResult Function( String exerciseLocalId)  setAdded,required TResult Function( String exerciseLocalId,  String setLocalId)  setRemoved,required TResult Function( int oldIndex,  int newIndex)  exerciseReordered,required TResult Function( String exerciseLocalId)  exerciseToggled,required TResult Function( ExerciseEntry exercise)  adhocExerciseAdded,required TResult Function()  stopwatchToggled,required TResult Function( int seconds)  restTimerStarted,required TResult Function( int delta)  restTimerAdjusted,required TResult Function()  restTimerTicked,required TResult Function()  restTimerSkipped,required TResult Function( String exerciseLocalId,  String setLocalId,  bool expanded)  setRowExpanded,required TResult Function( String exerciseLocalId,  EquipmentType? equipment)  exerciseEquipmentChanged,required TResult Function( String exerciseLocalId,  String? note)  exerciseNoteChanged,required TResult Function( String exerciseLocalId,  double? targetWeight)  exerciseTargetChanged,required TResult Function()  celebrationDismissed,required TResult Function()  finishRequested,}) {final _that = this;
switch (_that) {
case SessionStarted():
return started(_that.exercises,_that.planId,_that.dayIndex,_that.planTotalDays,_that.focus);case ExercisePreFilled():
return exercisePreFilled(_that.exerciseLocalId,_that.setMetrics);case SetRowValue():
return setRowValue(_that.exerciseLocalId,_that.setLocalId,_that.metricKey,_that.value);case StepRowValue():
return stepRowValue(_that.exerciseLocalId,_that.setLocalId,_that.metricKey,_that.delta);case RowToggled():
return rowToggled(_that.exerciseLocalId,_that.setLocalId);case SetAdded():
return setAdded(_that.exerciseLocalId);case SetRemoved():
return setRemoved(_that.exerciseLocalId,_that.setLocalId);case ExerciseReordered():
return exerciseReordered(_that.oldIndex,_that.newIndex);case ExerciseToggled():
return exerciseToggled(_that.exerciseLocalId);case AdhocExerciseAdded():
return adhocExerciseAdded(_that.exercise);case StopwatchToggled():
return stopwatchToggled();case RestTimerStarted():
return restTimerStarted(_that.seconds);case RestTimerAdjusted():
return restTimerAdjusted(_that.delta);case RestTimerTicked():
return restTimerTicked();case RestTimerSkipped():
return restTimerSkipped();case SetRowExpanded():
return setRowExpanded(_that.exerciseLocalId,_that.setLocalId,_that.expanded);case ExerciseEquipmentChanged():
return exerciseEquipmentChanged(_that.exerciseLocalId,_that.equipment);case ExerciseNoteChanged():
return exerciseNoteChanged(_that.exerciseLocalId,_that.note);case ExerciseTargetChanged():
return exerciseTargetChanged(_that.exerciseLocalId,_that.targetWeight);case CelebrationDismissed():
return celebrationDismissed();case FinishRequested():
return finishRequested();}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( List<ExerciseEntry> exercises,  int? planId,  int? dayIndex,  int? planTotalDays,  String? focus)?  started,TResult? Function( String exerciseLocalId,  List<Map<String, double>> setMetrics)?  exercisePreFilled,TResult? Function( String exerciseLocalId,  String setLocalId,  String metricKey,  double value)?  setRowValue,TResult? Function( String exerciseLocalId,  String setLocalId,  String metricKey,  double delta)?  stepRowValue,TResult? Function( String exerciseLocalId,  String setLocalId)?  rowToggled,TResult? Function( String exerciseLocalId)?  setAdded,TResult? Function( String exerciseLocalId,  String setLocalId)?  setRemoved,TResult? Function( int oldIndex,  int newIndex)?  exerciseReordered,TResult? Function( String exerciseLocalId)?  exerciseToggled,TResult? Function( ExerciseEntry exercise)?  adhocExerciseAdded,TResult? Function()?  stopwatchToggled,TResult? Function( int seconds)?  restTimerStarted,TResult? Function( int delta)?  restTimerAdjusted,TResult? Function()?  restTimerTicked,TResult? Function()?  restTimerSkipped,TResult? Function( String exerciseLocalId,  String setLocalId,  bool expanded)?  setRowExpanded,TResult? Function( String exerciseLocalId,  EquipmentType? equipment)?  exerciseEquipmentChanged,TResult? Function( String exerciseLocalId,  String? note)?  exerciseNoteChanged,TResult? Function( String exerciseLocalId,  double? targetWeight)?  exerciseTargetChanged,TResult? Function()?  celebrationDismissed,TResult? Function()?  finishRequested,}) {final _that = this;
switch (_that) {
case SessionStarted() when started != null:
return started(_that.exercises,_that.planId,_that.dayIndex,_that.planTotalDays,_that.focus);case ExercisePreFilled() when exercisePreFilled != null:
return exercisePreFilled(_that.exerciseLocalId,_that.setMetrics);case SetRowValue() when setRowValue != null:
return setRowValue(_that.exerciseLocalId,_that.setLocalId,_that.metricKey,_that.value);case StepRowValue() when stepRowValue != null:
return stepRowValue(_that.exerciseLocalId,_that.setLocalId,_that.metricKey,_that.delta);case RowToggled() when rowToggled != null:
return rowToggled(_that.exerciseLocalId,_that.setLocalId);case SetAdded() when setAdded != null:
return setAdded(_that.exerciseLocalId);case SetRemoved() when setRemoved != null:
return setRemoved(_that.exerciseLocalId,_that.setLocalId);case ExerciseReordered() when exerciseReordered != null:
return exerciseReordered(_that.oldIndex,_that.newIndex);case ExerciseToggled() when exerciseToggled != null:
return exerciseToggled(_that.exerciseLocalId);case AdhocExerciseAdded() when adhocExerciseAdded != null:
return adhocExerciseAdded(_that.exercise);case StopwatchToggled() when stopwatchToggled != null:
return stopwatchToggled();case RestTimerStarted() when restTimerStarted != null:
return restTimerStarted(_that.seconds);case RestTimerAdjusted() when restTimerAdjusted != null:
return restTimerAdjusted(_that.delta);case RestTimerTicked() when restTimerTicked != null:
return restTimerTicked();case RestTimerSkipped() when restTimerSkipped != null:
return restTimerSkipped();case SetRowExpanded() when setRowExpanded != null:
return setRowExpanded(_that.exerciseLocalId,_that.setLocalId,_that.expanded);case ExerciseEquipmentChanged() when exerciseEquipmentChanged != null:
return exerciseEquipmentChanged(_that.exerciseLocalId,_that.equipment);case ExerciseNoteChanged() when exerciseNoteChanged != null:
return exerciseNoteChanged(_that.exerciseLocalId,_that.note);case ExerciseTargetChanged() when exerciseTargetChanged != null:
return exerciseTargetChanged(_that.exerciseLocalId,_that.targetWeight);case CelebrationDismissed() when celebrationDismissed != null:
return celebrationDismissed();case FinishRequested() when finishRequested != null:
return finishRequested();case _:
  return null;

}
}

}

/// @nodoc


class SessionStarted implements SessionEvent {
  const SessionStarted({required final  List<ExerciseEntry> exercises, this.planId, this.dayIndex, this.planTotalDays, this.focus}): _exercises = exercises;
  

 final  List<ExerciseEntry> _exercises;
 List<ExerciseEntry> get exercises {
  if (_exercises is EqualUnmodifiableListView) return _exercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exercises);
}

 final  int? planId;
 final  int? dayIndex;
 final  int? planTotalDays;
 final  String? focus;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionStartedCopyWith<SessionStarted> get copyWith => _$SessionStartedCopyWithImpl<SessionStarted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionStarted&&const DeepCollectionEquality().equals(other._exercises, _exercises)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.dayIndex, dayIndex) || other.dayIndex == dayIndex)&&(identical(other.planTotalDays, planTotalDays) || other.planTotalDays == planTotalDays)&&(identical(other.focus, focus) || other.focus == focus));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_exercises),planId,dayIndex,planTotalDays,focus);

@override
String toString() {
  return 'SessionEvent.started(exercises: $exercises, planId: $planId, dayIndex: $dayIndex, planTotalDays: $planTotalDays, focus: $focus)';
}


}

/// @nodoc
abstract mixin class $SessionStartedCopyWith<$Res> implements $SessionEventCopyWith<$Res> {
  factory $SessionStartedCopyWith(SessionStarted value, $Res Function(SessionStarted) _then) = _$SessionStartedCopyWithImpl;
@useResult
$Res call({
 List<ExerciseEntry> exercises, int? planId, int? dayIndex, int? planTotalDays, String? focus
});




}
/// @nodoc
class _$SessionStartedCopyWithImpl<$Res>
    implements $SessionStartedCopyWith<$Res> {
  _$SessionStartedCopyWithImpl(this._self, this._then);

  final SessionStarted _self;
  final $Res Function(SessionStarted) _then;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exercises = null,Object? planId = freezed,Object? dayIndex = freezed,Object? planTotalDays = freezed,Object? focus = freezed,}) {
  return _then(SessionStarted(
exercises: null == exercises ? _self._exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<ExerciseEntry>,planId: freezed == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int?,dayIndex: freezed == dayIndex ? _self.dayIndex : dayIndex // ignore: cast_nullable_to_non_nullable
as int?,planTotalDays: freezed == planTotalDays ? _self.planTotalDays : planTotalDays // ignore: cast_nullable_to_non_nullable
as int?,focus: freezed == focus ? _self.focus : focus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ExercisePreFilled implements SessionEvent {
  const ExercisePreFilled({required this.exerciseLocalId, required final  List<Map<String, double>> setMetrics}): _setMetrics = setMetrics;
  

 final  String exerciseLocalId;
 final  List<Map<String, double>> _setMetrics;
 List<Map<String, double>> get setMetrics {
  if (_setMetrics is EqualUnmodifiableListView) return _setMetrics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_setMetrics);
}


/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExercisePreFilledCopyWith<ExercisePreFilled> get copyWith => _$ExercisePreFilledCopyWithImpl<ExercisePreFilled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExercisePreFilled&&(identical(other.exerciseLocalId, exerciseLocalId) || other.exerciseLocalId == exerciseLocalId)&&const DeepCollectionEquality().equals(other._setMetrics, _setMetrics));
}


@override
int get hashCode => Object.hash(runtimeType,exerciseLocalId,const DeepCollectionEquality().hash(_setMetrics));

@override
String toString() {
  return 'SessionEvent.exercisePreFilled(exerciseLocalId: $exerciseLocalId, setMetrics: $setMetrics)';
}


}

/// @nodoc
abstract mixin class $ExercisePreFilledCopyWith<$Res> implements $SessionEventCopyWith<$Res> {
  factory $ExercisePreFilledCopyWith(ExercisePreFilled value, $Res Function(ExercisePreFilled) _then) = _$ExercisePreFilledCopyWithImpl;
@useResult
$Res call({
 String exerciseLocalId, List<Map<String, double>> setMetrics
});




}
/// @nodoc
class _$ExercisePreFilledCopyWithImpl<$Res>
    implements $ExercisePreFilledCopyWith<$Res> {
  _$ExercisePreFilledCopyWithImpl(this._self, this._then);

  final ExercisePreFilled _self;
  final $Res Function(ExercisePreFilled) _then;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exerciseLocalId = null,Object? setMetrics = null,}) {
  return _then(ExercisePreFilled(
exerciseLocalId: null == exerciseLocalId ? _self.exerciseLocalId : exerciseLocalId // ignore: cast_nullable_to_non_nullable
as String,setMetrics: null == setMetrics ? _self._setMetrics : setMetrics // ignore: cast_nullable_to_non_nullable
as List<Map<String, double>>,
  ));
}


}

/// @nodoc


class SetRowValue implements SessionEvent {
  const SetRowValue({required this.exerciseLocalId, required this.setLocalId, required this.metricKey, required this.value});
  

 final  String exerciseLocalId;
 final  String setLocalId;
 final  String metricKey;
 final  double value;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetRowValueCopyWith<SetRowValue> get copyWith => _$SetRowValueCopyWithImpl<SetRowValue>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetRowValue&&(identical(other.exerciseLocalId, exerciseLocalId) || other.exerciseLocalId == exerciseLocalId)&&(identical(other.setLocalId, setLocalId) || other.setLocalId == setLocalId)&&(identical(other.metricKey, metricKey) || other.metricKey == metricKey)&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode => Object.hash(runtimeType,exerciseLocalId,setLocalId,metricKey,value);

@override
String toString() {
  return 'SessionEvent.setRowValue(exerciseLocalId: $exerciseLocalId, setLocalId: $setLocalId, metricKey: $metricKey, value: $value)';
}


}

/// @nodoc
abstract mixin class $SetRowValueCopyWith<$Res> implements $SessionEventCopyWith<$Res> {
  factory $SetRowValueCopyWith(SetRowValue value, $Res Function(SetRowValue) _then) = _$SetRowValueCopyWithImpl;
@useResult
$Res call({
 String exerciseLocalId, String setLocalId, String metricKey, double value
});




}
/// @nodoc
class _$SetRowValueCopyWithImpl<$Res>
    implements $SetRowValueCopyWith<$Res> {
  _$SetRowValueCopyWithImpl(this._self, this._then);

  final SetRowValue _self;
  final $Res Function(SetRowValue) _then;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exerciseLocalId = null,Object? setLocalId = null,Object? metricKey = null,Object? value = null,}) {
  return _then(SetRowValue(
exerciseLocalId: null == exerciseLocalId ? _self.exerciseLocalId : exerciseLocalId // ignore: cast_nullable_to_non_nullable
as String,setLocalId: null == setLocalId ? _self.setLocalId : setLocalId // ignore: cast_nullable_to_non_nullable
as String,metricKey: null == metricKey ? _self.metricKey : metricKey // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class StepRowValue implements SessionEvent {
  const StepRowValue({required this.exerciseLocalId, required this.setLocalId, required this.metricKey, required this.delta});
  

 final  String exerciseLocalId;
 final  String setLocalId;
 final  String metricKey;
 final  double delta;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StepRowValueCopyWith<StepRowValue> get copyWith => _$StepRowValueCopyWithImpl<StepRowValue>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StepRowValue&&(identical(other.exerciseLocalId, exerciseLocalId) || other.exerciseLocalId == exerciseLocalId)&&(identical(other.setLocalId, setLocalId) || other.setLocalId == setLocalId)&&(identical(other.metricKey, metricKey) || other.metricKey == metricKey)&&(identical(other.delta, delta) || other.delta == delta));
}


@override
int get hashCode => Object.hash(runtimeType,exerciseLocalId,setLocalId,metricKey,delta);

@override
String toString() {
  return 'SessionEvent.stepRowValue(exerciseLocalId: $exerciseLocalId, setLocalId: $setLocalId, metricKey: $metricKey, delta: $delta)';
}


}

/// @nodoc
abstract mixin class $StepRowValueCopyWith<$Res> implements $SessionEventCopyWith<$Res> {
  factory $StepRowValueCopyWith(StepRowValue value, $Res Function(StepRowValue) _then) = _$StepRowValueCopyWithImpl;
@useResult
$Res call({
 String exerciseLocalId, String setLocalId, String metricKey, double delta
});




}
/// @nodoc
class _$StepRowValueCopyWithImpl<$Res>
    implements $StepRowValueCopyWith<$Res> {
  _$StepRowValueCopyWithImpl(this._self, this._then);

  final StepRowValue _self;
  final $Res Function(StepRowValue) _then;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exerciseLocalId = null,Object? setLocalId = null,Object? metricKey = null,Object? delta = null,}) {
  return _then(StepRowValue(
exerciseLocalId: null == exerciseLocalId ? _self.exerciseLocalId : exerciseLocalId // ignore: cast_nullable_to_non_nullable
as String,setLocalId: null == setLocalId ? _self.setLocalId : setLocalId // ignore: cast_nullable_to_non_nullable
as String,metricKey: null == metricKey ? _self.metricKey : metricKey // ignore: cast_nullable_to_non_nullable
as String,delta: null == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class RowToggled implements SessionEvent {
  const RowToggled({required this.exerciseLocalId, required this.setLocalId});
  

 final  String exerciseLocalId;
 final  String setLocalId;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RowToggledCopyWith<RowToggled> get copyWith => _$RowToggledCopyWithImpl<RowToggled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RowToggled&&(identical(other.exerciseLocalId, exerciseLocalId) || other.exerciseLocalId == exerciseLocalId)&&(identical(other.setLocalId, setLocalId) || other.setLocalId == setLocalId));
}


@override
int get hashCode => Object.hash(runtimeType,exerciseLocalId,setLocalId);

@override
String toString() {
  return 'SessionEvent.rowToggled(exerciseLocalId: $exerciseLocalId, setLocalId: $setLocalId)';
}


}

/// @nodoc
abstract mixin class $RowToggledCopyWith<$Res> implements $SessionEventCopyWith<$Res> {
  factory $RowToggledCopyWith(RowToggled value, $Res Function(RowToggled) _then) = _$RowToggledCopyWithImpl;
@useResult
$Res call({
 String exerciseLocalId, String setLocalId
});




}
/// @nodoc
class _$RowToggledCopyWithImpl<$Res>
    implements $RowToggledCopyWith<$Res> {
  _$RowToggledCopyWithImpl(this._self, this._then);

  final RowToggled _self;
  final $Res Function(RowToggled) _then;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exerciseLocalId = null,Object? setLocalId = null,}) {
  return _then(RowToggled(
exerciseLocalId: null == exerciseLocalId ? _self.exerciseLocalId : exerciseLocalId // ignore: cast_nullable_to_non_nullable
as String,setLocalId: null == setLocalId ? _self.setLocalId : setLocalId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SetAdded implements SessionEvent {
  const SetAdded(this.exerciseLocalId);
  

 final  String exerciseLocalId;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetAddedCopyWith<SetAdded> get copyWith => _$SetAddedCopyWithImpl<SetAdded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetAdded&&(identical(other.exerciseLocalId, exerciseLocalId) || other.exerciseLocalId == exerciseLocalId));
}


@override
int get hashCode => Object.hash(runtimeType,exerciseLocalId);

@override
String toString() {
  return 'SessionEvent.setAdded(exerciseLocalId: $exerciseLocalId)';
}


}

/// @nodoc
abstract mixin class $SetAddedCopyWith<$Res> implements $SessionEventCopyWith<$Res> {
  factory $SetAddedCopyWith(SetAdded value, $Res Function(SetAdded) _then) = _$SetAddedCopyWithImpl;
@useResult
$Res call({
 String exerciseLocalId
});




}
/// @nodoc
class _$SetAddedCopyWithImpl<$Res>
    implements $SetAddedCopyWith<$Res> {
  _$SetAddedCopyWithImpl(this._self, this._then);

  final SetAdded _self;
  final $Res Function(SetAdded) _then;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exerciseLocalId = null,}) {
  return _then(SetAdded(
null == exerciseLocalId ? _self.exerciseLocalId : exerciseLocalId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SetRemoved implements SessionEvent {
  const SetRemoved({required this.exerciseLocalId, required this.setLocalId});
  

 final  String exerciseLocalId;
 final  String setLocalId;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetRemovedCopyWith<SetRemoved> get copyWith => _$SetRemovedCopyWithImpl<SetRemoved>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetRemoved&&(identical(other.exerciseLocalId, exerciseLocalId) || other.exerciseLocalId == exerciseLocalId)&&(identical(other.setLocalId, setLocalId) || other.setLocalId == setLocalId));
}


@override
int get hashCode => Object.hash(runtimeType,exerciseLocalId,setLocalId);

@override
String toString() {
  return 'SessionEvent.setRemoved(exerciseLocalId: $exerciseLocalId, setLocalId: $setLocalId)';
}


}

/// @nodoc
abstract mixin class $SetRemovedCopyWith<$Res> implements $SessionEventCopyWith<$Res> {
  factory $SetRemovedCopyWith(SetRemoved value, $Res Function(SetRemoved) _then) = _$SetRemovedCopyWithImpl;
@useResult
$Res call({
 String exerciseLocalId, String setLocalId
});




}
/// @nodoc
class _$SetRemovedCopyWithImpl<$Res>
    implements $SetRemovedCopyWith<$Res> {
  _$SetRemovedCopyWithImpl(this._self, this._then);

  final SetRemoved _self;
  final $Res Function(SetRemoved) _then;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exerciseLocalId = null,Object? setLocalId = null,}) {
  return _then(SetRemoved(
exerciseLocalId: null == exerciseLocalId ? _self.exerciseLocalId : exerciseLocalId // ignore: cast_nullable_to_non_nullable
as String,setLocalId: null == setLocalId ? _self.setLocalId : setLocalId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ExerciseReordered implements SessionEvent {
  const ExerciseReordered({required this.oldIndex, required this.newIndex});
  

 final  int oldIndex;
 final  int newIndex;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExerciseReorderedCopyWith<ExerciseReordered> get copyWith => _$ExerciseReorderedCopyWithImpl<ExerciseReordered>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExerciseReordered&&(identical(other.oldIndex, oldIndex) || other.oldIndex == oldIndex)&&(identical(other.newIndex, newIndex) || other.newIndex == newIndex));
}


@override
int get hashCode => Object.hash(runtimeType,oldIndex,newIndex);

@override
String toString() {
  return 'SessionEvent.exerciseReordered(oldIndex: $oldIndex, newIndex: $newIndex)';
}


}

/// @nodoc
abstract mixin class $ExerciseReorderedCopyWith<$Res> implements $SessionEventCopyWith<$Res> {
  factory $ExerciseReorderedCopyWith(ExerciseReordered value, $Res Function(ExerciseReordered) _then) = _$ExerciseReorderedCopyWithImpl;
@useResult
$Res call({
 int oldIndex, int newIndex
});




}
/// @nodoc
class _$ExerciseReorderedCopyWithImpl<$Res>
    implements $ExerciseReorderedCopyWith<$Res> {
  _$ExerciseReorderedCopyWithImpl(this._self, this._then);

  final ExerciseReordered _self;
  final $Res Function(ExerciseReordered) _then;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? oldIndex = null,Object? newIndex = null,}) {
  return _then(ExerciseReordered(
oldIndex: null == oldIndex ? _self.oldIndex : oldIndex // ignore: cast_nullable_to_non_nullable
as int,newIndex: null == newIndex ? _self.newIndex : newIndex // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class ExerciseToggled implements SessionEvent {
  const ExerciseToggled(this.exerciseLocalId);
  

 final  String exerciseLocalId;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExerciseToggledCopyWith<ExerciseToggled> get copyWith => _$ExerciseToggledCopyWithImpl<ExerciseToggled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExerciseToggled&&(identical(other.exerciseLocalId, exerciseLocalId) || other.exerciseLocalId == exerciseLocalId));
}


@override
int get hashCode => Object.hash(runtimeType,exerciseLocalId);

@override
String toString() {
  return 'SessionEvent.exerciseToggled(exerciseLocalId: $exerciseLocalId)';
}


}

/// @nodoc
abstract mixin class $ExerciseToggledCopyWith<$Res> implements $SessionEventCopyWith<$Res> {
  factory $ExerciseToggledCopyWith(ExerciseToggled value, $Res Function(ExerciseToggled) _then) = _$ExerciseToggledCopyWithImpl;
@useResult
$Res call({
 String exerciseLocalId
});




}
/// @nodoc
class _$ExerciseToggledCopyWithImpl<$Res>
    implements $ExerciseToggledCopyWith<$Res> {
  _$ExerciseToggledCopyWithImpl(this._self, this._then);

  final ExerciseToggled _self;
  final $Res Function(ExerciseToggled) _then;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exerciseLocalId = null,}) {
  return _then(ExerciseToggled(
null == exerciseLocalId ? _self.exerciseLocalId : exerciseLocalId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AdhocExerciseAdded implements SessionEvent {
  const AdhocExerciseAdded(this.exercise);
  

 final  ExerciseEntry exercise;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdhocExerciseAddedCopyWith<AdhocExerciseAdded> get copyWith => _$AdhocExerciseAddedCopyWithImpl<AdhocExerciseAdded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdhocExerciseAdded&&(identical(other.exercise, exercise) || other.exercise == exercise));
}


@override
int get hashCode => Object.hash(runtimeType,exercise);

@override
String toString() {
  return 'SessionEvent.adhocExerciseAdded(exercise: $exercise)';
}


}

/// @nodoc
abstract mixin class $AdhocExerciseAddedCopyWith<$Res> implements $SessionEventCopyWith<$Res> {
  factory $AdhocExerciseAddedCopyWith(AdhocExerciseAdded value, $Res Function(AdhocExerciseAdded) _then) = _$AdhocExerciseAddedCopyWithImpl;
@useResult
$Res call({
 ExerciseEntry exercise
});


$ExerciseEntryCopyWith<$Res> get exercise;

}
/// @nodoc
class _$AdhocExerciseAddedCopyWithImpl<$Res>
    implements $AdhocExerciseAddedCopyWith<$Res> {
  _$AdhocExerciseAddedCopyWithImpl(this._self, this._then);

  final AdhocExerciseAdded _self;
  final $Res Function(AdhocExerciseAdded) _then;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exercise = null,}) {
  return _then(AdhocExerciseAdded(
null == exercise ? _self.exercise : exercise // ignore: cast_nullable_to_non_nullable
as ExerciseEntry,
  ));
}

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ExerciseEntryCopyWith<$Res> get exercise {
  
  return $ExerciseEntryCopyWith<$Res>(_self.exercise, (value) {
    return _then(_self.copyWith(exercise: value));
  });
}
}

/// @nodoc


class StopwatchToggled implements SessionEvent {
  const StopwatchToggled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StopwatchToggled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SessionEvent.stopwatchToggled()';
}


}




/// @nodoc


class RestTimerStarted implements SessionEvent {
  const RestTimerStarted(this.seconds);
  

 final  int seconds;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RestTimerStartedCopyWith<RestTimerStarted> get copyWith => _$RestTimerStartedCopyWithImpl<RestTimerStarted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RestTimerStarted&&(identical(other.seconds, seconds) || other.seconds == seconds));
}


@override
int get hashCode => Object.hash(runtimeType,seconds);

@override
String toString() {
  return 'SessionEvent.restTimerStarted(seconds: $seconds)';
}


}

/// @nodoc
abstract mixin class $RestTimerStartedCopyWith<$Res> implements $SessionEventCopyWith<$Res> {
  factory $RestTimerStartedCopyWith(RestTimerStarted value, $Res Function(RestTimerStarted) _then) = _$RestTimerStartedCopyWithImpl;
@useResult
$Res call({
 int seconds
});




}
/// @nodoc
class _$RestTimerStartedCopyWithImpl<$Res>
    implements $RestTimerStartedCopyWith<$Res> {
  _$RestTimerStartedCopyWithImpl(this._self, this._then);

  final RestTimerStarted _self;
  final $Res Function(RestTimerStarted) _then;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? seconds = null,}) {
  return _then(RestTimerStarted(
null == seconds ? _self.seconds : seconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class RestTimerAdjusted implements SessionEvent {
  const RestTimerAdjusted(this.delta);
  

 final  int delta;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RestTimerAdjustedCopyWith<RestTimerAdjusted> get copyWith => _$RestTimerAdjustedCopyWithImpl<RestTimerAdjusted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RestTimerAdjusted&&(identical(other.delta, delta) || other.delta == delta));
}


@override
int get hashCode => Object.hash(runtimeType,delta);

@override
String toString() {
  return 'SessionEvent.restTimerAdjusted(delta: $delta)';
}


}

/// @nodoc
abstract mixin class $RestTimerAdjustedCopyWith<$Res> implements $SessionEventCopyWith<$Res> {
  factory $RestTimerAdjustedCopyWith(RestTimerAdjusted value, $Res Function(RestTimerAdjusted) _then) = _$RestTimerAdjustedCopyWithImpl;
@useResult
$Res call({
 int delta
});




}
/// @nodoc
class _$RestTimerAdjustedCopyWithImpl<$Res>
    implements $RestTimerAdjustedCopyWith<$Res> {
  _$RestTimerAdjustedCopyWithImpl(this._self, this._then);

  final RestTimerAdjusted _self;
  final $Res Function(RestTimerAdjusted) _then;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? delta = null,}) {
  return _then(RestTimerAdjusted(
null == delta ? _self.delta : delta // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class RestTimerTicked implements SessionEvent {
  const RestTimerTicked();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RestTimerTicked);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SessionEvent.restTimerTicked()';
}


}




/// @nodoc


class RestTimerSkipped implements SessionEvent {
  const RestTimerSkipped();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RestTimerSkipped);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SessionEvent.restTimerSkipped()';
}


}




/// @nodoc


class SetRowExpanded implements SessionEvent {
  const SetRowExpanded({required this.exerciseLocalId, required this.setLocalId, required this.expanded});
  

 final  String exerciseLocalId;
 final  String setLocalId;
 final  bool expanded;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetRowExpandedCopyWith<SetRowExpanded> get copyWith => _$SetRowExpandedCopyWithImpl<SetRowExpanded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetRowExpanded&&(identical(other.exerciseLocalId, exerciseLocalId) || other.exerciseLocalId == exerciseLocalId)&&(identical(other.setLocalId, setLocalId) || other.setLocalId == setLocalId)&&(identical(other.expanded, expanded) || other.expanded == expanded));
}


@override
int get hashCode => Object.hash(runtimeType,exerciseLocalId,setLocalId,expanded);

@override
String toString() {
  return 'SessionEvent.setRowExpanded(exerciseLocalId: $exerciseLocalId, setLocalId: $setLocalId, expanded: $expanded)';
}


}

/// @nodoc
abstract mixin class $SetRowExpandedCopyWith<$Res> implements $SessionEventCopyWith<$Res> {
  factory $SetRowExpandedCopyWith(SetRowExpanded value, $Res Function(SetRowExpanded) _then) = _$SetRowExpandedCopyWithImpl;
@useResult
$Res call({
 String exerciseLocalId, String setLocalId, bool expanded
});




}
/// @nodoc
class _$SetRowExpandedCopyWithImpl<$Res>
    implements $SetRowExpandedCopyWith<$Res> {
  _$SetRowExpandedCopyWithImpl(this._self, this._then);

  final SetRowExpanded _self;
  final $Res Function(SetRowExpanded) _then;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exerciseLocalId = null,Object? setLocalId = null,Object? expanded = null,}) {
  return _then(SetRowExpanded(
exerciseLocalId: null == exerciseLocalId ? _self.exerciseLocalId : exerciseLocalId // ignore: cast_nullable_to_non_nullable
as String,setLocalId: null == setLocalId ? _self.setLocalId : setLocalId // ignore: cast_nullable_to_non_nullable
as String,expanded: null == expanded ? _self.expanded : expanded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class ExerciseEquipmentChanged implements SessionEvent {
  const ExerciseEquipmentChanged({required this.exerciseLocalId, required this.equipment});
  

 final  String exerciseLocalId;
 final  EquipmentType? equipment;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExerciseEquipmentChangedCopyWith<ExerciseEquipmentChanged> get copyWith => _$ExerciseEquipmentChangedCopyWithImpl<ExerciseEquipmentChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExerciseEquipmentChanged&&(identical(other.exerciseLocalId, exerciseLocalId) || other.exerciseLocalId == exerciseLocalId)&&(identical(other.equipment, equipment) || other.equipment == equipment));
}


@override
int get hashCode => Object.hash(runtimeType,exerciseLocalId,equipment);

@override
String toString() {
  return 'SessionEvent.exerciseEquipmentChanged(exerciseLocalId: $exerciseLocalId, equipment: $equipment)';
}


}

/// @nodoc
abstract mixin class $ExerciseEquipmentChangedCopyWith<$Res> implements $SessionEventCopyWith<$Res> {
  factory $ExerciseEquipmentChangedCopyWith(ExerciseEquipmentChanged value, $Res Function(ExerciseEquipmentChanged) _then) = _$ExerciseEquipmentChangedCopyWithImpl;
@useResult
$Res call({
 String exerciseLocalId, EquipmentType? equipment
});




}
/// @nodoc
class _$ExerciseEquipmentChangedCopyWithImpl<$Res>
    implements $ExerciseEquipmentChangedCopyWith<$Res> {
  _$ExerciseEquipmentChangedCopyWithImpl(this._self, this._then);

  final ExerciseEquipmentChanged _self;
  final $Res Function(ExerciseEquipmentChanged) _then;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exerciseLocalId = null,Object? equipment = freezed,}) {
  return _then(ExerciseEquipmentChanged(
exerciseLocalId: null == exerciseLocalId ? _self.exerciseLocalId : exerciseLocalId // ignore: cast_nullable_to_non_nullable
as String,equipment: freezed == equipment ? _self.equipment : equipment // ignore: cast_nullable_to_non_nullable
as EquipmentType?,
  ));
}


}

/// @nodoc


class ExerciseNoteChanged implements SessionEvent {
  const ExerciseNoteChanged({required this.exerciseLocalId, required this.note});
  

 final  String exerciseLocalId;
 final  String? note;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExerciseNoteChangedCopyWith<ExerciseNoteChanged> get copyWith => _$ExerciseNoteChangedCopyWithImpl<ExerciseNoteChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExerciseNoteChanged&&(identical(other.exerciseLocalId, exerciseLocalId) || other.exerciseLocalId == exerciseLocalId)&&(identical(other.note, note) || other.note == note));
}


@override
int get hashCode => Object.hash(runtimeType,exerciseLocalId,note);

@override
String toString() {
  return 'SessionEvent.exerciseNoteChanged(exerciseLocalId: $exerciseLocalId, note: $note)';
}


}

/// @nodoc
abstract mixin class $ExerciseNoteChangedCopyWith<$Res> implements $SessionEventCopyWith<$Res> {
  factory $ExerciseNoteChangedCopyWith(ExerciseNoteChanged value, $Res Function(ExerciseNoteChanged) _then) = _$ExerciseNoteChangedCopyWithImpl;
@useResult
$Res call({
 String exerciseLocalId, String? note
});




}
/// @nodoc
class _$ExerciseNoteChangedCopyWithImpl<$Res>
    implements $ExerciseNoteChangedCopyWith<$Res> {
  _$ExerciseNoteChangedCopyWithImpl(this._self, this._then);

  final ExerciseNoteChanged _self;
  final $Res Function(ExerciseNoteChanged) _then;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exerciseLocalId = null,Object? note = freezed,}) {
  return _then(ExerciseNoteChanged(
exerciseLocalId: null == exerciseLocalId ? _self.exerciseLocalId : exerciseLocalId // ignore: cast_nullable_to_non_nullable
as String,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ExerciseTargetChanged implements SessionEvent {
  const ExerciseTargetChanged({required this.exerciseLocalId, required this.targetWeight});
  

 final  String exerciseLocalId;
 final  double? targetWeight;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExerciseTargetChangedCopyWith<ExerciseTargetChanged> get copyWith => _$ExerciseTargetChangedCopyWithImpl<ExerciseTargetChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExerciseTargetChanged&&(identical(other.exerciseLocalId, exerciseLocalId) || other.exerciseLocalId == exerciseLocalId)&&(identical(other.targetWeight, targetWeight) || other.targetWeight == targetWeight));
}


@override
int get hashCode => Object.hash(runtimeType,exerciseLocalId,targetWeight);

@override
String toString() {
  return 'SessionEvent.exerciseTargetChanged(exerciseLocalId: $exerciseLocalId, targetWeight: $targetWeight)';
}


}

/// @nodoc
abstract mixin class $ExerciseTargetChangedCopyWith<$Res> implements $SessionEventCopyWith<$Res> {
  factory $ExerciseTargetChangedCopyWith(ExerciseTargetChanged value, $Res Function(ExerciseTargetChanged) _then) = _$ExerciseTargetChangedCopyWithImpl;
@useResult
$Res call({
 String exerciseLocalId, double? targetWeight
});




}
/// @nodoc
class _$ExerciseTargetChangedCopyWithImpl<$Res>
    implements $ExerciseTargetChangedCopyWith<$Res> {
  _$ExerciseTargetChangedCopyWithImpl(this._self, this._then);

  final ExerciseTargetChanged _self;
  final $Res Function(ExerciseTargetChanged) _then;

/// Create a copy of SessionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exerciseLocalId = null,Object? targetWeight = freezed,}) {
  return _then(ExerciseTargetChanged(
exerciseLocalId: null == exerciseLocalId ? _self.exerciseLocalId : exerciseLocalId // ignore: cast_nullable_to_non_nullable
as String,targetWeight: freezed == targetWeight ? _self.targetWeight : targetWeight // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

/// @nodoc


class CelebrationDismissed implements SessionEvent {
  const CelebrationDismissed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CelebrationDismissed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SessionEvent.celebrationDismissed()';
}


}




/// @nodoc


class FinishRequested implements SessionEvent {
  const FinishRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FinishRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SessionEvent.finishRequested()';
}


}




// dart format on
