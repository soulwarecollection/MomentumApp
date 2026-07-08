// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'progress_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProgressState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProgressState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProgressState()';
}


}

/// @nodoc
class $ProgressStateCopyWith<$Res>  {
$ProgressStateCopyWith(ProgressState _, $Res Function(ProgressState) __);
}


/// Adds pattern-matching-related methods to [ProgressState].
extension ProgressStatePatterns on ProgressState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ProgressLoading value)?  loading,TResult Function( ProgressEmpty value)?  empty,TResult Function( ProgressReady value)?  ready,TResult Function( ProgressError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ProgressLoading() when loading != null:
return loading(_that);case ProgressEmpty() when empty != null:
return empty(_that);case ProgressReady() when ready != null:
return ready(_that);case ProgressError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ProgressLoading value)  loading,required TResult Function( ProgressEmpty value)  empty,required TResult Function( ProgressReady value)  ready,required TResult Function( ProgressError value)  error,}){
final _that = this;
switch (_that) {
case ProgressLoading():
return loading(_that);case ProgressEmpty():
return empty(_that);case ProgressReady():
return ready(_that);case ProgressError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ProgressLoading value)?  loading,TResult? Function( ProgressEmpty value)?  empty,TResult? Function( ProgressReady value)?  ready,TResult? Function( ProgressError value)?  error,}){
final _that = this;
switch (_that) {
case ProgressLoading() when loading != null:
return loading(_that);case ProgressEmpty() when empty != null:
return empty(_that);case ProgressReady() when ready != null:
return ready(_that);case ProgressError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function()?  empty,TResult Function( String focusExercise,  double estimated1rm,  List<double> ormSparkValues,  double weekVolumeKg,  List<double> volumeSparkValues,  List<OrmDataPoint> allTrendPoints,  List<OrmDataPoint> filteredTrendPoints,  Map<Modality, double> volumeDistribution,  List<PrRecord> prRecords,  DateRange selectedRange)?  ready,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ProgressLoading() when loading != null:
return loading();case ProgressEmpty() when empty != null:
return empty();case ProgressReady() when ready != null:
return ready(_that.focusExercise,_that.estimated1rm,_that.ormSparkValues,_that.weekVolumeKg,_that.volumeSparkValues,_that.allTrendPoints,_that.filteredTrendPoints,_that.volumeDistribution,_that.prRecords,_that.selectedRange);case ProgressError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function()  empty,required TResult Function( String focusExercise,  double estimated1rm,  List<double> ormSparkValues,  double weekVolumeKg,  List<double> volumeSparkValues,  List<OrmDataPoint> allTrendPoints,  List<OrmDataPoint> filteredTrendPoints,  Map<Modality, double> volumeDistribution,  List<PrRecord> prRecords,  DateRange selectedRange)  ready,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case ProgressLoading():
return loading();case ProgressEmpty():
return empty();case ProgressReady():
return ready(_that.focusExercise,_that.estimated1rm,_that.ormSparkValues,_that.weekVolumeKg,_that.volumeSparkValues,_that.allTrendPoints,_that.filteredTrendPoints,_that.volumeDistribution,_that.prRecords,_that.selectedRange);case ProgressError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function()?  empty,TResult? Function( String focusExercise,  double estimated1rm,  List<double> ormSparkValues,  double weekVolumeKg,  List<double> volumeSparkValues,  List<OrmDataPoint> allTrendPoints,  List<OrmDataPoint> filteredTrendPoints,  Map<Modality, double> volumeDistribution,  List<PrRecord> prRecords,  DateRange selectedRange)?  ready,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case ProgressLoading() when loading != null:
return loading();case ProgressEmpty() when empty != null:
return empty();case ProgressReady() when ready != null:
return ready(_that.focusExercise,_that.estimated1rm,_that.ormSparkValues,_that.weekVolumeKg,_that.volumeSparkValues,_that.allTrendPoints,_that.filteredTrendPoints,_that.volumeDistribution,_that.prRecords,_that.selectedRange);case ProgressError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ProgressLoading implements ProgressState {
  const ProgressLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProgressLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProgressState.loading()';
}


}




/// @nodoc


class ProgressEmpty implements ProgressState {
  const ProgressEmpty();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProgressEmpty);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProgressState.empty()';
}


}




