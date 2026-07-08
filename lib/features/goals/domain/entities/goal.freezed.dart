// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Goal {

 int get id; GoalType get type; double get targetValue; DateTime get deadline; DateTime get createdAt; double? get startValue; String? get exerciseName;
/// Create a copy of Goal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalCopyWith<Goal> get copyWith => _$GoalCopyWithImpl<Goal>(this as Goal, _$identity);

  /// Serializes this Goal to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Goal&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.targetValue, targetValue) || other.targetValue == targetValue)&&(identical(other.deadline, deadline) || other.deadline == deadline)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.startValue, startValue) || other.startValue == startValue)&&(identical(other.exerciseName, exerciseName) || other.exerciseName == exerciseName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,targetValue,deadline,createdAt,startValue,exerciseName);

@override
String toString() {
  return 'Goal(id: $id, type: $type, targetValue: $targetValue, deadline: $deadline, createdAt: $createdAt, startValue: $startValue, exerciseName: $exerciseName)';
}


}

/// @nodoc
abstract mixin class $GoalCopyWith<$Res>  {
  factory $GoalCopyWith(Goal value, $Res Function(Goal) _then) = _$GoalCopyWithImpl;
@useResult
$Res call({
 int id, GoalType type, double targetValue, DateTime deadline, DateTime createdAt, double? startValue, String? exerciseName
});




}
/// @nodoc
class _$GoalCopyWithImpl<$Res>
    implements $GoalCopyWith<$Res> {
  _$GoalCopyWithImpl(this._self, this._then);

  final Goal _self;
  final $Res Function(Goal) _then;

/// Create a copy of Goal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? targetValue = null,Object? deadline = null,Object? createdAt = null,Object? startValue = freezed,Object? exerciseName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as GoalType,targetValue: null == targetValue ? _self.targetValue : targetValue // ignore: cast_nullable_to_non_nullable
as double,deadline: null == deadline ? _self.deadline : deadline // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,startValue: freezed == startValue ? _self.startValue : startValue // ignore: cast_nullable_to_non_nullable
as double?,exerciseName: freezed == exerciseName ? _self.exerciseName : exerciseName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Goal].
extension GoalPatterns on Goal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Goal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Goal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Goal value)  $default,){
final _that = this;
switch (_that) {
case _Goal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Goal value)?  $default,){
final _that = this;
switch (_that) {
case _Goal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  GoalType type,  double targetValue,  DateTime deadline,  DateTime createdAt,  double? startValue,  String? exerciseName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Goal() when $default != null:
return $default(_that.id,_that.type,_that.targetValue,_that.deadline,_that.createdAt,_that.startValue,_that.exerciseName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  GoalType type,  double targetValue,  DateTime deadline,  DateTime createdAt,  double? startValue,  String? exerciseName)  $default,) {final _that = this;
switch (_that) {
case _Goal():
return $default(_that.id,_that.type,_that.targetValue,_that.deadline,_that.createdAt,_that.startValue,_that.exerciseName);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  GoalType type,  double targetValue,  DateTime deadline,  DateTime createdAt,  double? startValue,  String? exerciseName)?  $default,) {final _that = this;
switch (_that) {
case _Goal() when $default != null:
return $default(_that.id,_that.type,_that.targetValue,_that.deadline,_that.createdAt,_that.startValue,_that.exerciseName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Goal implements Goal {
  const _Goal({required this.id, required this.type, required this.targetValue, required this.deadline, required this.createdAt, this.startValue, this.exerciseName});
  factory _Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);

@override final  int id;
@override final  GoalType type;
@override final  double targetValue;
@override final  DateTime deadline;
@override final  DateTime createdAt;
@override final  double? startValue;
@override final  String? exerciseName;

/// Create a copy of Goal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoalCopyWith<_Goal> get copyWith => __$GoalCopyWithImpl<_Goal>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GoalToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Goal&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.targetValue, targetValue) || other.targetValue == targetValue)&&(identical(other.deadline, deadline) || other.deadline == deadline)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.startValue, startValue) || other.startValue == startValue)&&(identical(other.exerciseName, exerciseName) || other.exerciseName == exerciseName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,targetValue,deadline,createdAt,startValue,exerciseName);

@override
String toString() {
  return 'Goal(id: $id, type: $type, targetValue: $targetValue, deadline: $deadline, createdAt: $createdAt, startValue: $startValue, exerciseName: $exerciseName)';
}


}

/// @nodoc
abstract mixin class _$GoalCopyWith<$Res> implements $GoalCopyWith<$Res> {
  factory _$GoalCopyWith(_Goal value, $Res Function(_Goal) _then) = __$GoalCopyWithImpl;
@override @useResult
$Res call({
 int id, GoalType type, double targetValue, DateTime deadline, DateTime createdAt, double? startValue, String? exerciseName
});




}
/// @nodoc
class __$GoalCopyWithImpl<$Res>
    implements _$GoalCopyWith<$Res> {
  __$GoalCopyWithImpl(this._self, this._then);

  final _Goal _self;
  final $Res Function(_Goal) _then;

/// Create a copy of Goal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? targetValue = null,Object? deadline = null,Object? createdAt = null,Object? startValue = freezed,Object? exerciseName = freezed,}) {
  return _then(_Goal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as GoalType,targetValue: null == targetValue ? _self.targetValue : targetValue // ignore: cast_nullable_to_non_nullable
as double,deadline: null == deadline ? _self.deadline : deadline // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,startValue: freezed == startValue ? _self.startValue : startValue // ignore: cast_nullable_to_non_nullable
as double?,exerciseName: freezed == exerciseName ? _self.exerciseName : exerciseName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
