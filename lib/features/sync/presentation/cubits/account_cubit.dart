import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:momentum/features/sync/domain/repositories/account_repository.dart';

sealed class AccountState {
  const AccountState();
}

class AccountInitial extends AccountState {
  const AccountInitial();
}

class AccountSignedOut extends AccountState {
  const AccountSignedOut();
}

class AccountSignedIn extends AccountState {
  const AccountSignedIn({required this.email});
  final String email;
}

class AccountSigningIn extends AccountState {
  const AccountSigningIn();
}

class AccountError extends AccountState {
  const AccountError({required this.message});
  final String message;
}

class AccountCubit extends Cubit<AccountState> {
  AccountCubit(this._repo) : super(const AccountInitial());

  final AccountRepository _repo;

  Future<void> initialize() async {
    final signedIn = await _repo.isSignedIn;
    if (signedIn) {
      final email = await _repo.accountEmail;
      emit(AccountSignedIn(email: email ?? ''));
    } else {
      emit(const AccountSignedOut());
    }
  }

  Future<bool> signIn(String email, String password) async {
    emit(const AccountSigningIn());
    final result = await _repo.signIn(email, password);
    return result.fold(
      (failure) {
        emit(AccountError(message: failure.message));
        return false;
      },
      (_) {
        emit(AccountSignedIn(email: email));
        return true;
      },
    );
  }

  Future<bool> register(String email, String password) async {
    emit(const AccountSigningIn());
    final result = await _repo.register(email, password);
    return result.fold(
      (failure) {
        emit(AccountError(message: failure.message));
        return false;
      },
      (_) {
        emit(AccountSignedIn(email: email));
        return true;
      },
    );
  }

  Future<void> signOut() async {
    await _repo.signOut();
    emit(const AccountSignedOut());
  }
}
