// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ExerciseEntry {

 String get localId; String get name; Modality get modality; List<SetRow> get sets; bool get isCollapsed; bool get isPrHighlighted; EquipmentType? get equipment; String? get exerciseNote; double? get targetWeight;
/// Create a copy of ExerciseEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExerciseEntryCopyWith<ExerciseEntry> get copyWith => _$ExerciseEntryCopyWithImpl<ExerciseEntry>(this as ExerciseEntry, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExerciseEntry&&(identical(other.localId, localId) || other.localId == localId)&&(identical(other.name, name) || other.name == name)&&(identical(other.modality, modality) || other.modality == modality)&&const DeepCollectionEquality().equals(other.sets, sets)&&(identical(other.isCollapsed, isCollapsed) || other.isCollapsed == isCollapsed)&&(identical(other.isPrHighlighted, isPrHighlighted) || other.isPrHighlighted == isPrHighlighted)&&(identical(other.equipment, equipment) || other.equipment == equipment)&&(identical(other.exerciseNote, exerciseNote) || other.exerciseNote == exerciseNote)&&(identical(other.targetWeight, targetWeight) || other.targetWeight == targetWeight));
}


@override
int get hashCode => Object.hash(runtimeType,localId,name,modality,const DeepCollectionEquality().hash(sets),isCollapsed,isPrHighlighted,equipment,exerciseNote,targetWeight);

@override
String toString() {
  return 'ExerciseEntry(localId: $localId, name: $name, modality: $modality, sets: $sets, isCollapsed: $isCollapsed, isPrHighlighted: $isPrHighlighted, equipment: $equipment, exerciseNote: $exerciseNote, targetWeight: $targetWeight)';
}


}

/// @nodoc
abstract mixin class $ExerciseEntryCopyWith<$Res>  {
  factory $ExerciseEntryCopyWith(ExerciseEntry value, $Res Function(ExerciseEntry) _then) = _$ExerciseEntryCopyWithImpl;
@useResult
$Res call({
 String localId, String name, Modality modality, List<SetRow> sets, bool isCollapsed, bool isPrHighlighted, EquipmentType? equipment, String? exerciseNote, double? targetWeight
});




}
/// @nodoc
class _$ExerciseEntryCopyWithImpl<$Res>
    implements $ExerciseEntryCopyWith<$Res> {
  _$ExerciseEntryCopyWithImpl(this._self, this._then);

  final ExerciseEntry _self;
  final $Res Function(ExerciseEntry) _then;

/// Create a copy of ExerciseEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? localId = null,Object? name = null,Object? modality = null,Object? sets = null,Object? isCollapsed = null,Object? isPrHighlighted = null,Object? equipment = freezed,Object? exerciseNote = freezed,Object? targetWeight = freezed,}) {
  return _then(_self.copyWith(
localId: null == localId ? _self.localId : localId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,modality: null == modality ? _self.modality : modality // ignore: cast_nullable_to_non_nullable
as Modality,sets: null == sets ? _self.sets : sets // ignore: cast_nullable_to_non_nullable
as List<SetRow>,isCollapsed: null == isCollapsed ? _self.isCollapsed : isCollapsed // ignore: cast_nullable_to_non_nullable
as bool,isPrHighlighted: null == isPrHighlighted ? _self.isPrHighlighted : isPrHighlighted // ignore: cast_nullable_to_non_nullable
as bool,equipment: freezed == equipment ? _self.equipment : equipment // ignore: cast_nullable_to_non_nullable
as EquipmentType?,exerciseNote: freezed == exerciseNote ? _self.exerciseNote : exerciseNote // ignore: cast_nullable_to_non_nullable
as String?,targetWeight: freezed == targetWeight ? _self.targetWeight : targetWeight // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [ExerciseEntry].
extension ExerciseEntryPatterns on ExerciseEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExerciseEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExerciseEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExerciseEntry value)  $default,){
final _that = this;
switch (_that) {
case _ExerciseEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExerciseEntry value)?  $default,){
final _that = this;
switch (_that) {
case _ExerciseEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String localId,  String name,  Modality modality,  List<SetRow> sets,  bool isCollapsed,  bool isPrHighlighted,  EquipmentType? equipment,  String? exerciseNote,  double? targetWeight)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExerciseEntry() when $default != null:
return $default(_that.localId,_that.name,_that.modality,_that.sets,_that.isCollapsed,_that.isPrHighlighted,_that.equipment,_that.exerciseNote,_that.targetWeight);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String localId,  String name,  Modality modality,  List<SetRow> sets,  bool isCollapsed,  bool isPrHighlighted,  EquipmentType? equipment,  String? exerciseNote,  double? targetWeight)  $default,) {final _that = this;
switch (_that) {
case _ExerciseEntry():
return $default(_that.localId,_that.name,_that.modality,_that.sets,_that.isCollapsed,_that.isPrHighlighted,_that.equipment,_that.exerciseNote,_that.targetWeight);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String localId,  String name,  Modality modality,  List<SetRow> sets,  bool isCollapsed,  bool isPrHighlighted,  EquipmentType? equipment,  String? exerciseNote,  double? targetWeight)?  $default,) {final _that = this;
switch (_that) {
case _ExerciseEntry() when $default != null:
return $default(_that.localId,_that.name,_that.modality,_that.sets,_that.isCollapsed,_that.isPrHighlighted,_that.equipment,_that.exerciseNote,_that.targetWeight);case _:
  return null;

}
}

}

