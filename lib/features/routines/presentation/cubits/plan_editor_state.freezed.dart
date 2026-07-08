// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_editor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlanEditorState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanEditorState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PlanEditorState()';
}


}

/// @nodoc
class $PlanEditorStateCopyWith<$Res>  {
$PlanEditorStateCopyWith(PlanEditorState _, $Res Function(PlanEditorState) __);
}


/// Adds pattern-matching-related methods to [PlanEditorState].
extension PlanEditorStatePatterns on PlanEditorState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PlanEditorInitial value)?  initial,TResult Function( PlanEditorLoading value)?  loading,TResult Function( PlanEditorLoaded value)?  loaded,TResult Function( PlanEditorError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PlanEditorInitial() when initial != null:
return initial(_that);case PlanEditorLoading() when loading != null:
return loading(_that);case PlanEditorLoaded() when loaded != null:
return loaded(_that);case PlanEditorError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PlanEditorInitial value)  initial,required TResult Function( PlanEditorLoading value)  loading,required TResult Function( PlanEditorLoaded value)  loaded,required TResult Function( PlanEditorError value)  error,}){
final _that = this;
switch (_that) {
case PlanEditorInitial():
return initial(_that);case PlanEditorLoading():
return loading(_that);case PlanEditorLoaded():
return loaded(_that);case PlanEditorError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PlanEditorInitial value)?  initial,TResult? Function( PlanEditorLoading value)?  loading,TResult? Function( PlanEditorLoaded value)?  loaded,TResult? Function( PlanEditorError value)?  error,}){
final _that = this;
switch (_that) {
case PlanEditorInitial() when initial != null:
return initial(_that);case PlanEditorLoading() when loading != null:
return loading(_that);case PlanEditorLoaded() when loaded != null:
return loaded(_that);case PlanEditorError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( Plan plan,  List<PlanDayDetail> days)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PlanEditorInitial() when initial != null:
return initial();case PlanEditorLoading() when loading != null:
return loading();case PlanEditorLoaded() when loaded != null:
return loaded(_that.plan,_that.days);case PlanEditorError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( Plan plan,  List<PlanDayDetail> days)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case PlanEditorInitial():
return initial();case PlanEditorLoading():
return loading();case PlanEditorLoaded():
return loaded(_that.plan,_that.days);case PlanEditorError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( Plan plan,  List<PlanDayDetail> days)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case PlanEditorInitial() when initial != null:
return initial();case PlanEditorLoading() when loading != null:
return loading();case PlanEditorLoaded() when loaded != null:
return loaded(_that.plan,_that.days);case PlanEditorError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class PlanEditorInitial implements PlanEditorState {
  const PlanEditorInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanEditorInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PlanEditorState.initial()';
}


}




/// @nodoc


class PlanEditorLoading implements PlanEditorState {
  const PlanEditorLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanEditorLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PlanEditorState.loading()';
}


}




/// @nodoc


class PlanEditorLoaded implements PlanEditorState {
  const PlanEditorLoaded({required this.plan, required final  List<PlanDayDetail> days}): _days = days;
  

 final  Plan plan;
 final  List<PlanDayDetail> _days;
 List<PlanDayDetail> get days {
  if (_days is EqualUnmodifiableListView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_days);
}


/// Create a copy of PlanEditorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanEditorLoadedCopyWith<PlanEditorLoaded> get copyWith => _$PlanEditorLoadedCopyWithImpl<PlanEditorLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanEditorLoaded&&(identical(other.plan, plan) || other.plan == plan)&&const DeepCollectionEquality().equals(other._days, _days));
}


@override
int get hashCode => Object.hash(runtimeType,plan,const DeepCollectionEquality().hash(_days));

@override
String toString() {
  return 'PlanEditorState.loaded(plan: $plan, days: $days)';
}


}

/// @nodoc
abstract mixin class $PlanEditorLoadedCopyWith<$Res> implements $PlanEditorStateCopyWith<$Res> {
  factory $PlanEditorLoadedCopyWith(PlanEditorLoaded value, $Res Function(PlanEditorLoaded) _then) = _$PlanEditorLoadedCopyWithImpl;
@useResult
$Res call({
 Plan plan, List<PlanDayDetail> days
});


$PlanCopyWith<$Res> get plan;

}
/// @nodoc
class _$PlanEditorLoadedCopyWithImpl<$Res>
    implements $PlanEditorLoadedCopyWith<$Res> {
  _$PlanEditorLoadedCopyWithImpl(this._self, this._then);

  final PlanEditorLoaded _self;
  final $Res Function(PlanEditorLoaded) _then;

/// Create a copy of PlanEditorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? plan = null,Object? days = null,}) {
  return _then(PlanEditorLoaded(
plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as Plan,days: null == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as List<PlanDayDetail>,
  ));
}

/// Create a copy of PlanEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanCopyWith<$Res> get plan {
  
  return $PlanCopyWith<$Res>(_self.plan, (value) {
    return _then(_self.copyWith(plan: value));
  });
}
}

/// @nodoc


class PlanEditorError implements PlanEditorState {
  const PlanEditorError(this.message);
  

 final  String message;

/// Create a copy of PlanEditorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanEditorErrorCopyWith<PlanEditorError> get copyWith => _$PlanEditorErrorCopyWithImpl<PlanEditorError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanEditorError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'PlanEditorState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $PlanEditorErrorCopyWith<$Res> implements $PlanEditorStateCopyWith<$Res> {
  factory $PlanEditorErrorCopyWith(PlanEditorError value, $Res Function(PlanEditorError) _then) = _$PlanEditorErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$PlanEditorErrorCopyWithImpl<$Res>
    implements $PlanEditorErrorCopyWith<$Res> {
  _$PlanEditorErrorCopyWithImpl(this._self, this._then);

  final PlanEditorError _self;
  final $Res Function(PlanEditorError) _then;

/// Create a copy of PlanEditorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(PlanEditorError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
