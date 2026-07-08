import 'package:flutter/material.dart';
import 'package:momentum/core/theme/brand_tokens.dart';

/// Exposes [light] and [dark] [ThemeData] built from the exact design tokens
/// documented in CLAUDE.md and the clickable prototype.
abstract final class AppTheme {
  static final ThemeData light = _build(Brightness.light);
  static final ThemeData dark = _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isLight = brightness == Brightness.light;
    final scheme = isLight ? _lightScheme : _darkScheme;
    final tokens = isLight ? BrandTokens.light : BrandTokens.dark;
    final textTheme = _textTheme(brightness);
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: isLight
          ? const Color(0xFFF8F9FA)
          : const Color(0xFF121212),
      textTheme: textTheme,
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        toolbarHeight: 56,
        backgroundColor: Colors.transparent,
        foregroundColor: scheme.onSurface,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: textTheme.titleMedium?.copyWith(
          color: scheme.onSurface,
          fontWeight: FontWeight.w700,
        ),
      ),
      cardTheme: CardThemeData(
        margin: EdgeInsets.zero,
        elevation: 0,
        color: scheme.surface,
        surfaceTintColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(tokens.radiusCard),
          side: BorderSide(color: tokens.line),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(0, 50),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(tokens.radiusSmall),
          ),
          textStyle: textTheme.labelLarge?.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.onSurface,
          side: BorderSide(color: tokens.line2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: scheme.primary,
          textStyle: textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 0,
        highlightElevation: 0,
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(19),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: scheme.surfaceContainerLow,
        modalBackgroundColor: scheme.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
        showDragHandle: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: scheme.surfaceContainerLow,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(tokens.radiusLarge),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surface,
        hintStyle: textTheme.bodyMedium?.copyWith(color: tokens.faint),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 13,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: tokens.line2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: tokens.line2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.primary),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: scheme.surface,
        selectedColor: scheme.primary,
        disabledColor: scheme.surface,
        side: BorderSide(color: tokens.line),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(11),
        ),
        labelStyle: textTheme.labelMedium?.copyWith(
          color: tokens.muted,
          fontWeight: FontWeight.w600,
        ),
        secondaryLabelStyle: textTheme.labelMedium?.copyWith(
          color: scheme.onPrimary,
          fontWeight: FontWeight.w700,
        ),
        showCheckmark: false,
      ),
      dividerColor: tokens.line,
      extensions: [tokens],
    );
  }

  // ── Colour schemes ───────────────────────────────────────────────────────

  static final ColorScheme _lightScheme =
      ColorScheme.fromSeed(
        seedColor: const Color(0xFFFF4D4D),
      ).copyWith(
        primary: const Color(0xFFFF4D4D),
        onPrimary: const Color(0xFFFFFFFF),
        secondary: const Color(0xFF00C853),
        onSecondary: const Color(0xFF000000),
        surface: const Color(0xFFFFFFFF),
        onSurface: const Color(0xFF1A1A1A),
        // Surface container hierarchy maps to prototype --elevated tokens.
        surfaceContainerLowest: const Color(0xFFF8F9FA),
        surfaceContainerLow: const Color(0xFFF1F3F5),
        surfaceContainer: const Color(0xFFE7EBEF),
        surfaceContainerHigh: const Color(0xFFDDE2E8),
        error: const Color(0xFFE5484D),
        onError: const Color(0xFFFFFFFF),
      );

  static final ColorScheme _darkScheme =
      ColorScheme.fromSeed(
        seedColor: const Color(0xFF00E5FF),
        brightness: Brightness.dark,
      ).copyWith(
        primary: const Color(0xFF00E5FF),
        onPrimary: const Color(0xFF062A33),
        secondary: const Color(0xFF00E676),
        onSecondary: const Color(0xFF000000),
        surface: const Color(0xFF1E1E1E),
        onSurface: const Color(0xFFE0E0E0),
        surfaceContainerLowest: const Color(0xFF121212),
        surfaceContainerLow: const Color(0xFF262626),
        surfaceContainer: const Color(0xFF333333),
        surfaceContainerHigh: const Color(0xFF3D3D3D),
        error: const Color(0xFFFF6B6B),
        onError: const Color(0xFF000000),
      );

  // ── Text theme ───────────────────────────────────────────────────────────
  //
  // Space Grotesk (with tabular figures) → display + headline sizes.
  // Inter → everything else (title, body, label).

  static TextTheme _textTheme(Brightness brightness) {
    final base = brightness == Brightness.dark
        ? ThemeData.dark().textTheme
        : ThemeData.light().textTheme;
    final inter = base.apply(fontFamily: 'Inter');
    final sg = base.apply(fontFamily: 'Space Grotesk');

    // Apply tabular figures to all Space Grotesk styles.
    TextStyle tab(TextStyle? s) => (s ?? const TextStyle()).copyWith(
      fontFeatures: const [FontFeature.tabularFigures()],
    );

    return inter.copyWith(
      displayLarge: tab(sg.displayLarge),
      displayMedium: tab(sg.displayMedium),
      displaySmall: tab(sg.displaySmall),
      headlineLarge: tab(sg.headlineLarge),
      headlineMedium: tab(sg.headlineMedium),
      headlineSmall: tab(sg.headlineSmall),
    );
  }
}