/// @nodoc


class _ExerciseEntry implements ExerciseEntry {
  const _ExerciseEntry({required this.localId, required this.name, required this.modality, required final  List<SetRow> sets, this.isCollapsed = false, this.isPrHighlighted = false, this.equipment, this.exerciseNote, this.targetWeight}): _sets = sets;
  

@override final  String localId;
@override final  String name;
@override final  Modality modality;
 final  List<SetRow> _sets;
@override List<SetRow> get sets {
  if (_sets is EqualUnmodifiableListView) return _sets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sets);
}

@override@JsonKey() final  bool isCollapsed;
@override@JsonKey() final  bool isPrHighlighted;
@override final  EquipmentType? equipment;
@override final  String? exerciseNote;
@override final  double? targetWeight;

/// Create a copy of ExerciseEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExerciseEntryCopyWith<_ExerciseEntry> get copyWith => __$ExerciseEntryCopyWithImpl<_ExerciseEntry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExerciseEntry&&(identical(other.localId, localId) || other.localId == localId)&&(identical(other.name, name) || other.name == name)&&(identical(other.modality, modality) || other.modality == modality)&&const DeepCollectionEquality().equals(other._sets, _sets)&&(identical(other.isCollapsed, isCollapsed) || other.isCollapsed == isCollapsed)&&(identical(other.isPrHighlighted, isPrHighlighted) || other.isPrHighlighted == isPrHighlighted)&&(identical(other.equipment, equipment) || other.equipment == equipment)&&(identical(other.exerciseNote, exerciseNote) || other.exerciseNote == exerciseNote)&&(identical(other.targetWeight, targetWeight) || other.targetWeight == targetWeight));
}


@override
int get hashCode => Object.hash(runtimeType,localId,name,modality,const DeepCollectionEquality().hash(_sets),isCollapsed,isPrHighlighted,equipment,exerciseNote,targetWeight);

@override
String toString() {
  return 'ExerciseEntry(localId: $localId, name: $name, modality: $modality, sets: $sets, isCollapsed: $isCollapsed, isPrHighlighted: $isPrHighlighted, equipment: $equipment, exerciseNote: $exerciseNote, targetWeight: $targetWeight)';
}


}

/// @nodoc
abstract mixin class _$ExerciseEntryCopyWith<$Res> implements $ExerciseEntryCopyWith<$Res> {
  factory _$ExerciseEntryCopyWith(_ExerciseEntry value, $Res Function(_ExerciseEntry) _then) = __$ExerciseEntryCopyWithImpl;
@override @useResult
$Res call({
 String localId, String name, Modality modality, List<SetRow> sets, bool isCollapsed, bool isPrHighlighted, EquipmentType? equipment, String? exerciseNote, double? targetWeight
});




}
/// @nodoc
class __$ExerciseEntryCopyWithImpl<$Res>
    implements _$ExerciseEntryCopyWith<$Res> {
  __$ExerciseEntryCopyWithImpl(this._self, this._then);

  final _ExerciseEntry _self;
  final $Res Function(_ExerciseEntry) _then;

/// Create a copy of ExerciseEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? localId = null,Object? name = null,Object? modality = null,Object? sets = null,Object? isCollapsed = null,Object? isPrHighlighted = null,Object? equipment = freezed,Object? exerciseNote = freezed,Object? targetWeight = freezed,}) {
  return _then(_ExerciseEntry(
localId: null == localId ? _self.localId : localId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,modality: null == modality ? _self.modality : modality // ignore: cast_nullable_to_non_nullable
as Modality,sets: null == sets ? _self._sets : sets // ignore: cast_nullable_to_non_nullable
as List<SetRow>,isCollapsed: null == isCollapsed ? _self.isCollapsed : isCollapsed // ignore: cast_nullable_to_non_nullable
as bool,isPrHighlighted: null == isPrHighlighted ? _self.isPrHighlighted : isPrHighlighted // ignore: cast_nullable_to_non_nullable
as bool,equipment: freezed == equipment ? _self.equipment : equipment // ignore: cast_nullable_to_non_nullable
as EquipmentType?,exerciseNote: freezed == exerciseNote ? _self.exerciseNote : exerciseNote // ignore: cast_nullable_to_non_nullable
as String?,targetWeight: freezed == targetWeight ? _self.targetWeight : targetWeight // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
