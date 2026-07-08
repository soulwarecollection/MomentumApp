// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_exercise.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SessionExercise {

 int get id; int get sessionId; int get orderIndex; String get name; Modality get modality; String? get equipment;
/// Create a copy of SessionExercise
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionExerciseCopyWith<SessionExercise> get copyWith => _$SessionExerciseCopyWithImpl<SessionExercise>(this as SessionExercise, _$identity);

  /// Serializes this SessionExercise to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SessionExercise&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex)&&(identical(other.name, name) || other.name == name)&&(identical(other.modality, modality) || other.modality == modality)&&(identical(other.equipment, equipment) || other.equipment == equipment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sessionId,orderIndex,name,modality,equipment);

@override
String toString() {
  return 'SessionExercise(id: $id, sessionId: $sessionId, orderIndex: $orderIndex, name: $name, modality: $modality, equipment: $equipment)';
}


}

/// @nodoc
abstract mixin class $SessionExerciseCopyWith<$Res>  {
  factory $SessionExerciseCopyWith(SessionExercise value, $Res Function(SessionExercise) _then) = _$SessionExerciseCopyWithImpl;
@useResult
$Res call({
 int id, int sessionId, int orderIndex, String name, Modality modality, String? equipment
});




}
/// @nodoc
class _$SessionExerciseCopyWithImpl<$Res>
    implements $SessionExerciseCopyWith<$Res> {
  _$SessionExerciseCopyWithImpl(this._self, this._then);

  final SessionExercise _self;
  final $Res Function(SessionExercise) _then;

/// Create a copy of SessionExercise
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? sessionId = null,Object? orderIndex = null,Object? name = null,Object? modality = null,Object? equipment = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,modality: null == modality ? _self.modality : modality // ignore: cast_nullable_to_non_nullable
as Modality,equipment: freezed == equipment ? _self.equipment : equipment // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SessionExercise].
extension SessionExercisePatterns on SessionExercise {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SessionExercise value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SessionExercise() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SessionExercise value)  $default,){
final _that = this;
switch (_that) {
case _SessionExercise():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SessionExercise value)?  $default,){
final _that = this;
switch (_that) {
case _SessionExercise() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int sessionId,  int orderIndex,  String name,  Modality modality,  String? equipment)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SessionExercise() when $default != null:
return $default(_that.id,_that.sessionId,_that.orderIndex,_that.name,_that.modality,_that.equipment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int sessionId,  int orderIndex,  String name,  Modality modality,  String? equipment)  $default,) {final _that = this;
switch (_that) {
case _SessionExercise():
return $default(_that.id,_that.sessionId,_that.orderIndex,_that.name,_that.modality,_that.equipment);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int sessionId,  int orderIndex,  String name,  Modality modality,  String? equipment)?  $default,) {final _that = this;
switch (_that) {
case _SessionExercise() when $default != null:
return $default(_that.id,_that.sessionId,_that.orderIndex,_that.name,_that.modality,_that.equipment);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SessionExercise implements SessionExercise {
  const _SessionExercise({required this.id, required this.sessionId, required this.orderIndex, required this.name, required this.modality, this.equipment});
  factory _SessionExercise.fromJson(Map<String, dynamic> json) => _$SessionExerciseFromJson(json);

@override final  int id;
@override final  int sessionId;
@override final  int orderIndex;
@override final  String name;
@override final  Modality modality;
@override final  String? equipment;

/// Create a copy of SessionExercise
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionExerciseCopyWith<_SessionExercise> get copyWith => __$SessionExerciseCopyWithImpl<_SessionExercise>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionExerciseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SessionExercise&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex)&&(identical(other.name, name) || other.name == name)&&(identical(other.modality, modality) || other.modality == modality)&&(identical(other.equipment, equipment) || other.equipment == equipment));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sessionId,orderIndex,name,modality,equipment);

@override
String toString() {
  return 'SessionExercise(id: $id, sessionId: $sessionId, orderIndex: $orderIndex, name: $name, modality: $modality, equipment: $equipment)';
}


}

/// @nodoc
abstract mixin class _$SessionExerciseCopyWith<$Res> implements $SessionExerciseCopyWith<$Res> {
  factory _$SessionExerciseCopyWith(_SessionExercise value, $Res Function(_SessionExercise) _then) = __$SessionExerciseCopyWithImpl;
@override @useResult
$Res call({
 int id, int sessionId, int orderIndex, String name, Modality modality, String? equipment
});




}
/// @nodoc
class __$SessionExerciseCopyWithImpl<$Res>
    implements _$SessionExerciseCopyWith<$Res> {
  __$SessionExerciseCopyWithImpl(this._self, this._then);

  final _SessionExercise _self;
  final $Res Function(_SessionExercise) _then;

/// Create a copy of SessionExercise
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sessionId = null,Object? orderIndex = null,Object? name = null,Object? modality = null,Object? equipment = freezed,}) {
  return _then(_SessionExercise(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,sessionId: null == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as int,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,modality: null == modality ? _self.modality : modality // ignore: cast_nullable_to_non_nullable
as Modality,equipment: freezed == equipment ? _self.equipment : equipment // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
