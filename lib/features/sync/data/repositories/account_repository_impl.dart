import 'package:fpdart/fpdart.dart';
import 'package:momentum/core/error/failure.dart';
import 'package:momentum/features/sync/data/datasources/auth_remote_datasource.dart';
import 'package:momentum/features/sync/data/token_storage.dart';
import 'package:momentum/features/sync/domain/entities/token_pair.dart';
import 'package:momentum/features/sync/domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  AccountRepositoryImpl({
    required AuthRemoteDatasource remote,
    required TokenStorage storage,
  }) : _remote = remote,
       _storage = storage;

  final AuthRemoteDatasource _remote;
  final TokenStorage _storage;

  @override
  Future<Either<Failure, TokenPair>> signIn(
    String email,
    String password,
  ) async {
    try {
      final pair = await _remote.login(email, password);
      await _storage.saveTokens(pair, email: email);
      return Right(pair);
    } on Object catch (e) {
      return Left(NetworkFailure(message: _message(e)));
    }
  }

  @override
  Future<Either<Failure, TokenPair>> register(
    String email,
    String password,
  ) async {
    try {
      final pair = await _remote.register(email, password);
      await _storage.saveTokens(pair, email: email);
      return Right(pair);
    } on Object catch (e) {
      return Left(NetworkFailure(message: _message(e)));
    }
  }

  @override
  Future<void> signOut() => _storage.clear();

  @override
  Future<bool> get isSignedIn => _storage.hasTokens;

  @override
  Future<String?> get accountEmail => _storage.readEmail();

  static String _message(Object e) {
    if (e is Exception) return e.toString().replaceFirst('Exception: ', '');
    return e.toString();
  }
}
