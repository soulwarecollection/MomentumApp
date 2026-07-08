enum ProPlan {
  monthly,
  annual,
  lifetime
  ;

  String get label => switch (this) {
    ProPlan.monthly => 'Monthly',
    ProPlan.annual => 'Annual',
    ProPlan.lifetime => 'Lifetime',
  };

  String get periodLabel => switch (this) {
    ProPlan.monthly => '/mo',
    ProPlan.annual => '/yr',
    ProPlan.lifetime => 'once',
  };

  String? get badge => switch (this) {
    ProPlan.monthly => null,
    ProPlan.annual => 'SAVE 43%',
    ProPlan.lifetime => 'BEST VALUE',
  };
}

class ProPackage {
  const ProPackage({
    required this.identifier,
    required this.plan,
    required this.price,
    this.storePackage,
  });

  final String identifier;
  final ProPlan plan;
  final String price;

  /// Opaque store object owned by the purchases gateway.
  final Object? storePackage;

  bool get isPurchasable => storePackage != null;

  /// A per-month equivalent for the annual plan, parsed from [price] —
  /// anchors the Annual card against the Monthly price so the saving
  /// reads as a concrete number, not just a badge (Contrast Effect).
  String? get perMonthEquivalent {
    if (plan != ProPlan.annual) return null;
    final match = RegExp(r'^([^\d]*)([\d.,]+)').firstMatch(price);
    if (match == null) return null;
    final symbol = match.group(1) ?? '';
    final numeric = double.tryParse(match.group(2)!.replaceAll(',', ''));
    if (numeric == null) return null;
    return '$symbol${(numeric / 12).toStringAsFixed(2)}/mo';
  }

  static const fallback = [
    ProPackage(
      identifier: 'monthly',
      plan: ProPlan.monthly,
      price: r'$3.49',
    ),
    ProPackage(
      identifier: 'annual',
      plan: ProPlan.annual,
      price: r'$23.99',
    ),
    ProPackage(
      identifier: 'lifetime',
      plan: ProPlan.lifetime,
      price: r'$59.99',
    ),
  ];
}
