import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/features/paywall/domain/entities/pro_package.dart';
import 'package:momentum/features/paywall/domain/repositories/purchases_gateway.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

const _commonApiKey = String.fromEnvironment('REVENUECAT_API_KEY');
const _androidApiKey = String.fromEnvironment('REVENUECAT_ANDROID_API_KEY');
const _appleApiKey = String.fromEnvironment('REVENUECAT_IOS_API_KEY');
const _entitlementId = String.fromEnvironment(
  'REVENUECAT_ENTITLEMENT_ID',
  defaultValue: 'pro',
);

@LazySingleton(as: PurchasesGateway)
class RevenueCatPurchasesGateway implements PurchasesGateway {
  final Map<ProStatusListener, CustomerInfoUpdateListener> _listeners = {};

  String get _apiKey => switch (defaultTargetPlatform) {
    TargetPlatform.android =>
      _androidApiKey.isEmpty ? _commonApiKey : _androidApiKey,
    TargetPlatform.iOS ||
    TargetPlatform.macOS => _appleApiKey.isEmpty ? _commonApiKey : _appleApiKey,
    _ => _commonApiKey,
  };

  bool get _supportedPlatform =>
      kIsWeb ||
      defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS ||
      defaultTargetPlatform == TargetPlatform.macOS;

  @override
  Future<bool> configure() async {
    if (!_supportedPlatform || _apiKey.trim().isEmpty) return false;
    if (kDebugMode) await Purchases.setLogLevel(LogLevel.debug);
    if (!await Purchases.isConfigured) {
      await Purchases.configure(PurchasesConfiguration(_apiKey));
    }
    return true;
  }

  @override
  Future<bool> getIsPro() async => _hasPro(await Purchases.getCustomerInfo());

  @override
  Future<List<ProPackage>> getPackages() async {
    final offering = (await Purchases.getOfferings()).current;
    if (offering == null) return const [];

    final packages = <ProPackage>[];
    final monthly =
        offering.monthly ??
        _findPackage(offering.availablePackages, PackageType.monthly);
    final annual =
        offering.annual ??
        _findPackage(offering.availablePackages, PackageType.annual);
    final lifetime =
        offering.lifetime ??
        _findPackage(offering.availablePackages, PackageType.lifetime);

    if (monthly != null) packages.add(_toDomain(monthly, ProPlan.monthly));
    if (annual != null) packages.add(_toDomain(annual, ProPlan.annual));
    if (lifetime != null) packages.add(_toDomain(lifetime, ProPlan.lifetime));
    return packages;
  }

  @override
  Future<ProPurchaseResult> purchase(ProPackage package) async {
    final storePackage = package.storePackage;
    if (storePackage is! Package) {
      return ProPurchaseResult.entitlementInactive;
    }
    try {
      final result = await Purchases.purchase(
        PurchaseParams.package(storePackage),
      );
      return _hasPro(result.customerInfo)
          ? ProPurchaseResult.proActive
          : ProPurchaseResult.entitlementInactive;
    } on PlatformException catch (error) {
      if (PurchasesErrorHelper.getErrorCode(error) ==
          PurchasesErrorCode.purchaseCancelledError) {
        return ProPurchaseResult.cancelled;
      }
      rethrow;
    }
  }

  @override
  Future<bool> restore() async => _hasPro(await Purchases.restorePurchases());

  @override
  void addProStatusListener(ProStatusListener listener) {
    if (_listeners.containsKey(listener)) return;
    void revenueCatListener(CustomerInfo info) =>
        listener(isPro: _hasPro(info));
    _listeners[listener] = revenueCatListener;
    Purchases.addCustomerInfoUpdateListener(revenueCatListener);
  }

  @override
  void removeProStatusListener(ProStatusListener listener) {
    final revenueCatListener = _listeners.remove(listener);
    if (revenueCatListener != null) {
      Purchases.removeCustomerInfoUpdateListener(revenueCatListener);
    }
  }

  bool _hasPro(CustomerInfo info) =>
      info.entitlements.active.containsKey(_entitlementId);

  Package? _findPackage(List<Package> packages, PackageType type) {
    for (final package in packages) {
      if (package.packageType == type) return package;
    }
    return null;
  }

  ProPackage _toDomain(Package package, ProPlan plan) => ProPackage(
    identifier: package.identifier,
    plan: plan,
    price: package.storeProduct.priceString,
    storePackage: package,
  );
}
