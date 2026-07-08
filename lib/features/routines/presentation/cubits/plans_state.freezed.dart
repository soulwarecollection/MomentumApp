// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plans_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlansState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlansState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PlansState()';
}


}

/// @nodoc
class $PlansStateCopyWith<$Res>  {
$PlansStateCopyWith(PlansState _, $Res Function(PlansState) __);
}


/// Adds pattern-matching-related methods to [PlansState].
extension PlansStatePatterns on PlansState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PlansInitial value)?  initial,TResult Function( PlansLoading value)?  loading,TResult Function( PlansLoaded value)?  loaded,TResult Function( PlansError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PlansInitial() when initial != null:
return initial(_that);case PlansLoading() when loading != null:
return loading(_that);case PlansLoaded() when loaded != null:
return loaded(_that);case PlansError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PlansInitial value)  initial,required TResult Function( PlansLoading value)  loading,required TResult Function( PlansLoaded value)  loaded,required TResult Function( PlansError value)  error,}){
final _that = this;
switch (_that) {
case PlansInitial():
return initial(_that);case PlansLoading():
return loading(_that);case PlansLoaded():
return loaded(_that);case PlansError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PlansInitial value)?  initial,TResult? Function( PlansLoading value)?  loading,TResult? Function( PlansLoaded value)?  loaded,TResult? Function( PlansError value)?  error,}){
final _that = this;
switch (_that) {
case PlansInitial() when initial != null:
return initial(_that);case PlansLoading() when loading != null:
return loading(_that);case PlansLoaded() when loaded != null:
return loaded(_that);case PlansError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Plan> plans)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PlansInitial() when initial != null:
return initial();case PlansLoading() when loading != null:
return loading();case PlansLoaded() when loaded != null:
return loaded(_that.plans);case PlansError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Plan> plans)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case PlansInitial():
return initial();case PlansLoading():
return loading();case PlansLoaded():
return loaded(_that.plans);case PlansError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Plan> plans)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case PlansInitial() when initial != null:
return initial();case PlansLoading() when loading != null:
return loading();case PlansLoaded() when loaded != null:
return loaded(_that.plans);case PlansError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class PlansInitial implements PlansState {
  const PlansInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlansInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PlansState.initial()';
}


}




/// @nodoc


class PlansLoading implements PlansState {
  const PlansLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlansLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PlansState.loading()';
}


}




/// @nodoc


class PlansLoaded implements PlansState {
  const PlansLoaded(final  List<Plan> plans): _plans = plans;
  

 final  List<Plan> _plans;
 List<Plan> get plans {
  if (_plans is EqualUnmodifiableListView) return _plans;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_plans);
}


/// Create a copy of PlansState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlansLoadedCopyWith<PlansLoaded> get copyWith => _$PlansLoadedCopyWithImpl<PlansLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlansLoaded&&const DeepCollectionEquality().equals(other._plans, _plans));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_plans));

@override
String toString() {
  return 'PlansState.loaded(plans: $plans)';
}


}

/// @nodoc
abstract mixin class $PlansLoadedCopyWith<$Res> implements $PlansStateCopyWith<$Res> {
  factory $PlansLoadedCopyWith(PlansLoaded value, $Res Function(PlansLoaded) _then) = _$PlansLoadedCopyWithImpl;
@useResult
$Res call({
 List<Plan> plans
});




}
/// @nodoc
class _$PlansLoadedCopyWithImpl<$Res>
    implements $PlansLoadedCopyWith<$Res> {
  _$PlansLoadedCopyWithImpl(this._self, this._then);

  final PlansLoaded _self;
  final $Res Function(PlansLoaded) _then;

/// Create a copy of PlansState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? plans = null,}) {
  return _then(PlansLoaded(
null == plans ? _self._plans : plans // ignore: cast_nullable_to_non_nullable
as List<Plan>,
  ));
}


}

/// @nodoc


class PlansError implements PlansState {
  const PlansError(this.message);
  

 final  String message;

/// Create a copy of PlansState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlansErrorCopyWith<PlansError> get copyWith => _$PlansErrorCopyWithImpl<PlansError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlansError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'PlansState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $PlansErrorCopyWith<$Res> implements $PlansStateCopyWith<$Res> {
  factory $PlansErrorCopyWith(PlansError value, $Res Function(PlansError) _then) = _$PlansErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$PlansErrorCopyWithImpl<$Res>
    implements $PlansErrorCopyWith<$Res> {
  _$PlansErrorCopyWithImpl(this._self, this._then);

  final PlansError _self;
  final $Res Function(PlansError) _then;

/// Create a copy of PlansState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(PlansError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