/// @nodoc


class ProgressReady implements ProgressState {
  const ProgressReady({required this.focusExercise, required this.estimated1rm, required final  List<double> ormSparkValues, required this.weekVolumeKg, required final  List<double> volumeSparkValues, required final  List<OrmDataPoint> allTrendPoints, required final  List<OrmDataPoint> filteredTrendPoints, required final  Map<Modality, double> volumeDistribution, required final  List<PrRecord> prRecords, required this.selectedRange}): _ormSparkValues = ormSparkValues,_volumeSparkValues = volumeSparkValues,_allTrendPoints = allTrendPoints,_filteredTrendPoints = filteredTrendPoints,_volumeDistribution = volumeDistribution,_prRecords = prRecords;
  

 final  String focusExercise;
 final  double estimated1rm;
 final  List<double> _ormSparkValues;
 List<double> get ormSparkValues {
  if (_ormSparkValues is EqualUnmodifiableListView) return _ormSparkValues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ormSparkValues);
}

 final  double weekVolumeKg;
 final  List<double> _volumeSparkValues;
 List<double> get volumeSparkValues {
  if (_volumeSparkValues is EqualUnmodifiableListView) return _volumeSparkValues;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_volumeSparkValues);
}

 final  List<OrmDataPoint> _allTrendPoints;
 List<OrmDataPoint> get allTrendPoints {
  if (_allTrendPoints is EqualUnmodifiableListView) return _allTrendPoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allTrendPoints);
}

 final  List<OrmDataPoint> _filteredTrendPoints;
 List<OrmDataPoint> get filteredTrendPoints {
  if (_filteredTrendPoints is EqualUnmodifiableListView) return _filteredTrendPoints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredTrendPoints);
}

 final  Map<Modality, double> _volumeDistribution;
 Map<Modality, double> get volumeDistribution {
  if (_volumeDistribution is EqualUnmodifiableMapView) return _volumeDistribution;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_volumeDistribution);
}

 final  List<PrRecord> _prRecords;
 List<PrRecord> get prRecords {
  if (_prRecords is EqualUnmodifiableListView) return _prRecords;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_prRecords);
}

 final  DateRange selectedRange;

/// Create a copy of ProgressState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProgressReadyCopyWith<ProgressReady> get copyWith => _$ProgressReadyCopyWithImpl<ProgressReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProgressReady&&(identical(other.focusExercise, focusExercise) || other.focusExercise == focusExercise)&&(identical(other.estimated1rm, estimated1rm) || other.estimated1rm == estimated1rm)&&const DeepCollectionEquality().equals(other._ormSparkValues, _ormSparkValues)&&(identical(other.weekVolumeKg, weekVolumeKg) || other.weekVolumeKg == weekVolumeKg)&&const DeepCollectionEquality().equals(other._volumeSparkValues, _volumeSparkValues)&&const DeepCollectionEquality().equals(other._allTrendPoints, _allTrendPoints)&&const DeepCollectionEquality().equals(other._filteredTrendPoints, _filteredTrendPoints)&&const DeepCollectionEquality().equals(other._volumeDistribution, _volumeDistribution)&&const DeepCollectionEquality().equals(other._prRecords, _prRecords)&&(identical(other.selectedRange, selectedRange) || other.selectedRange == selectedRange));
}


@override
int get hashCode => Object.hash(runtimeType,focusExercise,estimated1rm,const DeepCollectionEquality().hash(_ormSparkValues),weekVolumeKg,const DeepCollectionEquality().hash(_volumeSparkValues),const DeepCollectionEquality().hash(_allTrendPoints),const DeepCollectionEquality().hash(_filteredTrendPoints),const DeepCollectionEquality().hash(_volumeDistribution),const DeepCollectionEquality().hash(_prRecords),selectedRange);

