// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'set_row.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SetRow {

 String get localId; Map<String, double> get metrics; bool get isDone; bool get isExpanded;
/// Create a copy of SetRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetRowCopyWith<SetRow> get copyWith => _$SetRowCopyWithImpl<SetRow>(this as SetRow, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetRow&&(identical(other.localId, localId) || other.localId == localId)&&const DeepCollectionEquality().equals(other.metrics, metrics)&&(identical(other.isDone, isDone) || other.isDone == isDone)&&(identical(other.isExpanded, isExpanded) || other.isExpanded == isExpanded));
}


@override
int get hashCode => Object.hash(runtimeType,localId,const DeepCollectionEquality().hash(metrics),isDone,isExpanded);

@override
String toString() {
  return 'SetRow(localId: $localId, metrics: $metrics, isDone: $isDone, isExpanded: $isExpanded)';
}


}

/// @nodoc
abstract mixin class $SetRowCopyWith<$Res>  {
  factory $SetRowCopyWith(SetRow value, $Res Function(SetRow) _then) = _$SetRowCopyWithImpl;
@useResult
$Res call({
 String localId, Map<String, double> metrics, bool isDone, bool isExpanded
});




}
/// @nodoc
class _$SetRowCopyWithImpl<$Res>
    implements $SetRowCopyWith<$Res> {
  _$SetRowCopyWithImpl(this._self, this._then);

  final SetRow _self;
  final $Res Function(SetRow) _then;

/// Create a copy of SetRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? localId = null,Object? metrics = null,Object? isDone = null,Object? isExpanded = null,}) {
  return _then(_self.copyWith(
localId: null == localId ? _self.localId : localId // ignore: cast_nullable_to_non_nullable
as String,metrics: null == metrics ? _self.metrics : metrics // ignore: cast_nullable_to_non_nullable
as Map<String, double>,isDone: null == isDone ? _self.isDone : isDone // ignore: cast_nullable_to_non_nullable
as bool,isExpanded: null == isExpanded ? _self.isExpanded : isExpanded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SetRow].
extension SetRowPatterns on SetRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SetRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SetRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SetRow value)  $default,){
final _that = this;
switch (_that) {
case _SetRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SetRow value)?  $default,){
final _that = this;
switch (_that) {
case _SetRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String localId,  Map<String, double> metrics,  bool isDone,  bool isExpanded)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SetRow() when $default != null:
return $default(_that.localId,_that.metrics,_that.isDone,_that.isExpanded);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String localId,  Map<String, double> metrics,  bool isDone,  bool isExpanded)  $default,) {final _that = this;
switch (_that) {
case _SetRow():
return $default(_that.localId,_that.metrics,_that.isDone,_that.isExpanded);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String localId,  Map<String, double> metrics,  bool isDone,  bool isExpanded)?  $default,) {final _that = this;
switch (_that) {
case _SetRow() when $default != null:
return $default(_that.localId,_that.metrics,_that.isDone,_that.isExpanded);case _:
  return null;

}
}

}

/// @nodoc


class _SetRow implements SetRow {
  const _SetRow({required this.localId, required final  Map<String, double> metrics, this.isDone = false, this.isExpanded = false}): _metrics = metrics;
  

@override final  String localId;
 final  Map<String, double> _metrics;
@override Map<String, double> get metrics {
  if (_metrics is EqualUnmodifiableMapView) return _metrics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metrics);
}

@override@JsonKey() final  bool isDone;
@override@JsonKey() final  bool isExpanded;

/// Create a copy of SetRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetRowCopyWith<_SetRow> get copyWith => __$SetRowCopyWithImpl<_SetRow>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetRow&&(identical(other.localId, localId) || other.localId == localId)&&const DeepCollectionEquality().equals(other._metrics, _metrics)&&(identical(other.isDone, isDone) || other.isDone == isDone)&&(identical(other.isExpanded, isExpanded) || other.isExpanded == isExpanded));
}


@override
int get hashCode => Object.hash(runtimeType,localId,const DeepCollectionEquality().hash(_metrics),isDone,isExpanded);

@override
String toString() {
  return 'SetRow(localId: $localId, metrics: $metrics, isDone: $isDone, isExpanded: $isExpanded)';
}


}

/// @nodoc
abstract mixin class _$SetRowCopyWith<$Res> implements $SetRowCopyWith<$Res> {
  factory _$SetRowCopyWith(_SetRow value, $Res Function(_SetRow) _then) = __$SetRowCopyWithImpl;
@override @useResult
$Res call({
 String localId, Map<String, double> metrics, bool isDone, bool isExpanded
});




}
/// @nodoc
class __$SetRowCopyWithImpl<$Res>
    implements _$SetRowCopyWith<$Res> {
  __$SetRowCopyWithImpl(this._self, this._then);

  final _SetRow _self;
  final $Res Function(_SetRow) _then;

/// Create a copy of SetRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? localId = null,Object? metrics = null,Object? isDone = null,Object? isExpanded = null,}) {
  return _then(_SetRow(
localId: null == localId ? _self.localId : localId // ignore: cast_nullable_to_non_nullable
as String,metrics: null == metrics ? _self._metrics : metrics // ignore: cast_nullable_to_non_nullable
as Map<String, double>,isDone: null == isDone ? _self.isDone : isDone // ignore: cast_nullable_to_non_nullable
as bool,isExpanded: null == isExpanded ? _self.isExpanded : isExpanded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
