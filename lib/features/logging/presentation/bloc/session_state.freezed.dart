// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SessionState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SessionState()';
}


}

/// @nodoc
class $SessionStateCopyWith<$Res>  {
$SessionStateCopyWith(SessionState _, $Res Function(SessionState) __);
}


/// Adds pattern-matching-related methods to [SessionState].
extension SessionStatePatterns on SessionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SessionIdle value)?  idle,TResult Function( SessionActive value)?  active,TResult Function( SessionSaving value)?  saving,TResult Function( SessionFinished value)?  finished,TResult Function( SessionError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SessionIdle() when idle != null:
return idle(_that);case SessionActive() when active != null:
return active(_that);case SessionSaving() when saving != null:
return saving(_that);case SessionFinished() when finished != null:
return finished(_that);case SessionError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SessionIdle value)  idle,required TResult Function( SessionActive value)  active,required TResult Function( SessionSaving value)  saving,required TResult Function( SessionFinished value)  finished,required TResult Function( SessionError value)  error,}){
final _that = this;
switch (_that) {
case SessionIdle():
return idle(_that);case SessionActive():
return active(_that);case SessionSaving():
return saving(_that);case SessionFinished():
return finished(_that);case SessionError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SessionIdle value)?  idle,TResult? Function( SessionActive value)?  active,TResult? Function( SessionSaving value)?  saving,TResult? Function( SessionFinished value)?  finished,TResult? Function( SessionError value)?  error,}){
final _that = this;
switch (_that) {
case SessionIdle() when idle != null:
return idle(_that);case SessionActive() when active != null:
return active(_that);case SessionSaving() when saving != null:
return saving(_that);case SessionFinished() when finished != null:
return finished(_that);case SessionError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  idle,TResult Function( int sessionId,  List<ExerciseEntry> exercises,  bool stopwatchRunning,  int totalPausedMs,  DateTime? stopwatchStartedAt,  DateTime? stopwatchPausedAt,  int? restSecondsLeft,  int? restSecondsTotal,  String? celebrationExercise,  String? focus,  int? planId,  int? dayIndex,  int? planTotalDays)?  active,TResult Function()?  saving,TResult Function()?  finished,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SessionIdle() when idle != null:
return idle();case SessionActive() when active != null:
return active(_that.sessionId,_that.exercises,_that.stopwatchRunning,_that.totalPausedMs,_that.stopwatchStartedAt,_that.stopwatchPausedAt,_that.restSecondsLeft,_that.restSecondsTotal,_that.celebrationExercise,_that.focus,_that.planId,_that.dayIndex,_that.planTotalDays);case SessionSaving() when saving != null:
return saving();case SessionFinished() when finished != null:
return finished();case SessionError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  idle,required TResult Function( int sessionId,  List<ExerciseEntry> exercises,  bool stopwatchRunning,  int totalPausedMs,  DateTime? stopwatchStartedAt,  DateTime? stopwatchPausedAt,  int? restSecondsLeft,  int? restSecondsTotal,  String? celebrationExercise,  String? focus,  int? planId,  int? dayIndex,  int? planTotalDays)  active,required TResult Function()  saving,required TResult Function()  finished,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case SessionIdle():
return idle();case SessionActive():
return active(_that.sessionId,_that.exercises,_that.stopwatchRunning,_that.totalPausedMs,_that.stopwatchStartedAt,_that.stopwatchPausedAt,_that.restSecondsLeft,_that.restSecondsTotal,_that.celebrationExercise,_that.focus,_that.planId,_that.dayIndex,_that.planTotalDays);case SessionSaving():
return saving();case SessionFinished():
return finished();case SessionError():
return error(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  idle,TResult? Function( int sessionId,  List<ExerciseEntry> exercises,  bool stopwatchRunning,  int totalPausedMs,  DateTime? stopwatchStartedAt,  DateTime? stopwatchPausedAt,  int? restSecondsLeft,  int? restSecondsTotal,  String? celebrationExercise,  String? focus,  int? planId,  int? dayIndex,  int? planTotalDays)?  active,TResult? Function()?  saving,TResult? Function()?  finished,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case SessionIdle() when idle != null:
return idle();case SessionActive() when active != null:
return active(_that.sessionId,_that.exercises,_that.stopwatchRunning,_that.totalPausedMs,_that.stopwatchStartedAt,_that.stopwatchPausedAt,_that.restSecondsLeft,_that.restSecondsTotal,_that.celebrationExercise,_that.focus,_that.planId,_that.dayIndex,_that.planTotalDays);case SessionSaving() when saving != null:
return saving();case SessionFinished() when finished != null:
return finished();case SessionError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class SessionIdle implements SessionState {
  const SessionIdle();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionIdle);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SessionState.idle()';
}


}




/// @nodoc


class SessionActive implements SessionState {
  const SessionActive({required this.sessionId, required final  List<ExerciseEntry> exercises, this.stopwatchRunning = false, this.totalPausedMs = 0, this.stopwatchStartedAt, this.stopwatchPausedAt, this.restSecondsLeft, this.restSecondsTotal, this.celebrationExercise, this.focus, this.planId, this.dayIndex, this.planTotalDays}): _exercises = exercises;
  

 final  int sessionId;
 final  List<ExerciseEntry> _exercises;
 List<ExerciseEntry> get exercises {
  if (_exercises is EqualUnmodifiableListView) return _exercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exercises);
}

@JsonKey() final  bool stopwatchRunning;
@JsonKey() final  int totalPausedMs;
 final  DateTime? stopwatchStartedAt;
 final  DateTime? stopwatchPausedAt;
 final  int? restSecondsLeft;
 final  int? restSecondsTotal;
 final  String? celebrationExercise;
 final  String? focus;
 final  int? planId;
 final  int? dayIndex;
 final  int? planTotalDays;

/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionActiveCopyWith<SessionActive> get copyWith => _$SessionActiveCopyWithImpl<SessionActive>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionActive&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&const DeepCollectionEquality().equals(other._exercises, _exercises)&&(identical(other.stopwatchRunning, stopwatchRunning) || other.stopwatchRunning == stopwatchRunning)&&(identical(other.totalPausedMs, totalPausedMs) || other.totalPausedMs == totalPausedMs)&&(identical(other.stopwatchStartedAt, stopwatchStartedAt) || other.stopwatchStartedAt == stopwatchStartedAt)&&(identical(other.stopwatchPausedAt, stopwatchPausedAt) || other.stopwatchPausedAt == stopwatchPausedAt)&&(identical(other.restSecondsLeft, restSecondsLeft) || other.restSecondsLeft == restSecondsLeft)&&(identical(other.restSecondsTotal, restSecondsTotal) || other.restSecondsTotal == restSecondsTotal)&&(identical(other.celebrationExercise, celebrationExercise) || other.celebrationExercise == celebrationExercise)&&(identical(other.focus, focus) || other.focus == focus)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.dayIndex, dayIndex) || other.dayIndex == dayIndex)&&(identical(other.planTotalDays, planTotalDays) || other.planTotalDays == planTotalDays));
}


