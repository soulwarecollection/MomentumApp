import 'package:momentum/features/paywall/domain/entities/pro_package.dart';
import 'package:momentum/features/paywall/domain/repositories/purchases_gateway.dart';

class FakePurchasesGateway implements PurchasesGateway {
  bool configureResult = true;
  bool isPro = false;
  bool restoreResult = false;
  ProPurchaseResult purchaseResult = ProPurchaseResult.proActive;
  List<ProPackage> packages = const [];

  int configureCalls = 0;
  int packageCalls = 0;
  int purchaseCalls = 0;
  int restoreCalls = 0;

  final List<ProStatusListener> _listeners = [];

  @override
  Future<bool> configure() async {
    configureCalls++;
    return configureResult;
  }

  @override
  Future<bool> getIsPro() async => isPro;

  @override
  Future<List<ProPackage>> getPackages() async {
    packageCalls++;
    return packages;
  }

  @override
  Future<ProPurchaseResult> purchase(ProPackage package) async {
    purchaseCalls++;
    if (purchaseResult == ProPurchaseResult.proActive) {
      setPro(isPro: true);
    }
    return purchaseResult;
  }

  @override
  Future<bool> restore() async {
    restoreCalls++;
    if (restoreResult) setPro(isPro: true);
    return restoreResult;
  }

  @override
  void addProStatusListener(ProStatusListener listener) {
    _listeners.add(listener);
  }

  @override
  void removeProStatusListener(ProStatusListener listener) {
    _listeners.remove(listener);
  }

  void setPro({required bool isPro}) {
    this.isPro = isPro;
    for (final listener in List<ProStatusListener>.of(_listeners)) {
      listener(isPro: isPro);
    }
  }
}
