// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_exercise.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlanExercise {

 int get id; int get planDayId; int get orderIndex; String get name; String? get equipment;/// Number of target sets per session.
 int? get targetSets;/// Prescription shorthand, e.g. "3×8", "5-5-5+", "AMRAP".
 String? get scheme;/// Load target, e.g. "75 kg", "80 % 1RM", "bodyweight".
 String? get target;
/// Create a copy of PlanExercise
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlanExerciseCopyWith<PlanExercise> get copyWith => _$PlanExerciseCopyWithImpl<PlanExercise>(this as PlanExercise, _$identity);

  /// Serializes this PlanExercise to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlanExercise&&(identical(other.id, id) || other.id == id)&&(identical(other.planDayId, planDayId) || other.planDayId == planDayId)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex)&&(identical(other.name, name) || other.name == name)&&(identical(other.equipment, equipment) || other.equipment == equipment)&&(identical(other.targetSets, targetSets) || other.targetSets == targetSets)&&(identical(other.scheme, scheme) || other.scheme == scheme)&&(identical(other.target, target) || other.target == target));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,planDayId,orderIndex,name,equipment,targetSets,scheme,target);

@override
String toString() {
  return 'PlanExercise(id: $id, planDayId: $planDayId, orderIndex: $orderIndex, name: $name, equipment: $equipment, targetSets: $targetSets, scheme: $scheme, target: $target)';
}


}

/// @nodoc
abstract mixin class $PlanExerciseCopyWith<$Res>  {
  factory $PlanExerciseCopyWith(PlanExercise value, $Res Function(PlanExercise) _then) = _$PlanExerciseCopyWithImpl;
@useResult
$Res call({
 int id, int planDayId, int orderIndex, String name, String? equipment, int? targetSets, String? scheme, String? target
});




}
/// @nodoc
class _$PlanExerciseCopyWithImpl<$Res>
    implements $PlanExerciseCopyWith<$Res> {
  _$PlanExerciseCopyWithImpl(this._self, this._then);

  final PlanExercise _self;
  final $Res Function(PlanExercise) _then;

/// Create a copy of PlanExercise
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? planDayId = null,Object? orderIndex = null,Object? name = null,Object? equipment = freezed,Object? targetSets = freezed,Object? scheme = freezed,Object? target = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,planDayId: null == planDayId ? _self.planDayId : planDayId // ignore: cast_nullable_to_non_nullable
as int,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,equipment: freezed == equipment ? _self.equipment : equipment // ignore: cast_nullable_to_non_nullable
as String?,targetSets: freezed == targetSets ? _self.targetSets : targetSets // ignore: cast_nullable_to_non_nullable
as int?,scheme: freezed == scheme ? _self.scheme : scheme // ignore: cast_nullable_to_non_nullable
as String?,target: freezed == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlanExercise].
extension PlanExercisePatterns on PlanExercise {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlanExercise value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlanExercise() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlanExercise value)  $default,){
final _that = this;
switch (_that) {
case _PlanExercise():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlanExercise value)?  $default,){
final _that = this;
switch (_that) {
case _PlanExercise() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int planDayId,  int orderIndex,  String name,  String? equipment,  int? targetSets,  String? scheme,  String? target)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlanExercise() when $default != null:
return $default(_that.id,_that.planDayId,_that.orderIndex,_that.name,_that.equipment,_that.targetSets,_that.scheme,_that.target);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int planDayId,  int orderIndex,  String name,  String? equipment,  int? targetSets,  String? scheme,  String? target)  $default,) {final _that = this;
switch (_that) {
case _PlanExercise():
return $default(_that.id,_that.planDayId,_that.orderIndex,_that.name,_that.equipment,_that.targetSets,_that.scheme,_that.target);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int planDayId,  int orderIndex,  String name,  String? equipment,  int? targetSets,  String? scheme,  String? target)?  $default,) {final _that = this;
switch (_that) {
case _PlanExercise() when $default != null:
return $default(_that.id,_that.planDayId,_that.orderIndex,_that.name,_that.equipment,_that.targetSets,_that.scheme,_that.target);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlanExercise implements PlanExercise {
  const _PlanExercise({required this.id, required this.planDayId, required this.orderIndex, required this.name, this.equipment, this.targetSets, this.scheme, this.target});
  factory _PlanExercise.fromJson(Map<String, dynamic> json) => _$PlanExerciseFromJson(json);

@override final  int id;
@override final  int planDayId;
@override final  int orderIndex;
@override final  String name;
@override final  String? equipment;
/// Number of target sets per session.
@override final  int? targetSets;
/// Prescription shorthand, e.g. "3×8", "5-5-5+", "AMRAP".
@override final  String? scheme;
/// Load target, e.g. "75 kg", "80 % 1RM", "bodyweight".
@override final  String? target;

/// Create a copy of PlanExercise
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlanExerciseCopyWith<_PlanExercise> get copyWith => __$PlanExerciseCopyWithImpl<_PlanExercise>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlanExerciseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlanExercise&&(identical(other.id, id) || other.id == id)&&(identical(other.planDayId, planDayId) || other.planDayId == planDayId)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex)&&(identical(other.name, name) || other.name == name)&&(identical(other.equipment, equipment) || other.equipment == equipment)&&(identical(other.targetSets, targetSets) || other.targetSets == targetSets)&&(identical(other.scheme, scheme) || other.scheme == scheme)&&(identical(other.target, target) || other.target == target));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,planDayId,orderIndex,name,equipment,targetSets,scheme,target);

@override
String toString() {
  return 'PlanExercise(id: $id, planDayId: $planDayId, orderIndex: $orderIndex, name: $name, equipment: $equipment, targetSets: $targetSets, scheme: $scheme, target: $target)';
}


}

/// @nodoc
abstract mixin class _$PlanExerciseCopyWith<$Res> implements $PlanExerciseCopyWith<$Res> {
  factory _$PlanExerciseCopyWith(_PlanExercise value, $Res Function(_PlanExercise) _then) = __$PlanExerciseCopyWithImpl;
@override @useResult
$Res call({
 int id, int planDayId, int orderIndex, String name, String? equipment, int? targetSets, String? scheme, String? target
});




}
/// @nodoc
class __$PlanExerciseCopyWithImpl<$Res>
    implements _$PlanExerciseCopyWith<$Res> {
  __$PlanExerciseCopyWithImpl(this._self, this._then);

  final _PlanExercise _self;
  final $Res Function(_PlanExercise) _then;

/// Create a copy of PlanExercise
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? planDayId = null,Object? orderIndex = null,Object? name = null,Object? equipment = freezed,Object? targetSets = freezed,Object? scheme = freezed,Object? target = freezed,}) {
  return _then(_PlanExercise(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,planDayId: null == planDayId ? _self.planDayId : planDayId // ignore: cast_nullable_to_non_nullable
as int,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,equipment: freezed == equipment ? _self.equipment : equipment // ignore: cast_nullable_to_non_nullable
as String?,targetSets: freezed == targetSets ? _self.targetSets : targetSets // ignore: cast_nullable_to_non_nullable
as int?,scheme: freezed == scheme ? _self.scheme : scheme // ignore: cast_nullable_to_non_nullable
as String?,target: freezed == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
