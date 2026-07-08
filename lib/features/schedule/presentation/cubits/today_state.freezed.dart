// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'today_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TodayState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodayState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TodayState()';
}


}

/// @nodoc
class $TodayStateCopyWith<$Res>  {
$TodayStateCopyWith(TodayState _, $Res Function(TodayState) __);
}


/// Adds pattern-matching-related methods to [TodayState].
extension TodayStatePatterns on TodayState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TodayLoading value)?  loading,TResult Function( TodayNoActivePlan value)?  noActivePlan,TResult Function( TodayReady value)?  ready,TResult Function( TodayError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TodayLoading() when loading != null:
return loading(_that);case TodayNoActivePlan() when noActivePlan != null:
return noActivePlan(_that);case TodayReady() when ready != null:
return ready(_that);case TodayError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TodayLoading value)  loading,required TResult Function( TodayNoActivePlan value)  noActivePlan,required TResult Function( TodayReady value)  ready,required TResult Function( TodayError value)  error,}){
final _that = this;
switch (_that) {
case TodayLoading():
return loading(_that);case TodayNoActivePlan():
return noActivePlan(_that);case TodayReady():
return ready(_that);case TodayError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TodayLoading value)?  loading,TResult? Function( TodayNoActivePlan value)?  noActivePlan,TResult? Function( TodayReady value)?  ready,TResult? Function( TodayError value)?  error,}){
final _that = this;
switch (_that) {
case TodayLoading() when loading != null:
return loading(_that);case TodayNoActivePlan() when noActivePlan != null:
return noActivePlan(_that);case TodayReady() when ready != null:
return ready(_that);case TodayError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function()?  noActivePlan,TResult Function( NextWorkout nextWorkout,  List<PlanDay> allDays)?  ready,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TodayLoading() when loading != null:
return loading();case TodayNoActivePlan() when noActivePlan != null:
return noActivePlan();case TodayReady() when ready != null:
return ready(_that.nextWorkout,_that.allDays);case TodayError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function()  noActivePlan,required TResult Function( NextWorkout nextWorkout,  List<PlanDay> allDays)  ready,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case TodayLoading():
return loading();case TodayNoActivePlan():
return noActivePlan();case TodayReady():
return ready(_that.nextWorkout,_that.allDays);case TodayError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function()?  noActivePlan,TResult? Function( NextWorkout nextWorkout,  List<PlanDay> allDays)?  ready,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case TodayLoading() when loading != null:
return loading();case TodayNoActivePlan() when noActivePlan != null:
return noActivePlan();case TodayReady() when ready != null:
return ready(_that.nextWorkout,_that.allDays);case TodayError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class TodayLoading implements TodayState {
  const TodayLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodayLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TodayState.loading()';
}


}




/// @nodoc


class TodayNoActivePlan implements TodayState {
  const TodayNoActivePlan();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodayNoActivePlan);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TodayState.noActivePlan()';
}


}




/// @nodoc


class TodayReady implements TodayState {
  const TodayReady({required this.nextWorkout, required final  List<PlanDay> allDays}): _allDays = allDays;
  

 final  NextWorkout nextWorkout;
 final  List<PlanDay> _allDays;
 List<PlanDay> get allDays {
  if (_allDays is EqualUnmodifiableListView) return _allDays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allDays);
}


/// Create a copy of TodayState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodayReadyCopyWith<TodayReady> get copyWith => _$TodayReadyCopyWithImpl<TodayReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodayReady&&(identical(other.nextWorkout, nextWorkout) || other.nextWorkout == nextWorkout)&&const DeepCollectionEquality().equals(other._allDays, _allDays));
}


@override
int get hashCode => Object.hash(runtimeType,nextWorkout,const DeepCollectionEquality().hash(_allDays));

@override
String toString() {
  return 'TodayState.ready(nextWorkout: $nextWorkout, allDays: $allDays)';
}


}

/// @nodoc
abstract mixin class $TodayReadyCopyWith<$Res> implements $TodayStateCopyWith<$Res> {
  factory $TodayReadyCopyWith(TodayReady value, $Res Function(TodayReady) _then) = _$TodayReadyCopyWithImpl;
@useResult
$Res call({
 NextWorkout nextWorkout, List<PlanDay> allDays
});




}
/// @nodoc
class _$TodayReadyCopyWithImpl<$Res>
    implements $TodayReadyCopyWith<$Res> {
  _$TodayReadyCopyWithImpl(this._self, this._then);

  final TodayReady _self;
  final $Res Function(TodayReady) _then;

/// Create a copy of TodayState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? nextWorkout = null,Object? allDays = null,}) {
  return _then(TodayReady(
nextWorkout: null == nextWorkout ? _self.nextWorkout : nextWorkout // ignore: cast_nullable_to_non_nullable
as NextWorkout,allDays: null == allDays ? _self._allDays : allDays // ignore: cast_nullable_to_non_nullable
as List<PlanDay>,
  ));
}


}

/// @nodoc


class TodayError implements TodayState {
  const TodayError(this.message);
  

 final  String message;

/// Create a copy of TodayState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodayErrorCopyWith<TodayError> get copyWith => _$TodayErrorCopyWithImpl<TodayError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodayError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'TodayState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $TodayErrorCopyWith<$Res> implements $TodayStateCopyWith<$Res> {
  factory $TodayErrorCopyWith(TodayError value, $Res Function(TodayError) _then) = _$TodayErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$TodayErrorCopyWithImpl<$Res>
    implements $TodayErrorCopyWith<$Res> {
  _$TodayErrorCopyWithImpl(this._self, this._then);

  final TodayError _self;
  final $Res Function(TodayError) _then;

/// Create a copy of TodayState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(TodayError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