@override
int get hashCode => Object.hash(runtimeType,sessionId,const DeepCollectionEquality().hash(_exercises),stopwatchRunning,totalPausedMs,stopwatchStartedAt,stopwatchPausedAt,restSecondsLeft,restSecondsTotal,celebrationExercise,focus,planId,dayIndex,planTotalDays);

@override
String toString() {
  return 'SessionState.active(sessionId: $sessionId, exercises: $exercises, stopwatchRunning: $stopwatchRunning, totalPausedMs: $totalPausedMs, stopwatchStartedAt: $stopwatchStartedAt, stopwatchPausedAt: $stopwatchPausedAt, restSecondsLeft: $restSecondsLeft, restSecondsTotal: $restSecondsTotal, celebrationExercise: $celebrationExercise, focus: $focus, planId: $planId, dayIndex: $dayIndex, planTotalDays: $planTotalDays)';
}


}

/// @nodoc
abstract mixin class $SessionActiveCopyWith<$Res> implements $SessionStateCopyWith<$Res> {
  factory $SessionActiveCopyWith(SessionActive value, $Res Function(SessionActive) _then) = _$SessionActiveCopyWithImpl;
@useResult
$Res call({
 int sessionId, List<ExerciseEntry> exercises, bool stopwatchRunning, int totalPausedMs, DateTime? stopwatchStartedAt, DateTime? stopwatchPausedAt, int? restSecondsLeft, int? restSecondsTotal, String? celebrationExercise, String? focus, int? planId, int? dayIndex, int? planTotalDays
});




}
/// @nodoc
class _$SessionActiveCopyWithImpl<$Res>
    implements $SessionActiveCopyWith<$Res> {
  _$SessionActiveCopyWithImpl(this._self, this._then);

  final SessionActive _self;
  final $Res Function(SessionActive) _then;

/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sessionId = null,Object? exercises = null,Object? stopwatchRunning = null,Object? totalPausedMs = null,Object? stopwatchStartedAt = freezed,Object? stopwatchPausedAt = freezed,Object? restSecondsLeft = freezed,Object? restSecondsTotal = freezed,Object? celebrationExercise = freezed,Object? focus = freezed,Object? planId = freezed,Object? dayIndex = freezed,Object? planTotalDays = freezed,}) {
  return _then(SessionActive(
sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,exercises: null == exercises ? _self._exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<ExerciseEntry>,stopwatchRunning: null == stopwatchRunning ? _self.stopwatchRunning : stopwatchRunning // ignore: cast_nullable_to_non_nullable
as bool,totalPausedMs: null == totalPausedMs ? _self.totalPausedMs : totalPausedMs // ignore: cast_nullable_to_non_nullable
as int,stopwatchStartedAt: freezed == stopwatchStartedAt ? _self.stopwatchStartedAt : stopwatchStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,stopwatchPausedAt: freezed == stopwatchPausedAt ? _self.stopwatchPausedAt : stopwatchPausedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,restSecondsLeft: freezed == restSecondsLeft ? _self.restSecondsLeft : restSecondsLeft // ignore: cast_nullable_to_non_nullable
as int?,restSecondsTotal: freezed == restSecondsTotal ? _self.restSecondsTotal : restSecondsTotal // ignore: cast_nullable_to_non_nullable
as int?,celebrationExercise: freezed == celebrationExercise ? _self.celebrationExercise : celebrationExercise // ignore: cast_nullable_to_non_nullable
as String?,focus: freezed == focus ? _self.focus : focus // ignore: cast_nullable_to_non_nullable
as String?,planId: freezed == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int?,dayIndex: freezed == dayIndex ? _self.dayIndex : dayIndex // ignore: cast_nullable_to_non_nullable
as int?,planTotalDays: freezed == planTotalDays ? _self.planTotalDays : planTotalDays // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class SessionSaving implements SessionState {
  const SessionSaving();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionSaving);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SessionState.saving()';
}


}




/// @nodoc


class SessionFinished implements SessionState {
  const SessionFinished();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionFinished);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SessionState.finished()';
}


}




/// @nodoc


class SessionError implements SessionState {
  const SessionError(this.message);
  

 final  String message;

/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionErrorCopyWith<SessionError> get copyWith => _$SessionErrorCopyWithImpl<SessionError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SessionState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $SessionErrorCopyWith<$Res> implements $SessionStateCopyWith<$Res> {
  factory $SessionErrorCopyWith(SessionError value, $Res Function(SessionError) _then) = _$SessionErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SessionErrorCopyWithImpl<$Res>
    implements $SessionErrorCopyWith<$Res> {
  _$SessionErrorCopyWithImpl(this._self, this._then);

  final SessionError _self;
  final $Res Function(SessionError) _then;

/// Create a copy of SessionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SessionError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
