// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_day.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlanDay {

 int get id; int get planId; int get orderIndex; bool get isRest; String? get focus;
/// Create a copy of PlanDay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanDayCopyWith<PlanDay> get copyWith => _$PlanDayCopyWithImpl<PlanDay>(this as PlanDay, _$identity);

  /// Serializes this PlanDay to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanDay&&(identical(other.id, id) || other.id == id)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex)&&(identical(other.isRest, isRest) || other.isRest == isRest)&&(identical(other.focus, focus) || other.focus == focus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,planId,orderIndex,isRest,focus);

@override
String toString() {
  return 'PlanDay(id: $id, planId: $planId, orderIndex: $orderIndex, isRest: $isRest, focus: $focus)';
}


}

/// @nodoc
abstract mixin class $PlanDayCopyWith<$Res>  {
  factory $PlanDayCopyWith(PlanDay value, $Res Function(PlanDay) _then) = _$PlanDayCopyWithImpl;
@useResult
$Res call({
 int id, int planId, int orderIndex, bool isRest, String? focus
});




}
/// @nodoc
class _$PlanDayCopyWithImpl<$Res>
    implements $PlanDayCopyWith<$Res> {
  _$PlanDayCopyWithImpl(this._self, this._then);

  final PlanDay _self;
  final $Res Function(PlanDay) _then;

/// Create a copy of PlanDay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? planId = null,Object? orderIndex = null,Object? isRest = null,Object? focus = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,isRest: null == isRest ? _self.isRest : isRest // ignore: cast_nullable_to_non_nullable
as bool,focus: freezed == focus ? _self.focus : focus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlanDay].
extension PlanDayPatterns on PlanDay {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanDay value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanDay() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanDay value)  $default,){
final _that = this;
switch (_that) {
case _PlanDay():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanDay value)?  $default,){
final _that = this;
switch (_that) {
case _PlanDay() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int planId,  int orderIndex,  bool isRest,  String? focus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanDay() when $default != null:
return $default(_that.id,_that.planId,_that.orderIndex,_that.isRest,_that.focus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int planId,  int orderIndex,  bool isRest,  String? focus)  $default,) {final _that = this;
switch (_that) {
case _PlanDay():
return $default(_that.id,_that.planId,_that.orderIndex,_that.isRest,_that.focus);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int planId,  int orderIndex,  bool isRest,  String? focus)?  $default,) {final _that = this;
switch (_that) {
case _PlanDay() when $default != null:
return $default(_that.id,_that.planId,_that.orderIndex,_that.isRest,_that.focus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlanDay implements PlanDay {
  const _PlanDay({required this.id, required this.planId, required this.orderIndex, required this.isRest, this.focus});
  factory _PlanDay.fromJson(Map<String, dynamic> json) => _$PlanDayFromJson(json);

@override final  int id;
@override final  int planId;
@override final  int orderIndex;
@override final  bool isRest;
@override final  String? focus;

/// Create a copy of PlanDay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanDayCopyWith<_PlanDay> get copyWith => __$PlanDayCopyWithImpl<_PlanDay>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanDayToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanDay&&(identical(other.id, id) || other.id == id)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex)&&(identical(other.isRest, isRest) || other.isRest == isRest)&&(identical(other.focus, focus) || other.focus == focus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,planId,orderIndex,isRest,focus);

@override
String toString() {
  return 'PlanDay(id: $id, planId: $planId, orderIndex: $orderIndex, isRest: $isRest, focus: $focus)';
}


}

/// @nodoc
abstract mixin class _$PlanDayCopyWith<$Res> implements $PlanDayCopyWith<$Res> {
  factory _$PlanDayCopyWith(_PlanDay value, $Res Function(_PlanDay) _then) = __$PlanDayCopyWithImpl;
@override @useResult
$Res call({
 int id, int planId, int orderIndex, bool isRest, String? focus
});




}
/// @nodoc
class __$PlanDayCopyWithImpl<$Res>
    implements _$PlanDayCopyWith<$Res> {
  __$PlanDayCopyWithImpl(this._self, this._then);

  final _PlanDay _self;
  final $Res Function(_PlanDay) _then;

/// Create a copy of PlanDay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? planId = null,Object? orderIndex = null,Object? isRest = null,Object? focus = freezed,}) {
  return _then(_PlanDay(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,planId: null == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,isRest: null == isRest ? _self.isRest : isRest // ignore: cast_nullable_to_non_nullable
as bool,focus: freezed == focus ? _self.focus : focus // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
