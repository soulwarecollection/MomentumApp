// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weight_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WeightState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeightState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WeightState()';
}


}

/// @nodoc
class $WeightStateCopyWith<$Res>  {
$WeightStateCopyWith(WeightState _, $Res Function(WeightState) __);
}


/// Adds pattern-matching-related methods to [WeightState].
extension WeightStatePatterns on WeightState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( WeightLoading value)?  loading,TResult Function( WeightReady value)?  ready,TResult Function( WeightError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case WeightLoading() when loading != null:
return loading(_that);case WeightReady() when ready != null:
return ready(_that);case WeightError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( WeightLoading value)  loading,required TResult Function( WeightReady value)  ready,required TResult Function( WeightError value)  error,}){
final _that = this;
switch (_that) {
case WeightLoading():
return loading(_that);case WeightReady():
return ready(_that);case WeightError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( WeightLoading value)?  loading,TResult? Function( WeightReady value)?  ready,TResult? Function( WeightError value)?  error,}){
final _that = this;
switch (_that) {
case WeightLoading() when loading != null:
return loading(_that);case WeightReady() when ready != null:
return ready(_that);case WeightError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( List<WeightEntryRow> entries,  List<WeightEntryRow> chartPoints,  WeightEntryRow? latest)?  ready,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case WeightLoading() when loading != null:
return loading();case WeightReady() when ready != null:
return ready(_that.entries,_that.chartPoints,_that.latest);case WeightError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( List<WeightEntryRow> entries,  List<WeightEntryRow> chartPoints,  WeightEntryRow? latest)  ready,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case WeightLoading():
return loading();case WeightReady():
return ready(_that.entries,_that.chartPoints,_that.latest);case WeightError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( List<WeightEntryRow> entries,  List<WeightEntryRow> chartPoints,  WeightEntryRow? latest)?  ready,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case WeightLoading() when loading != null:
return loading();case WeightReady() when ready != null:
return ready(_that.entries,_that.chartPoints,_that.latest);case WeightError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class WeightLoading implements WeightState {
  const WeightLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeightLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'WeightState.loading()';
}


}




/// @nodoc


class WeightReady implements WeightState {
  const WeightReady({required final  List<WeightEntryRow> entries, required final  List<WeightEntryRow> chartPoints, this.latest}): _entries = entries,_chartPoints = chartPoints;
  

 final  List<WeightEntryRow> _entries;
 List<WeightEntryRow> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}

 final  List<WeightEntryRow> _chartPoints;
 List<WeightEntryRow> get chartPoints {
  if (_chartPoints is EqualUnmodifiableListView) return _chartPoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chartPoints);
}

 final  WeightEntryRow? latest;

/// Create a copy of WeightState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeightReadyCopyWith<WeightReady> get copyWith => _$WeightReadyCopyWithImpl<WeightReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeightReady&&const DeepCollectionEquality().equals(other._entries, _entries)&&const DeepCollectionEquality().equals(other._chartPoints, _chartPoints)&&const DeepCollectionEquality().equals(other.latest, latest));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_entries),const DeepCollectionEquality().hash(_chartPoints),const DeepCollectionEquality().hash(latest));

@override
String toString() {
  return 'WeightState.ready(entries: $entries, chartPoints: $chartPoints, latest: $latest)';
}


}

/// @nodoc
abstract mixin class $WeightReadyCopyWith<$Res> implements $WeightStateCopyWith<$Res> {
  factory $WeightReadyCopyWith(WeightReady value, $Res Function(WeightReady) _then) = _$WeightReadyCopyWithImpl;
@useResult
$Res call({
 List<WeightEntryRow> entries, List<WeightEntryRow> chartPoints, WeightEntryRow? latest
});




}
/// @nodoc
class _$WeightReadyCopyWithImpl<$Res>
    implements $WeightReadyCopyWith<$Res> {
  _$WeightReadyCopyWithImpl(this._self, this._then);

  final WeightReady _self;
  final $Res Function(WeightReady) _then;

/// Create a copy of WeightState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? entries = null,Object? chartPoints = null,Object? latest = freezed,}) {
  return _then(WeightReady(
entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<WeightEntryRow>,chartPoints: null == chartPoints ? _self._chartPoints : chartPoints // ignore: cast_nullable_to_non_nullable
as List<WeightEntryRow>,latest: freezed == latest ? _self.latest : latest // ignore: cast_nullable_to_non_nullable
as WeightEntryRow?,
  ));
}


}

/// @nodoc


class WeightError implements WeightState {
  const WeightError(this.message);
  

 final  String message;

/// Create a copy of WeightState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeightErrorCopyWith<WeightError> get copyWith => _$WeightErrorCopyWithImpl<WeightError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeightError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'WeightState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $WeightErrorCopyWith<$Res> implements $WeightStateCopyWith<$Res> {
  factory $WeightErrorCopyWith(WeightError value, $Res Function(WeightError) _then) = _$WeightErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$WeightErrorCopyWithImpl<$Res>
    implements $WeightErrorCopyWith<$Res> {
  _$WeightErrorCopyWithImpl(this._self, this._then);

  final WeightError _self;
  final $Res Function(WeightError) _then;

/// Create a copy of WeightState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(WeightError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
