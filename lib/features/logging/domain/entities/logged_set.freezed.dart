// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'logged_set.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LoggedSet {

 int get id; int get sessionExerciseId; int get orderIndex; Modality get modality; Map<String, double> get metrics; bool get isDone; DateTime get createdAt;
/// Create a copy of LoggedSet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoggedSetCopyWith<LoggedSet> get copyWith => _$LoggedSetCopyWithImpl<LoggedSet>(this as LoggedSet, _$identity);

  /// Serializes this LoggedSet to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoggedSet&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionExerciseId, sessionExerciseId) || other.sessionExerciseId == sessionExerciseId)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex)&&(identical(other.modality, modality) || other.modality == modality)&&const DeepCollectionEquality().equals(other.metrics, metrics)&&(identical(other.isDone, isDone) || other.isDone == isDone)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sessionExerciseId,orderIndex,modality,const DeepCollectionEquality().hash(metrics),isDone,createdAt);

@override
String toString() {
  return 'LoggedSet(id: $id, sessionExerciseId: $sessionExerciseId, orderIndex: $orderIndex, modality: $modality, metrics: $metrics, isDone: $isDone, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $LoggedSetCopyWith<$Res>  {
  factory $LoggedSetCopyWith(LoggedSet value, $Res Function(LoggedSet) _then) = _$LoggedSetCopyWithImpl;
@useResult
$Res call({
 int id, int sessionExerciseId, int orderIndex, Modality modality, Map<String, double> metrics, bool isDone, DateTime createdAt
});




}
/// @nodoc
class _$LoggedSetCopyWithImpl<$Res>
    implements $LoggedSetCopyWith<$Res> {
  _$LoggedSetCopyWithImpl(this._self, this._then);

  final LoggedSet _self;
  final $Res Function(LoggedSet) _then;

/// Create a copy of LoggedSet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? sessionExerciseId = null,Object? orderIndex = null,Object? modality = null,Object? metrics = null,Object? isDone = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,sessionExerciseId: null == sessionExerciseId ? _self.sessionExerciseId : sessionExerciseId // ignore: cast_nullable_to_non_nullable
as int,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,modality: null == modality ? _self.modality : modality // ignore: cast_nullable_to_non_nullable
as Modality,metrics: null == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as Map<String, double>,isDone: null == isDone ? _self.isDone : isDone // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [LoggedSet].
extension LoggedSetPatterns on LoggedSet {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoggedSet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoggedSet() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoggedSet value)  $default,){
final _that = this;
switch (_that) {
case _LoggedSet():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoggedSet value)?  $default,){
final _that = this;
switch (_that) {
case _LoggedSet() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int sessionExerciseId,  int orderIndex,  Modality modality,  Map<String, double> metrics,  bool isDone,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoggedSet() when $default != null:
return $default(_that.id,_that.sessionExerciseId,_that.orderIndex,_that.modality,_that.metrics,_that.isDone,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int sessionExerciseId,  int orderIndex,  Modality modality,  Map<String, double> metrics,  bool isDone,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _LoggedSet():
return $default(_that.id,_that.sessionExerciseId,_that.orderIndex,_that.modality,_that.metrics,_that.isDone,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int sessionExerciseId,  int orderIndex,  Modality modality,  Map<String, double> metrics,  bool isDone,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _LoggedSet() when $default != null:
return $default(_that.id,_that.sessionExerciseId,_that.orderIndex,_that.modality,_that.metrics,_that.isDone,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LoggedSet implements LoggedSet {
  const _LoggedSet({required this.id, required this.sessionExerciseId, required this.orderIndex, required this.modality, required final  Map<String, double> metrics, required this.isDone, required this.createdAt}): _metrics = metrics;
  factory _LoggedSet.fromJson(Map<String, dynamic> json) => _$LoggedSetFromJson(json);

@override final  int id;
@override final  int sessionExerciseId;
@override final  int orderIndex;
@override final  Modality modality;
 final  Map<String, double> _metrics;
@override Map<String, double> get metrics {
  if (_metrics is EqualUnmodifiableMapView) return _metrics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metrics);
}

@override final  bool isDone;
@override final  DateTime createdAt;

/// Create a copy of LoggedSet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoggedSetCopyWith<_LoggedSet> get copyWith => __$LoggedSetCopyWithImpl<_LoggedSet>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LoggedSetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoggedSet&&(identical(other.id, id) || other.id == id)&&(identical(other.sessionExerciseId, sessionExerciseId) || other.sessionExerciseId == sessionExerciseId)&&(identical(other.orderIndex, orderIndex) || other.orderIndex == orderIndex)&&(identical(other.modality, modality) || other.modality == modality)&&const DeepCollectionEquality().equals(other._metrics, _metrics)&&(identical(other.isDone, isDone) || other.isDone == isDone)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,sessionExerciseId,orderIndex,modality,const DeepCollectionEquality().hash(_metrics),isDone,createdAt);

@override
String toString() {
  return 'LoggedSet(id: $id, sessionExerciseId: $sessionExerciseId, orderIndex: $orderIndex, modality: $modality, metrics: $metrics, isDone: $isDone, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$LoggedSetCopyWith<$Res> implements $LoggedSetCopyWith<$Res> {
  factory _$LoggedSetCopyWith(_LoggedSet value, $Res Function(_LoggedSet) _then) = __$LoggedSetCopyWithImpl;
@override @useResult
$Res call({
 int id, int sessionExerciseId, int orderIndex, Modality modality, Map<String, double> metrics, bool isDone, DateTime createdAt
});




}
/// @nodoc
class __$LoggedSetCopyWithImpl<$Res>
    implements _$LoggedSetCopyWith<$Res> {
  __$LoggedSetCopyWithImpl(this._self, this._then);

  final _LoggedSet _self;
  final $Res Function(_LoggedSet) _then;

/// Create a copy of LoggedSet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? sessionExerciseId = null,Object? orderIndex = null,Object? modality = null,Object? metrics = null,Object? isDone = null,Object? createdAt = null,}) {
  return _then(_LoggedSet(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,sessionExerciseId: null == sessionExerciseId ? _self.sessionExerciseId : sessionExerciseId // ignore: cast_nullable_to_non_nullable
as int,orderIndex: null == orderIndex ? _self.orderIndex : orderIndex // ignore: cast_nullable_to_non_nullable
as int,modality: null == modality ? _self.modality : modality // ignore: cast_nullable_to_non_nullable
as Modality,metrics: null == metrics ? _self._metrics : metrics // ignore: cast_nullable_to_non_nullable
as Map<String, double>,isDone: null == isDone ? _self.isDone : isDone // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
