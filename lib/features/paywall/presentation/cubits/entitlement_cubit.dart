import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/features/paywall/domain/repositories/purchases_gateway.dart';
import 'package:shared_preferences/shared_preferences.dart';

@immutable
class EntitlementState {
  const EntitlementState({
    required this.isLoading,
    required this.isPro,
    required this.isRevenueCatConfigured,
    required this.isDebugOverride,
    this.error,
  });

  const EntitlementState.loading()
    : isLoading = true,
      isPro = false,
      isRevenueCatConfigured = false,
      isDebugOverride = false,
      error = null;

  final bool isLoading;
  final bool isPro;
  final bool isRevenueCatConfigured;
  final bool isDebugOverride;
  final String? error;
}

@singleton
class EntitlementCubit extends Cubit<EntitlementState> {
  EntitlementCubit(this._gateway, this._prefs)
    : super(const EntitlementState.loading());

  static const _debugProKey = 'debug_pro_override';

  final PurchasesGateway _gateway;
  final SharedPreferences _prefs;

  bool _initialized = false;
  bool _listenerAttached = false;
  bool _revenueCatPro = false;
  bool _debugOverride = false;
  late final ProStatusListener _listener = _onProStatusChanged;

  Future<void> initialize() async {
    if (_initialized) return;
    _initialized = true;
    _debugOverride = kDebugMode && (_prefs.getBool(_debugProKey) ?? false);

    try {
      final configured = await _gateway.configure();
      if (!configured) {
        _emitReady(configured: false);
        return;
      }
      _gateway.addProStatusListener(_listener);
      _listenerAttached = true;
      _revenueCatPro = await _gateway.getIsPro();
      _emitReady(configured: true);
    } on Object catch (error) {
      emit(
        EntitlementState(
          isLoading: false,
          isPro: _debugOverride,
          isRevenueCatConfigured: false,
          isDebugOverride: _debugOverride,
          error: 'Could not load purchases: $error',
        ),
      );
    }
  }

  Future<void> refresh() async {
    if (!state.isRevenueCatConfigured) return;
    try {
      _revenueCatPro = await _gateway.getIsPro();
      _emitReady(configured: true);
    } on Object catch (error) {
      emit(
        EntitlementState(
          isLoading: false,
          isPro: _revenueCatPro || _debugOverride,
          isRevenueCatConfigured: true,
          isDebugOverride: _debugOverride,
          error: 'Could not refresh purchases: $error',
        ),
      );
    }
  }

  Future<void> setDebugPro({required bool value}) async {
    if (!kDebugMode) return;
    _debugOverride = value;
    await _prefs.setBool(_debugProKey, value);
    _emitReady(configured: state.isRevenueCatConfigured);
  }

  Future<void> toggleDebugPro() => setDebugPro(value: !_debugOverride);

  void _onProStatusChanged({required bool isPro}) {
    if (isClosed) return;
    _revenueCatPro = isPro;
    _emitReady(configured: true);
  }

  void _emitReady({required bool configured}) {
    emit(
      EntitlementState(
        isLoading: false,
        isPro: _revenueCatPro || _debugOverride,
        isRevenueCatConfigured: configured,
        isDebugOverride: _debugOverride,
      ),
    );
  }

  @override
  Future<void> close() async {
    if (_listenerAttached) {
      _gateway.removeProStatusListener(_listener);
    }
    return super.close();
  }
}
