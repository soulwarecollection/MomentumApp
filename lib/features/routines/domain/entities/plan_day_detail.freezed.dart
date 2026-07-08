// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_day_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlanDayDetail {

 PlanDay get day; List<PlanExercise> get exercises;
/// Create a copy of PlanDayDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanDayDetailCopyWith<PlanDayDetail> get copyWith => _$PlanDayDetailCopyWithImpl<PlanDayDetail>(this as PlanDayDetail, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanDayDetail&&(identical(other.day, day) || other.day == day)&&const DeepCollectionEquality().equals(other.exercises, exercises));
}


@override
int get hashCode => Object.hash(runtimeType,day,const DeepCollectionEquality().hash(exercises));

@override
String toString() {
  return 'PlanDayDetail(day: $day, exercises: $exercises)';
}


}

/// @nodoc
abstract mixin class $PlanDayDetailCopyWith<$Res>  {
  factory $PlanDayDetailCopyWith(PlanDayDetail value, $Res Function(PlanDayDetail) _then) = _$PlanDayDetailCopyWithImpl;
@useResult
$Res call({
 PlanDay day, List<PlanExercise> exercises
});


$PlanDayCopyWith<$Res> get day;

}
/// @nodoc
class _$PlanDayDetailCopyWithImpl<$Res>
    implements $PlanDayDetailCopyWith<$Res> {
  _$PlanDayDetailCopyWithImpl(this._self, this._then);

  final PlanDayDetail _self;
  final $Res Function(PlanDayDetail) _then;

/// Create a copy of PlanDayDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? day = null,Object? exercises = null,}) {
  return _then(_self.copyWith(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as PlanDay,exercises: null == exercises ? _self.exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<PlanExercise>,
  ));
}
/// Create a copy of PlanDayDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanDayCopyWith<$Res> get day {
  
  return $PlanDayCopyWith<$Res>(_self.day, (value) {
    return _then(_self.copyWith(day: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlanDayDetail].
extension PlanDayDetailPatterns on PlanDayDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanDayDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanDayDetail() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanDayDetail value)  $default,){
final _that = this;
switch (_that) {
case _PlanDayDetail():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanDayDetail value)?  $default,){
final _that = this;
switch (_that) {
case _PlanDayDetail() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PlanDay day,  List<PlanExercise> exercises)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanDayDetail() when $default != null:
return $default(_that.day,_that.exercises);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PlanDay day,  List<PlanExercise> exercises)  $default,) {final _that = this;
switch (_that) {
case _PlanDayDetail():
return $default(_that.day,_that.exercises);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PlanDay day,  List<PlanExercise> exercises)?  $default,) {final _that = this;
switch (_that) {
case _PlanDayDetail() when $default != null:
return $default(_that.day,_that.exercises);case _:
  return null;

}
}

}

/// @nodoc


class _PlanDayDetail implements PlanDayDetail {
  const _PlanDayDetail({required this.day, required final  List<PlanExercise> exercises}): _exercises = exercises;
  

@override final  PlanDay day;
 final  List<PlanExercise> _exercises;
@override List<PlanExercise> get exercises {
  if (_exercises is EqualUnmodifiableListView) return _exercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exercises);
}


/// Create a copy of PlanDayDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanDayDetailCopyWith<_PlanDayDetail> get copyWith => __$PlanDayDetailCopyWithImpl<_PlanDayDetail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanDayDetail&&(identical(other.day, day) || other.day == day)&&const DeepCollectionEquality().equals(other._exercises, _exercises));
}


@override
int get hashCode => Object.hash(runtimeType,day,const DeepCollectionEquality().hash(_exercises));

@override
String toString() {
  return 'PlanDayDetail(day: $day, exercises: $exercises)';
}


}

/// @nodoc
abstract mixin class _$PlanDayDetailCopyWith<$Res> implements $PlanDayDetailCopyWith<$Res> {
  factory _$PlanDayDetailCopyWith(_PlanDayDetail value, $Res Function(_PlanDayDetail) _then) = __$PlanDayDetailCopyWithImpl;
@override @useResult
$Res call({
 PlanDay day, List<PlanExercise> exercises
});


@override $PlanDayCopyWith<$Res> get day;

}
/// @nodoc
class __$PlanDayDetailCopyWithImpl<$Res>
    implements _$PlanDayDetailCopyWith<$Res> {
  __$PlanDayDetailCopyWithImpl(this._self, this._then);

  final _PlanDayDetail _self;
  final $Res Function(_PlanDayDetail) _then;

/// Create a copy of PlanDayDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? day = null,Object? exercises = null,}) {
  return _then(_PlanDayDetail(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as PlanDay,exercises: null == exercises ? _self._exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<PlanExercise>,
  ));
}

/// Create a copy of PlanDayDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlanDayCopyWith<$Res> get day {
  
  return $PlanDayCopyWith<$Res>(_self.day, (value) {
    return _then(_self.copyWith(day: value));
  });
}
}

// dart format on
