import 'package:momentum/features/paywall/domain/entities/pro_package.dart';

typedef ProStatusListener = void Function({required bool isPro});

enum ProPurchaseResult {
  proActive,
  cancelled,
  entitlementInactive,
}

abstract class PurchasesGateway {
  Future<bool> configure();

  Future<bool> getIsPro();

  Future<List<ProPackage>> getPackages();

  Future<ProPurchaseResult> purchase(ProPackage package);

  Future<bool> restore();

  void addProStatusListener(ProStatusListener listener);

  void removeProStatusListener(ProStatusListener listener);
}
