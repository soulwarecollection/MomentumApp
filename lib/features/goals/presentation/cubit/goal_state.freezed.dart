// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goal_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GoalState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GoalState()';
}


}

/// @nodoc
class $GoalStateCopyWith<$Res>  {
$GoalStateCopyWith(GoalState _, $Res Function(GoalState) __);
}


/// Adds pattern-matching-related methods to [GoalState].
extension GoalStatePatterns on GoalState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( GoalLoading value)?  loading,TResult Function( GoalNoGoal value)?  noGoal,TResult Function( GoalActive value)?  active,TResult Function( GoalError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case GoalLoading() when loading != null:
return loading(_that);case GoalNoGoal() when noGoal != null:
return noGoal(_that);case GoalActive() when active != null:
return active(_that);case GoalError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( GoalLoading value)  loading,required TResult Function( GoalNoGoal value)  noGoal,required TResult Function( GoalActive value)  active,required TResult Function( GoalError value)  error,}){
final _that = this;
switch (_that) {
case GoalLoading():
return loading(_that);case GoalNoGoal():
return noGoal(_that);case GoalActive():
return active(_that);case GoalError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( GoalLoading value)?  loading,TResult? Function( GoalNoGoal value)?  noGoal,TResult? Function( GoalActive value)?  active,TResult? Function( GoalError value)?  error,}){
final _that = this;
switch (_that) {
case GoalLoading() when loading != null:
return loading(_that);case GoalNoGoal() when noGoal != null:
return noGoal(_that);case GoalActive() when active != null:
return active(_that);case GoalError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function()?  noGoal,TResult Function( GoalProgress progress)?  active,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case GoalLoading() when loading != null:
return loading();case GoalNoGoal() when noGoal != null:
return noGoal();case GoalActive() when active != null:
return active(_that.progress);case GoalError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function()  noGoal,required TResult Function( GoalProgress progress)  active,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case GoalLoading():
return loading();case GoalNoGoal():
return noGoal();case GoalActive():
return active(_that.progress);case GoalError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function()?  noGoal,TResult? Function( GoalProgress progress)?  active,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case GoalLoading() when loading != null:
return loading();case GoalNoGoal() when noGoal != null:
return noGoal();case GoalActive() when active != null:
return active(_that.progress);case GoalError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class GoalLoading implements GoalState {
  const GoalLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GoalState.loading()';
}


}




/// @nodoc


class GoalNoGoal implements GoalState {
  const GoalNoGoal();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalNoGoal);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GoalState.noGoal()';
}


}




/// @nodoc


class GoalActive implements GoalState {
  const GoalActive(this.progress);
  

 final  GoalProgress progress;

/// Create a copy of GoalState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalActiveCopyWith<GoalActive> get copyWith => _$GoalActiveCopyWithImpl<GoalActive>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalActive&&(identical(other.progress, progress) || other.progress == progress));
}


@override
int get hashCode => Object.hash(runtimeType,progress);

@override
String toString() {
  return 'GoalState.active(progress: $progress)';
}


}

/// @nodoc
abstract mixin class $GoalActiveCopyWith<$Res> implements $GoalStateCopyWith<$Res> {
  factory $GoalActiveCopyWith(GoalActive value, $Res Function(GoalActive) _then) = _$GoalActiveCopyWithImpl;
@useResult
$Res call({
 GoalProgress progress
});




}
/// @nodoc
class _$GoalActiveCopyWithImpl<$Res>
    implements $GoalActiveCopyWith<$Res> {
  _$GoalActiveCopyWithImpl(this._self, this._then);

  final GoalActive _self;
  final $Res Function(GoalActive) _then;

/// Create a copy of GoalState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? progress = null,}) {
  return _then(GoalActive(
null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as GoalProgress,
  ));
}


}

/// @nodoc


class GoalError implements GoalState {
  const GoalError(this.message);
  

 final  String message;

/// Create a copy of GoalState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalErrorCopyWith<GoalError> get copyWith => _$GoalErrorCopyWithImpl<GoalError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'GoalState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $GoalErrorCopyWith<$Res> implements $GoalStateCopyWith<$Res> {
  factory $GoalErrorCopyWith(GoalError value, $Res Function(GoalError) _then) = _$GoalErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$GoalErrorCopyWithImpl<$Res>
    implements $GoalErrorCopyWith<$Res> {
  _$GoalErrorCopyWithImpl(this._self, this._then);

  final GoalError _self;
  final $Res Function(GoalError) _then;

/// Create a copy of GoalState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(GoalError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
