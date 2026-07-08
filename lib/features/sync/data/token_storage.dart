import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:momentum/features/sync/domain/entities/token_pair.dart';

class TokenStorage {
  const TokenStorage(this._store);

  static const _access = 'sync_access_token';
  static const _refresh = 'sync_refresh_token';
  static const _email = 'sync_account_email';

  final FlutterSecureStorage _store;

  Future<String?> readAccessToken() => _store.read(key: _access);
  Future<String?> readRefreshToken() => _store.read(key: _refresh);
  Future<String?> readEmail() => _store.read(key: _email);

  Future<void> saveTokens(TokenPair pair, {String? email}) async {
    await _store.write(key: _access, value: pair.accessToken);
    await _store.write(key: _refresh, value: pair.refreshToken);
    if (email != null) await _store.write(key: _email, value: email);
  }

  Future<void> clear() async {
    await _store.delete(key: _access);
    await _store.delete(key: _refresh);
    await _store.delete(key: _email);
  }

  Future<bool> get hasTokens async {
    final t = await _store.read(key: _refresh);
    return t != null && t.isNotEmpty;
  }
}
