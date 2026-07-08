// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'library_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LibraryState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LibraryState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LibraryState()';
}


}

/// @nodoc
class $LibraryStateCopyWith<$Res>  {
$LibraryStateCopyWith(LibraryState _, $Res Function(LibraryState) __);
}


/// Adds pattern-matching-related methods to [LibraryState].
extension LibraryStatePatterns on LibraryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LibraryLoading value)?  loading,TResult Function( LibraryReady value)?  ready,TResult Function( LibraryError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LibraryLoading() when loading != null:
return loading(_that);case LibraryReady() when ready != null:
return ready(_that);case LibraryError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LibraryLoading value)  loading,required TResult Function( LibraryReady value)  ready,required TResult Function( LibraryError value)  error,}){
final _that = this;
switch (_that) {
case LibraryLoading():
return loading(_that);case LibraryReady():
return ready(_that);case LibraryError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LibraryLoading value)?  loading,TResult? Function( LibraryReady value)?  ready,TResult? Function( LibraryError value)?  error,}){
final _that = this;
switch (_that) {
case LibraryLoading() when loading != null:
return loading(_that);case LibraryReady() when ready != null:
return ready(_that);case LibraryError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( List<Exercise> exercises,  String query,  Modality? selectedModality)?  ready,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LibraryLoading() when loading != null:
return loading();case LibraryReady() when ready != null:
return ready(_that.exercises,_that.query,_that.selectedModality);case LibraryError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( List<Exercise> exercises,  String query,  Modality? selectedModality)  ready,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case LibraryLoading():
return loading();case LibraryReady():
return ready(_that.exercises,_that.query,_that.selectedModality);case LibraryError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( List<Exercise> exercises,  String query,  Modality? selectedModality)?  ready,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case LibraryLoading() when loading != null:
return loading();case LibraryReady() when ready != null:
return ready(_that.exercises,_that.query,_that.selectedModality);case LibraryError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class LibraryLoading implements LibraryState {
  const LibraryLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LibraryLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LibraryState.loading()';
}


}




/// @nodoc


class LibraryReady implements LibraryState {
  const LibraryReady({required final  List<Exercise> exercises, this.query = '', this.selectedModality}): _exercises = exercises;
  

 final  List<Exercise> _exercises;
 List<Exercise> get exercises {
  if (_exercises is EqualUnmodifiableListView) return _exercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exercises);
}

@JsonKey() final  String query;
 final  Modality? selectedModality;

/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LibraryReadyCopyWith<LibraryReady> get copyWith => _$LibraryReadyCopyWithImpl<LibraryReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LibraryReady&&const DeepCollectionEquality().equals(other._exercises, _exercises)&&(identical(other.query, query) || other.query == query)&&(identical(other.selectedModality, selectedModality) || other.selectedModality == selectedModality));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_exercises),query,selectedModality);

@override
String toString() {
  return 'LibraryState.ready(exercises: $exercises, query: $query, selectedModality: $selectedModality)';
}


}

/// @nodoc
abstract mixin class $LibraryReadyCopyWith<$Res> implements $LibraryStateCopyWith<$Res> {
  factory $LibraryReadyCopyWith(LibraryReady value, $Res Function(LibraryReady) _then) = _$LibraryReadyCopyWithImpl;
@useResult
$Res call({
 List<Exercise> exercises, String query, Modality? selectedModality
});




}
/// @nodoc
class _$LibraryReadyCopyWithImpl<$Res>
    implements $LibraryReadyCopyWith<$Res> {
  _$LibraryReadyCopyWithImpl(this._self, this._then);

  final LibraryReady _self;
  final $Res Function(LibraryReady) _then;

/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? exercises = null,Object? query = null,Object? selectedModality = freezed,}) {
  return _then(LibraryReady(
exercises: null == exercises ? _self._exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<Exercise>,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,selectedModality: freezed == selectedModality ? _self.selectedModality : selectedModality // ignore: cast_nullable_to_non_nullable
as Modality?,
  ));
}


}

/// @nodoc


class LibraryError implements LibraryState {
  const LibraryError(this.message);
  

 final  String message;

/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LibraryErrorCopyWith<LibraryError> get copyWith => _$LibraryErrorCopyWithImpl<LibraryError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LibraryError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'LibraryState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $LibraryErrorCopyWith<$Res> implements $LibraryStateCopyWith<$Res> {
  factory $LibraryErrorCopyWith(LibraryError value, $Res Function(LibraryError) _then) = _$LibraryErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$LibraryErrorCopyWithImpl<$Res>
    implements $LibraryErrorCopyWith<$Res> {
  _$LibraryErrorCopyWithImpl(this._self, this._then);

  final LibraryError _self;
  final $Res Function(LibraryError) _then;

/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(LibraryError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
