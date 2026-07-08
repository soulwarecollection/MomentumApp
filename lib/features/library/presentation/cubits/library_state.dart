import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/core/enums/modality.dart';
import 'package:momentum/features/library/domain/entities/exercise.dart';

part 'library_state.freezed.dart';

@freezed
sealed class LibraryState with _$LibraryState {
  const factory LibraryState.loading() = LibraryLoading;

  const factory LibraryState.ready({
    required List<Exercise> exercises,
    @Default('') String query,
    Modality? selectedModality,
  }) = LibraryReady;

  const factory LibraryState.error(String message) = LibraryError;
}
