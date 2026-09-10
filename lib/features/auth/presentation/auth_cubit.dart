import 'package:bloc/bloc.dart';
import 'package:fish_check/features/auth/data/in_memory_auth_repository.dart';
import 'package:fish_check/features/auth/domain/user.dart';

sealed class AuthState {
  const AuthState();
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}

class Authenticating extends AuthState {
  const Authenticating();
}

class Authenticated extends AuthState {
  const Authenticated(this.user);
  final User user;
}

class AuthFailure extends AuthState {
  const AuthFailure(this.message);
  final String message;
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repository) : super(const Unauthenticated());

  final InMemoryAuthRepository _repository;

  Future<void> signIn(String email, String password) async {
    emit(const Authenticating());
    try {
      emit(Authenticated(await _repository.signIn(email, password)));
    } on AuthException catch (error) {
      emit(AuthFailure(error.message));
    }
  }

  Future<void> signOut() async {
    await _repository.signOut();
    emit(const Unauthenticated());
  }
}
