import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persists and exposes the current [ThemeMode].
///
/// Reads the stored value from [SharedPreferences] on construction; defaults
/// to [ThemeMode.system] when no value has been saved.
@singleton
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(this._prefs) : super(_load(_prefs));

  final SharedPreferences _prefs;
  static const String _key = 'theme_mode';

  static ThemeMode _load(SharedPreferences prefs) {
    final raw = prefs.getString(_key);
    return ThemeMode.values.firstWhere(
      (m) => m.name == raw,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await _prefs.setString(_key, mode.name);
    emit(mode);
  }
}