@override
String toString() {
  return 'ProgressState.ready(focusExercise: $focusExercise, estimated1rm: $estimated1rm, ormSparkValues: $ormSparkValues, weekVolumeKg: $weekVolumeKg, volumeSparkValues: $volumeSparkValues, allTrendPoints: $allTrendPoints, filteredTrendPoints: $filteredTrendPoints, volumeDistribution: $volumeDistribution, prRecords: $prRecords, selectedRange: $selectedRange)';
}


}

/// @nodoc
abstract mixin class $ProgressReadyCopyWith<$Res> implements $ProgressStateCopyWith<$Res> {
  factory $ProgressReadyCopyWith(ProgressReady value, $Res Function(ProgressReady) _then) = _$ProgressReadyCopyWithImpl;
@useResult
$Res call({
 String focusExercise, double estimated1rm, List<double> ormSparkValues, double weekVolumeKg, List<double> volumeSparkValues, List<OrmDataPoint> allTrendPoints, List<OrmDataPoint> filteredTrendPoints, Map<Modality, double> volumeDistribution, List<PrRecord> prRecords, DateRange selectedRange
});




}
/// @nodoc
class _$ProgressReadyCopyWithImpl<$Res>
    implements $ProgressReadyCopyWith<$Res> {
  _$ProgressReadyCopyWithImpl(this._self, this._then);

  final ProgressReady _self;
  final $Res Function(ProgressReady) _then;

/// Create a copy of ProgressState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? focusExercise = null,Object? estimated1rm = null,Object? ormSparkValues = null,Object? weekVolumeKg = null,Object? volumeSparkValues = null,Object? allTrendPoints = null,Object? filteredTrendPoints = null,Object? volumeDistribution = null,Object? prRecords = null,Object? selectedRange = null,}) {
  return _then(ProgressReady(
focusExercise: null == focusExercise ? _self.focusExercise : focusExercise // ignore: cast_nullable_to_non_nullable
as String,estimated1rm: null == estimated1rm ? _self.estimated1rm : estimated1rm // ignore: cast_nullable_to_non_nullable
as double,ormSparkValues: null == ormSparkValues ? _self._ormSparkValues : ormSparkValues // ignore: cast_nullable_to_non_nullable
as List<double>,weekVolumeKg: null == weekVolumeKg ? _self.weekVolumeKg : weekVolumeKg // ignore: cast_nullable_to_non_nullable
as double,volumeSparkValues: null == volumeSparkValues ? _self._volumeSparkValues : volumeSparkValues // ignore: cast_nullable_to_non_nullable
as List<double>,allTrendPoints: null == allTrendPoints ? _self._allTrendPoints : allTrendPoints // ignore: cast_nullable_to_non_nullable
as List<OrmDataPoint>,filteredTrendPoints: null == filteredTrendPoints ? _self._filteredTrendPoints : filteredTrendPoints // ignore: cast_nullable_to_non_nullable
as List<OrmDataPoint>,volumeDistribution: null == volumeDistribution ? _self._volumeDistribution : volumeDistribution // ignore: cast_nullable_to_non_nullable
as Map<Modality, double>,prRecords: null == prRecords ? _self._prRecords : prRecords // ignore: cast_nullable_to_non_nullable
as List<PrRecord>,selectedRange: null == selectedRange ? _self.selectedRange : selectedRange // ignore: cast_nullable_to_non_nullable
as DateRange,
  ));
}


}

/// @nodoc


class ProgressError implements ProgressState {
  const ProgressError(this.message);
  

 final  String message;

/// Create a copy of ProgressState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProgressErrorCopyWith<ProgressError> get copyWith => _$ProgressErrorCopyWithImpl<ProgressError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProgressError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ProgressState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ProgressErrorCopyWith<$Res> implements $ProgressStateCopyWith<$Res> {
  factory $ProgressErrorCopyWith(ProgressError value, $Res Function(ProgressError) _then) = _$ProgressErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ProgressErrorCopyWithImpl<$Res>
    implements $ProgressErrorCopyWith<$Res> {
  _$ProgressErrorCopyWithImpl(this._self, this._then);

  final ProgressError _self;
  final $Res Function(ProgressError) _then;

/// Create a copy of ProgressState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ProgressError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
