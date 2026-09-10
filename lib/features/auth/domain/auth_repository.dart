import 'package:fish_check/features/auth/domain/user.dart';

abstract interface class AuthRepository {
  Future<User> signIn(String email, String password);
  Future<void> signOut();
}
