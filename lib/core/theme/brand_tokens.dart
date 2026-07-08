import 'dart:ui';

import 'package:flutter/material.dart';

/// Design-token extension that carries brand-specific values not expressible
/// in Material 3's [ColorScheme].
///
/// Access via: `Theme.of(context).brandTokens`  (see [BrandTokensX]).
@immutable
class BrandTokens extends ThemeExtension<BrandTokens> {
  const BrandTokens({
    required this.push,
    required this.pull,
    required this.legs,
    required this.cardio,
    required this.muted,
    required this.faint,
    required this.line,
    required this.line2,
    required this.primarySoft,
    required this.good,
    required this.goodSoft,
    required this.accent,
    required this.accentSoft,
    required this.radiusCard,
    required this.radiusLarge,
    required this.radiusSmall,
    required this.cardShadow,
  });

  // ── Modality colours (theme-independent) ────────────────────────────────
  final Color push;
  final Color pull;
  final Color legs;
  final Color cardio;

  // ── Text hierarchy (secondary / tertiary) ───────────────────────────────
  final Color muted;
  final Color faint;

  // ── Borders ─────────────────────────────────────────────────────────────
  final Color line;
  final Color line2;

  // ── Semantic fills ───────────────────────────────────────────────────────
  final Color primarySoft;
  final Color good;
  final Color goodSoft;
  final Color accent;
  final Color accentSoft;

  // ── Radii ────────────────────────────────────────────────────────────────
  final double radiusCard;
  final double radiusLarge;
  final double radiusSmall;

  // ── Shadows ──────────────────────────────────────────────────────────────
  final List<BoxShadow> cardShadow;

  // ── Static instances ─────────────────────────────────────────────────────

  static const BrandTokens light = BrandTokens(
    push: Color(0xFFF5871F),
    pull: Color(0xFF2E8BFF),
    legs: Color(0xFF9B6BFF),
    cardio: Color(0xFF14B8A6),
    muted: Color(0xFF6B7280),
    faint: Color(0xFFA2A9B4),
    line: Color(0x121A1A1A),
    line2: Color(0x211A1A1A),
    primarySoft: Color(0x1AFF4D4D),
    good: Color(0xFF00C853),
    goodSoft: Color(0x2100C853),
    accent: Color(0xFF00C853),
    accentSoft: Color(0x2100C853),
    radiusCard: 16,
    radiusLarge: 20,
    radiusSmall: 13,
    cardShadow: [
      BoxShadow(
        color: Color(0x0F101828),
        blurRadius: 10,
        offset: Offset(0, 2),
      ),
      BoxShadow(
        color: Color(0x0A101828),
        blurRadius: 2,
        offset: Offset(0, 1),
      ),
    ],
  );

  static const BrandTokens dark = BrandTokens(
    push: Color(0xFFF5871F),
    pull: Color(0xFF2E8BFF),
    legs: Color(0xFF9B6BFF),
    cardio: Color(0xFF14B8A6),
    muted: Color(0xFF9A9A9A),
    faint: Color(0xFF666666),
    line: Color(0x12FFFFFF),
    line2: Color(0x24FFFFFF),
    primarySoft: Color(0x2100E5FF),
    good: Color(0xFF00E676),
    goodSoft: Color(0x2400E676),
    accent: Color(0xFFFFD600),
    accentSoft: Color(0x26FFD600),
    radiusCard: 16,
    radiusLarge: 20,
    radiusSmall: 13,
    cardShadow: [
      BoxShadow(color: Color(0x05FFFFFF), offset: Offset(0, 1)),
    ],
  );

  // ── ThemeExtension overrides ─────────────────────────────────────────────

  @override
  BrandTokens copyWith({
    Color? push,
    Color? pull,
    Color? legs,
    Color? cardio,
    Color? muted,
    Color? faint,
    Color? line,
    Color? line2,
    Color? primarySoft,
    Color? good,
    Color? goodSoft,
    Color? accent,
    Color? accentSoft,
    double? radiusCard,
    double? radiusLarge,
    double? radiusSmall,
    List<BoxShadow>? cardShadow,
  }) {
    return BrandTokens(
      push: push ?? this.push,
      pull: pull ?? this.pull,
      legs: legs ?? this.legs,
      cardio: cardio ?? this.cardio,
      muted: muted ?? this.muted,
      faint: faint ?? this.faint,
      line: line ?? this.line,
      line2: line2 ?? this.line2,
      primarySoft: primarySoft ?? this.primarySoft,
      good: good ?? this.good,
      goodSoft: goodSoft ?? this.goodSoft,
      accent: accent ?? this.accent,
      accentSoft: accentSoft ?? this.accentSoft,
      radiusCard: radiusCard ?? this.radiusCard,
      radiusLarge: radiusLarge ?? this.radiusLarge,
      radiusSmall: radiusSmall ?? this.radiusSmall,
      cardShadow: cardShadow ?? this.cardShadow,
    );
  }

  @override
  BrandTokens lerp(BrandTokens? other, double t) {
    if (other == null) return this;
    return BrandTokens(
      push: Color.lerp(push, other.push, t)!,
      pull: Color.lerp(pull, other.pull, t)!,
      legs: Color.lerp(legs, other.legs, t)!,
      cardio: Color.lerp(cardio, other.cardio, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      faint: Color.lerp(faint, other.faint, t)!,
      line: Color.lerp(line, other.line, t)!,
      line2: Color.lerp(line2, other.line2, t)!,
      primarySoft: Color.lerp(primarySoft, other.primarySoft, t)!,
      good: Color.lerp(good, other.good, t)!,
      goodSoft: Color.lerp(goodSoft, other.goodSoft, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentSoft: Color.lerp(accentSoft, other.accentSoft, t)!,
      radiusCard: lerpDouble(radiusCard, other.radiusCard, t)!,
      radiusLarge: lerpDouble(radiusLarge, other.radiusLarge, t)!,
      radiusSmall: lerpDouble(radiusSmall, other.radiusSmall, t)!,
      cardShadow:
          BoxShadow.lerpList(cardShadow, other.cardShadow, t) ?? cardShadow,
    );
  }
}

/// Shortcut to access [BrandTokens] from any [BuildContext].
extension BrandTokensX on BuildContext {
  BrandTokens get brandTokens => Theme.of(this).extension<BrandTokens>()!;
}
