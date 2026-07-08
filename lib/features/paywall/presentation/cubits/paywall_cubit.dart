import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/features/paywall/domain/entities/pro_package.dart';
import 'package:momentum/features/paywall/domain/repositories/purchases_gateway.dart';
import 'package:momentum/features/paywall/presentation/cubits/entitlement_cubit.dart';

enum PaywallStatus {
  loading,
  ready,
  purchasing,
  restoring,
  success,
  error,
}

@immutable
class PaywallState {
  const PaywallState({
    required this.status,
    required this.packages,
    required this.selectedPlan,
    required this.storeConfigured,
    this.message,
  });

  const PaywallState.loading()
    : status = PaywallStatus.loading,
      packages = const [],
      selectedPlan = ProPlan.annual,
      storeConfigured = false,
      message = null;

  final PaywallStatus status;
  final List<ProPackage> packages;
  final ProPlan selectedPlan;
  final bool storeConfigured;
  final String? message;

  ProPackage get selectedPackage => packages.firstWhere(
    (package) => package.plan == selectedPlan,
    orElse: () => ProPackage.fallback.first,
  );

  bool get isBusy =>
      status == PaywallStatus.purchasing || status == PaywallStatus.restoring;

  PaywallState copyWith({
    PaywallStatus? status,
    List<ProPackage>? packages,
    ProPlan? selectedPlan,
    bool? storeConfigured,
    String? message,
    bool clearMessage = false,
  }) => PaywallState(
    status: status ?? this.status,
    packages: packages ?? this.packages,
    selectedPlan: selectedPlan ?? this.selectedPlan,
    storeConfigured: storeConfigured ?? this.storeConfigured,
    message: clearMessage ? null : message ?? this.message,
  );
}

@injectable
class PaywallCubit extends Cubit<PaywallState> {
  PaywallCubit(this._gateway, this._entitlement)
    : super(const PaywallState.loading());

  final PurchasesGateway _gateway;
  final EntitlementCubit _entitlement;

  Future<void> load() async {
    final configured = _entitlement.state.isRevenueCatConfigured;
    if (!configured) {
      emit(
        const PaywallState(
          status: PaywallStatus.ready,
          packages: ProPackage.fallback,
          selectedPlan: ProPlan.annual,
          storeConfigured: false,
          message:
              'Add REVENUECAT_API_KEY with --dart-define to enable checkout.',
        ),
      );
      return;
    }

    try {
      final storePackages = await _gateway.getPackages();
      final packages = ProPlan.values
          .map((plan) {
            for (final package in storePackages) {
              if (package.plan == plan) return package;
            }
            return ProPackage.fallback.firstWhere(
              (package) => package.plan == plan,
            );
          })
          .toList(growable: false);
      final hasAllProducts = packages.every((package) => package.isPurchasable);
      emit(
        PaywallState(
          status: PaywallStatus.ready,
          packages: packages,
          selectedPlan: ProPlan.annual,
          storeConfigured: true,
          message: hasAllProducts
              ? null
              : 'Configure monthly, annual, and lifetime packages '
                    'in RevenueCat.',
        ),
      );
    } on Object catch (error) {
      emit(
        PaywallState(
          status: PaywallStatus.error,
          packages: ProPackage.fallback,
          selectedPlan: ProPlan.annual,
          storeConfigured: true,
          message: 'Could not load products: $error',
        ),
      );
    }
  }

  void selectPlan(ProPlan plan) {
    if (state.isBusy) return;
    emit(state.copyWith(selectedPlan: plan, clearMessage: true));
  }

  Future<void> purchaseSelected() async {
    final package = state.selectedPackage;
    if (!package.isPurchasable) {
      emit(
        state.copyWith(
          status: PaywallStatus.error,
          message: 'This product is not available from the store yet.',
        ),
      );
      return;
    }

    emit(state.copyWith(status: PaywallStatus.purchasing, clearMessage: true));
    try {
      final result = await _gateway.purchase(package);
      switch (result) {
        case ProPurchaseResult.proActive:
          await _entitlement.refresh();
          emit(state.copyWith(status: PaywallStatus.success));
        case ProPurchaseResult.cancelled:
          emit(state.copyWith(status: PaywallStatus.ready));
        case ProPurchaseResult.entitlementInactive:
          emit(
            state.copyWith(
              status: PaywallStatus.error,
              message: 'Purchase completed, but Pro is not active yet.',
            ),
          );
      }
    } on Object catch (error) {
      emit(
        state.copyWith(
          status: PaywallStatus.error,
          message: 'Purchase failed: $error',
        ),
      );
    }
  }

  Future<void> restore() async {
    if (!state.storeConfigured) return;
    emit(state.copyWith(status: PaywallStatus.restoring, clearMessage: true));
    try {
      final isPro = await _gateway.restore();
      if (isPro) {
        await _entitlement.refresh();
        emit(state.copyWith(status: PaywallStatus.success));
      } else {
        emit(
          state.copyWith(
            status: PaywallStatus.ready,
            message: 'No active Momentum Pro purchase was found.',
          ),
        );
      }
    } on Object catch (error) {
      emit(
        state.copyWith(
          status: PaywallStatus.error,
          message: 'Restore failed: $error',
        ),
      );
    }
  }
}
