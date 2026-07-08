import 'package:fpdart/fpdart.dart';
import 'package:momentum/core/error/failure.dart';
import 'package:momentum/features/sync/domain/entities/token_pair.dart';

abstract interface class AccountRepository {
  Future<Either<Failure, TokenPair>> signIn(String email, String password);
  Future<Either<Failure, TokenPair>> register(String email, String password);
  Future<void> signOut();
  Future<bool> get isSignedIn;
  Future<String?> get accountEmail;
}
