import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/theme/theme_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('ThemeCubit', () {
    late SharedPreferences prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
    });

    blocTest<ThemeCubit, ThemeMode>(
      'initial state defaults to ThemeMode.system',
      build: () => ThemeCubit(prefs),
      verify: (cubit) => expect(cubit.state, ThemeMode.system),
    );

    blocTest<ThemeCubit, ThemeMode>(
      'emits ThemeMode.dark when setThemeMode(dark) is called',
      build: () => ThemeCubit(prefs),
      act: (cubit) => cubit.setThemeMode(ThemeMode.dark),
      expect: () => [ThemeMode.dark],
    );

    blocTest<ThemeCubit, ThemeMode>(
      'emits ThemeMode.light after toggling back',
      build: () => ThemeCubit(prefs),
      act: (cubit) async {
        await cubit.setThemeMode(ThemeMode.dark);
        await cubit.setThemeMode(ThemeMode.light);
      },
      expect: () => [ThemeMode.dark, ThemeMode.light],
    );

    test('loads persisted theme mode on construction', () async {
      SharedPreferences.setMockInitialValues({'theme_mode': 'dark'});
      final persistedPrefs = await SharedPreferences.getInstance();
      final cubit = ThemeCubit(persistedPrefs);
      expect(cubit.state, ThemeMode.dark);
    });
  });
}
