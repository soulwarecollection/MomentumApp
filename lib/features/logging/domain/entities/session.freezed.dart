// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Session {

 int get id; DateTime get startedAt; DateTime get updatedAt; int? get planId; int? get dayIndex; String? get focus; DateTime? get endedAt; int? get durationSeconds; String? get note; DateTime? get deletedAt;
/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SessionCopyWith<Session> get copyWith => _$SessionCopyWithImpl<Session>(this as Session, _$identity);

  /// Serializes this Session to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Session&&(identical(other.id, id) || other.id == id)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.dayIndex, dayIndex) || other.dayIndex == dayIndex)&&(identical(other.focus, focus) || other.focus == focus)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.note, note) || other.note == note)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,startedAt,updatedAt,planId,dayIndex,focus,endedAt,durationSeconds,note,deletedAt);

@override
String toString() {
  return 'Session(id: $id, startedAt: $startedAt, updatedAt: $updatedAt, planId: $planId, dayIndex: $dayIndex, focus: $focus, endedAt: $endedAt, durationSeconds: $durationSeconds, note: $note, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class $SessionCopyWith<$Res>  {
  factory $SessionCopyWith(Session value, $Res Function(Session) _then) = _$SessionCopyWithImpl;
@useResult
$Res call({
 int id, DateTime startedAt, DateTime updatedAt, int? planId, int? dayIndex, String? focus, DateTime? endedAt, int? durationSeconds, String? note, DateTime? deletedAt
});




}
/// @nodoc
class _$SessionCopyWithImpl<$Res>
    implements $SessionCopyWith<$Res> {
  _$SessionCopyWithImpl(this._self, this._then);

  final Session _self;
  final $Res Function(Session) _then;

/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? startedAt = null,Object? updatedAt = null,Object? planId = freezed,Object? dayIndex = freezed,Object? focus = freezed,Object? endedAt = freezed,Object? durationSeconds = freezed,Object? note = freezed,Object? deletedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,planId: freezed == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int?,dayIndex: freezed == dayIndex ? _self.dayIndex : dayIndex // ignore: cast_nullable_to_non_nullable
as int?,focus: freezed == focus ? _self.focus : focus // ignore: cast_nullable_to_non_nullable
as String?,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Session].
extension SessionPatterns on Session {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Session value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Session() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Session value)  $default,){
final _that = this;
switch (_that) {
case _Session():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Session value)?  $default,){
final _that = this;
switch (_that) {
case _Session() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  DateTime startedAt,  DateTime updatedAt,  int? planId,  int? dayIndex,  String? focus,  DateTime? endedAt,  int? durationSeconds,  String? note,  DateTime? deletedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Session() when $default != null:
return $default(_that.id,_that.startedAt,_that.updatedAt,_that.planId,_that.dayIndex,_that.focus,_that.endedAt,_that.durationSeconds,_that.note,_that.deletedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  DateTime startedAt,  DateTime updatedAt,  int? planId,  int? dayIndex,  String? focus,  DateTime? endedAt,  int? durationSeconds,  String? note,  DateTime? deletedAt)  $default,) {final _that = this;
switch (_that) {
case _Session():
return $default(_that.id,_that.startedAt,_that.updatedAt,_that.planId,_that.dayIndex,_that.focus,_that.endedAt,_that.durationSeconds,_that.note,_that.deletedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  DateTime startedAt,  DateTime updatedAt,  int? planId,  int? dayIndex,  String? focus,  DateTime? endedAt,  int? durationSeconds,  String? note,  DateTime? deletedAt)?  $default,) {final _that = this;
switch (_that) {
case _Session() when $default != null:
return $default(_that.id,_that.startedAt,_that.updatedAt,_that.planId,_that.dayIndex,_that.focus,_that.endedAt,_that.durationSeconds,_that.note,_that.deletedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Session implements Session {
  const _Session({required this.id, required this.startedAt, required this.updatedAt, this.planId, this.dayIndex, this.focus, this.endedAt, this.durationSeconds, this.note, this.deletedAt});
  factory _Session.fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);

@override final  int id;
@override final  DateTime startedAt;
@override final  DateTime updatedAt;
@override final  int? planId;
@override final  int? dayIndex;
@override final  String? focus;
@override final  DateTime? endedAt;
@override final  int? durationSeconds;
@override final  String? note;
@override final  DateTime? deletedAt;

/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SessionCopyWith<_Session> get copyWith => __$SessionCopyWithImpl<_Session>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Session&&(identical(other.id, id) || other.id == id)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.planId, planId) || other.planId == planId)&&(identical(other.dayIndex, dayIndex) || other.dayIndex == dayIndex)&&(identical(other.focus, focus) || other.focus == focus)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.durationSeconds, durationSeconds) || other.durationSeconds == durationSeconds)&&(identical(other.note, note) || other.note == note)&&(identical(other.deletedAt, deletedAt) || other.deletedAt == deletedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,startedAt,updatedAt,planId,dayIndex,focus,endedAt,durationSeconds,note,deletedAt);

@override
String toString() {
  return 'Session(id: $id, startedAt: $startedAt, updatedAt: $updatedAt, planId: $planId, dayIndex: $dayIndex, focus: $focus, endedAt: $endedAt, durationSeconds: $durationSeconds, note: $note, deletedAt: $deletedAt)';
}


}

/// @nodoc
abstract mixin class _$SessionCopyWith<$Res> implements $SessionCopyWith<$Res> {
  factory _$SessionCopyWith(_Session value, $Res Function(_Session) _then) = __$SessionCopyWithImpl;
@override @useResult
$Res call({
 int id, DateTime startedAt, DateTime updatedAt, int? planId, int? dayIndex, String? focus, DateTime? endedAt, int? durationSeconds, String? note, DateTime? deletedAt
});




}
/// @nodoc
class __$SessionCopyWithImpl<$Res>
    implements _$SessionCopyWith<$Res> {
  __$SessionCopyWithImpl(this._self, this._then);

  final _Session _self;
  final $Res Function(_Session) _then;

/// Create a copy of Session
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? startedAt = null,Object? updatedAt = null,Object? planId = freezed,Object? dayIndex = freezed,Object? focus = freezed,Object? endedAt = freezed,Object? durationSeconds = freezed,Object? note = freezed,Object? deletedAt = freezed,}) {
  return _then(_Session(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,planId: freezed == planId ? _self.planId : planId // ignore: cast_nullable_to_non_nullable
as int?,dayIndex: freezed == dayIndex ? _self.dayIndex : dayIndex // ignore: cast_nullable_to_non_nullable
as int?,focus: freezed == focus ? _self.focus : focus // ignore: cast_nullable_to_non_nullable
as String?,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,durationSeconds: freezed == durationSeconds ? _self.durationSeconds : durationSeconds // ignore: cast_nullable_to_non_nullable
as int?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,deletedAt: freezed == deletedAt ? _self.deletedAt : deletedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
