// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HistoryState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HistoryState()';
}


}

/// @nodoc
class $HistoryStateCopyWith<$Res>  {
$HistoryStateCopyWith(HistoryState _, $Res Function(HistoryState) __);
}


/// Adds pattern-matching-related methods to [HistoryState].
extension HistoryStatePatterns on HistoryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HistoryLoading value)?  loading,TResult Function( HistoryReady value)?  ready,TResult Function( HistoryError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HistoryLoading() when loading != null:
return loading(_that);case HistoryReady() when ready != null:
return ready(_that);case HistoryError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HistoryLoading value)  loading,required TResult Function( HistoryReady value)  ready,required TResult Function( HistoryError value)  error,}){
final _that = this;
switch (_that) {
case HistoryLoading():
return loading(_that);case HistoryReady():
return ready(_that);case HistoryError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HistoryLoading value)?  loading,TResult? Function( HistoryReady value)?  ready,TResult? Function( HistoryError value)?  error,}){
final _that = this;
switch (_that) {
case HistoryLoading() when loading != null:
return loading(_that);case HistoryReady() when ready != null:
return ready(_that);case HistoryError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loading,TResult Function( List<HeatmapCell> heatmap,  List<SessionSummary> sessions)?  ready,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HistoryLoading() when loading != null:
return loading();case HistoryReady() when ready != null:
return ready(_that.heatmap,_that.sessions);case HistoryError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loading,required TResult Function( List<HeatmapCell> heatmap,  List<SessionSummary> sessions)  ready,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case HistoryLoading():
return loading();case HistoryReady():
return ready(_that.heatmap,_that.sessions);case HistoryError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loading,TResult? Function( List<HeatmapCell> heatmap,  List<SessionSummary> sessions)?  ready,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case HistoryLoading() when loading != null:
return loading();case HistoryReady() when ready != null:
return ready(_that.heatmap,_that.sessions);case HistoryError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class HistoryLoading implements HistoryState {
  const HistoryLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HistoryState.loading()';
}


}




/// @nodoc


class HistoryReady implements HistoryState {
  const HistoryReady({required final  List<HeatmapCell> heatmap, required final  List<SessionSummary> sessions}): _heatmap = heatmap,_sessions = sessions;
  

 final  List<HeatmapCell> _heatmap;
 List<HeatmapCell> get heatmap {
  if (_heatmap is EqualUnmodifiableListView) return _heatmap;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_heatmap);
}

 final  List<SessionSummary> _sessions;
 List<SessionSummary> get sessions {
  if (_sessions is EqualUnmodifiableListView) return _sessions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sessions);
}


/// Create a copy of HistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryReadyCopyWith<HistoryReady> get copyWith => _$HistoryReadyCopyWithImpl<HistoryReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryReady&&const DeepCollectionEquality().equals(other._heatmap, _heatmap)&&const DeepCollectionEquality().equals(other._sessions, _sessions));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_heatmap),const DeepCollectionEquality().hash(_sessions));

@override
String toString() {
  return 'HistoryState.ready(heatmap: $heatmap, sessions: $sessions)';
}


}

/// @nodoc
abstract mixin class $HistoryReadyCopyWith<$Res> implements $HistoryStateCopyWith<$Res> {
  factory $HistoryReadyCopyWith(HistoryReady value, $Res Function(HistoryReady) _then) = _$HistoryReadyCopyWithImpl;
@useResult
$Res call({
 List<HeatmapCell> heatmap, List<SessionSummary> sessions
});




}
/// @nodoc
class _$HistoryReadyCopyWithImpl<$Res>
    implements $HistoryReadyCopyWith<$Res> {
  _$HistoryReadyCopyWithImpl(this._self, this._then);

  final HistoryReady _self;
  final $Res Function(HistoryReady) _then;

/// Create a copy of HistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? heatmap = null,Object? sessions = null,}) {
  return _then(HistoryReady(
heatmap: null == heatmap ? _self._heatmap : heatmap // ignore: cast_nullable_to_non_nullable
as List<HeatmapCell>,sessions: null == sessions ? _self._sessions : sessions // ignore: cast_nullable_to_non_nullable
as List<SessionSummary>,
  ));
}


}

/// @nodoc


class HistoryError implements HistoryState {
  const HistoryError(this.message);
  

 final  String message;

/// Create a copy of HistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryErrorCopyWith<HistoryError> get copyWith => _$HistoryErrorCopyWithImpl<HistoryError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'HistoryState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $HistoryErrorCopyWith<$Res> implements $HistoryStateCopyWith<$Res> {
  factory $HistoryErrorCopyWith(HistoryError value, $Res Function(HistoryError) _then) = _$HistoryErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$HistoryErrorCopyWithImpl<$Res>
    implements $HistoryErrorCopyWith<$Res> {
  _$HistoryErrorCopyWithImpl(this._self, this._then);

  final HistoryError _self;
  final $Res Function(HistoryError) _then;

/// Create a copy of HistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(HistoryError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
