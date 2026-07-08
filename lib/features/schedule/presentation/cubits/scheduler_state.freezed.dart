// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'scheduler_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SchedulerState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SchedulerState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SchedulerState()';
}


}

/// @nodoc
class $SchedulerStateCopyWith<$Res>  {
$SchedulerStateCopyWith(SchedulerState _, $Res Function(SchedulerState) __);
}


/// Adds pattern-matching-related methods to [SchedulerState].
extension SchedulerStatePatterns on SchedulerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SchedulerLoading value)?  loading,TResult Function( SchedulerReady value)?  ready,TResult Function( SchedulerError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SchedulerLoading() when loading != null:
return loading(_that);case SchedulerReady() when ready != null:
return ready(_that);case SchedulerError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SchedulerLoading value)  loading,required TResult Function( SchedulerReady value)  ready,required TResult Function( SchedulerError value)  error,}){
final _that = this;
switch (_that) {
case SchedulerLoading():
return loading(_that);case SchedulerReady():
return ready(_that);case SchedulerError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SchedulerLoading value)?  loading,TResult? Function( SchedulerReady value)?  ready,TResult? Function( SchedulerError value)?  error,}){
final _that = this;
switch (_that) {
case SchedulerLoading() when loading != null:
return loading(_that);case SchedulerReady() when ready != null:
return ready(_that);case SchedulerError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( List<Plan> plans,  int selectedPlanId,  List<PlanDay> selectedPlanDays,  int selectedDayIndex,  DateTime? scheduledDate)?  ready,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SchedulerLoading() when loading != null:
return loading();case SchedulerReady() when ready != null:
return ready(_that.plans,_that.selectedPlanId,_that.selectedPlanDays,_that.selectedDayIndex,_that.scheduledDate);case SchedulerError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( List<Plan> plans,  int selectedPlanId,  List<PlanDay> selectedPlanDays,  int selectedDayIndex,  DateTime? scheduledDate)  ready,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case SchedulerLoading():
return loading();case SchedulerReady():
return ready(_that.plans,_that.selectedPlanId,_that.selectedPlanDays,_that.selectedDayIndex,_that.scheduledDate);case SchedulerError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( List<Plan> plans,  int selectedPlanId,  List<PlanDay> selectedPlanDays,  int selectedDayIndex,  DateTime? scheduledDate)?  ready,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case SchedulerLoading() when loading != null:
return loading();case SchedulerReady() when ready != null:
return ready(_that.plans,_that.selectedPlanId,_that.selectedPlanDays,_that.selectedDayIndex,_that.scheduledDate);case SchedulerError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class SchedulerLoading implements SchedulerState {
  const SchedulerLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SchedulerLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SchedulerState.loading()';
}


}




/// @nodoc


class SchedulerReady implements SchedulerState {
  const SchedulerReady({required final  List<Plan> plans, required this.selectedPlanId, required final  List<PlanDay> selectedPlanDays, required this.selectedDayIndex, this.scheduledDate}): _plans = plans,_selectedPlanDays = selectedPlanDays;
  

 final  List<Plan> _plans;
 List<Plan> get plans {
  if (_plans is EqualUnmodifiableListView) return _plans;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_plans);
}

 final  int selectedPlanId;
 final  List<PlanDay> _selectedPlanDays;
 List<PlanDay> get selectedPlanDays {
  if (_selectedPlanDays is EqualUnmodifiableListView) return _selectedPlanDays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedPlanDays);
}

 final  int selectedDayIndex;
 final  DateTime? scheduledDate;

/// Create a copy of SchedulerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SchedulerReadyCopyWith<SchedulerReady> get copyWith => _$SchedulerReadyCopyWithImpl<SchedulerReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SchedulerReady&&const DeepCollectionEquality().equals(other._plans, _plans)&&(identical(other.selectedPlanId, selectedPlanId) || other.selectedPlanId == selectedPlanId)&&const DeepCollectionEquality().equals(other._selectedPlanDays, _selectedPlanDays)&&(identical(other.selectedDayIndex, selectedDayIndex) || other.selectedDayIndex == selectedDayIndex)&&(identical(other.scheduledDate, scheduledDate) || other.scheduledDate == scheduledDate));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_plans),selectedPlanId,const DeepCollectionEquality().hash(_selectedPlanDays),selectedDayIndex,scheduledDate);

@override
String toString() {
  return 'SchedulerState.ready(plans: $plans, selectedPlanId: $selectedPlanId, selectedPlanDays: $selectedPlanDays, selectedDayIndex: $selectedDayIndex, scheduledDate: $scheduledDate)';
}


}

/// @nodoc
abstract mixin class $SchedulerReadyCopyWith<$Res> implements $SchedulerStateCopyWith<$Res> {
  factory $SchedulerReadyCopyWith(SchedulerReady value, $Res Function(SchedulerReady) _then) = _$SchedulerReadyCopyWithImpl;
@useResult
$Res call({
 List<Plan> plans, int selectedPlanId, List<PlanDay> selectedPlanDays, int selectedDayIndex, DateTime? scheduledDate
});




}
/// @nodoc
class _$SchedulerReadyCopyWithImpl<$Res>
    implements $SchedulerReadyCopyWith<$Res> {
  _$SchedulerReadyCopyWithImpl(this._self, this._then);

  final SchedulerReady _self;
  final $Res Function(SchedulerReady) _then;

/// Create a copy of SchedulerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? plans = null,Object? selectedPlanId = null,Object? selectedPlanDays = null,Object? selectedDayIndex = null,Object? scheduledDate = freezed,}) {
  return _then(SchedulerReady(
plans: null == plans ? _self._plans : plans // ignore: cast_nullable_to_non_nullable
as List<Plan>,selectedPlanId: null == selectedPlanId ? _self.selectedPlanId : selectedPlanId // ignore: cast_nullable_to_non_nullable
as int,selectedPlanDays: null == selectedPlanDays ? _self._selectedPlanDays : selectedPlanDays // ignore: cast_nullable_to_non_nullable
as List<PlanDay>,selectedDayIndex: null == selectedDayIndex ? _self.selectedDayIndex : selectedDayIndex // ignore: cast_nullable_to_non_nullable
as int,scheduledDate: freezed == scheduledDate ? _self.scheduledDate : scheduledDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class SchedulerError implements SchedulerState {
  const SchedulerError(this.message);
  

 final  String message;

/// Create a copy of SchedulerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SchedulerErrorCopyWith<SchedulerError> get copyWith => _$SchedulerErrorCopyWithImpl<SchedulerError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SchedulerError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SchedulerState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $SchedulerErrorCopyWith<$Res> implements $SchedulerStateCopyWith<$Res> {
  factory $SchedulerErrorCopyWith(SchedulerError value, $Res Function(SchedulerError) _then) = _$SchedulerErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SchedulerErrorCopyWithImpl<$Res>
    implements $SchedulerErrorCopyWith<$Res> {
  _$SchedulerErrorCopyWithImpl(this._self, this._then);

  final SchedulerError _self;
  final $Res Function(SchedulerError) _then;

/// Create a copy of SchedulerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SchedulerError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
