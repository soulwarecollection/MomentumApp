// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SessionDetailState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionDetailState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SessionDetailState()';
}


}

/// @nodoc
class $SessionDetailStateCopyWith<$Res>  {
$SessionDetailStateCopyWith(SessionDetailState _, $Res Function(SessionDetailState) __);
}


/// Adds pattern-matching-related methods to [SessionDetailState].
extension SessionDetailStatePatterns on SessionDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SessionDetailLoading value)?  loading,TResult Function( SessionDetailReady value)?  ready,TResult Function( SessionDetailError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SessionDetailLoading() when loading != null:
return loading(_that);case SessionDetailReady() when ready != null:
return ready(_that);case SessionDetailError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SessionDetailLoading value)  loading,required TResult Function( SessionDetailReady value)  ready,required TResult Function( SessionDetailError value)  error,}){
final _that = this;
switch (_that) {
case SessionDetailLoading():
return loading(_that);case SessionDetailReady():
return ready(_that);case SessionDetailError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SessionDetailLoading value)?  loading,TResult? Function( SessionDetailReady value)?  ready,TResult? Function( SessionDetailError value)?  error,}){
final _that = this;
switch (_that) {
case SessionDetailLoading() when loading != null:
return loading(_that);case SessionDetailReady() when ready != null:
return ready(_that);case SessionDetailError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( SessionSummary summary,  List<SessionExerciseDetail> exercises)?  ready,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SessionDetailLoading() when loading != null:
return loading();case SessionDetailReady() when ready != null:
return ready(_that.summary,_that.exercises);case SessionDetailError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( SessionSummary summary,  List<SessionExerciseDetail> exercises)  ready,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case SessionDetailLoading():
return loading();case SessionDetailReady():
return ready(_that.summary,_that.exercises);case SessionDetailError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( SessionSummary summary,  List<SessionExerciseDetail> exercises)?  ready,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case SessionDetailLoading() when loading != null:
return loading();case SessionDetailReady() when ready != null:
return ready(_that.summary,_that.exercises);case SessionDetailError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class SessionDetailLoading implements SessionDetailState {
  const SessionDetailLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionDetailLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SessionDetailState.loading()';
}


}




/// @nodoc


class SessionDetailReady implements SessionDetailState {
  const SessionDetailReady({required this.summary, required final  List<SessionExerciseDetail> exercises}): _exercises = exercises;
  

 final  SessionSummary summary;
 final  List<SessionExerciseDetail> _exercises;
 List<SessionExerciseDetail> get exercises {
  if (_exercises is EqualUnmodifiableListView) return _exercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exercises);
}


/// Create a copy of SessionDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionDetailReadyCopyWith<SessionDetailReady> get copyWith => _$SessionDetailReadyCopyWithImpl<SessionDetailReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionDetailReady&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other._exercises, _exercises));
}


@override
int get hashCode => Object.hash(runtimeType,summary,const DeepCollectionEquality().hash(_exercises));

@override
String toString() {
  return 'SessionDetailState.ready(summary: $summary, exercises: $exercises)';
}


}

/// @nodoc
abstract mixin class $SessionDetailReadyCopyWith<$Res> implements $SessionDetailStateCopyWith<$Res> {
  factory $SessionDetailReadyCopyWith(SessionDetailReady value, $Res Function(SessionDetailReady) _then) = _$SessionDetailReadyCopyWithImpl;
@useResult
$Res call({
 SessionSummary summary, List<SessionExerciseDetail> exercises
});




}
/// @nodoc
class _$SessionDetailReadyCopyWithImpl<$Res>
    implements $SessionDetailReadyCopyWith<$Res> {
  _$SessionDetailReadyCopyWithImpl(this._self, this._then);

  final SessionDetailReady _self;
  final $Res Function(SessionDetailReady) _then;

/// Create a copy of SessionDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? summary = null,Object? exercises = null,}) {
  return _then(SessionDetailReady(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as SessionSummary,exercises: null == exercises ? _self._exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<SessionExerciseDetail>,
  ));
}


}

/// @nodoc


class SessionDetailError implements SessionDetailState {
  const SessionDetailError(this.message);
  

 final  String message;

/// Create a copy of SessionDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionDetailErrorCopyWith<SessionDetailError> get copyWith => _$SessionDetailErrorCopyWithImpl<SessionDetailError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionDetailError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SessionDetailState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $SessionDetailErrorCopyWith<$Res> implements $SessionDetailStateCopyWith<$Res> {
  factory $SessionDetailErrorCopyWith(SessionDetailError value, $Res Function(SessionDetailError) _then) = _$SessionDetailErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SessionDetailErrorCopyWithImpl<$Res>
    implements $SessionDetailErrorCopyWith<$Res> {
  _$SessionDetailErrorCopyWithImpl(this._self, this._then);

  final SessionDetailError _self;
  final $Res Function(SessionDetailError) _then;

/// Create a copy of SessionDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SessionDetailError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
