enum DateRange {
  oneMonth,
  threeMonths,
  sixMonths,
  oneYear
  ;

  int? get days => switch (this) {
    DateRange.oneMonth => 30,
    DateRange.threeMonths => 90,
    DateRange.sixMonths => 180,
    DateRange.oneYear => 365,
  };

  bool get isPro => switch (this) {
    DateRange.oneMonth || DateRange.threeMonths => false,
    DateRange.sixMonths || DateRange.oneYear => true,
  };

  String get label => switch (this) {
    DateRange.oneMonth => '1M',
    DateRange.threeMonths => '3M',
    DateRange.sixMonths => '6M',
    DateRange.oneYear => '1Y',
  };
}
