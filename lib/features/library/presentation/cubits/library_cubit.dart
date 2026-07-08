import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/core/enums/modality.dart';
import 'package:momentum/features/library/domain/repositories/library_repository.dart';
import 'package:momentum/features/library/presentation/cubits/library_state.dart';

@injectable
class LibraryCubit extends Cubit<LibraryState> {
  LibraryCubit(this._repo) : super(const LibraryState.loading());

  final LibraryRepository _repo;
  StreamSubscription<dynamic>? _sub;
  String _query = '';
  Modality? _modality;

  void load() => _subscribe();

  void setQuery(String q) {
    _query = q;
    _subscribe();
  }

  void setModality(Modality? m) {
    _modality = m;
    _subscribe();
  }

  void _subscribe() {
    if (_sub != null) unawaited(_sub!.cancel());
    _sub = _repo
        .watchExercises(
          query: _query.isEmpty ? null : _query,
          modality: _modality,
        )
        .listen(
          (exercises) => emit(
            LibraryState.ready(
              exercises: exercises,
              query: _query,
              selectedModality: _modality,
            ),
          ),
          onError: (Object e) => emit(LibraryState.error(e.toString())),
        );
  }

  @override
  Future<void> close() async {
    await _sub?.cancel();
    return super.close();
  }
}
