import 'package:fish_check/features/auth/domain/auth_repository.dart';
import 'package:fish_check/features/auth/domain/user.dart';

class InMemoryAuthRepository implements AuthRepository {
  static const _demoUser = User(name: 'Alex Fisher', email: 'angler@fishcheck.app');

  @override
  Future<User> signIn(String email, String password) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    if (email.trim().toLowerCase() != _demoUser.email || password != 'fish123') {
      throw const AuthException('Invalid email or password.');
    }
    return _demoUser;
  }

  @override
  Future<void> signOut() async {}
}

class AuthException implements Exception {
  const AuthException(this.message);
  final String message;
}
