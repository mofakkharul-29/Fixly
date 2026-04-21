import 'package:fixly/features/auth/model/app_user.dart';

abstract class AuthRepo {
  Future<AppUser?> registerWithEmailPassword(
    String email,
    String password,
    String name,
  );

  Future<AppUser?> loginWithEmailPassword(
    String email,
    String password,
  );

  Future<AppUser?> loginWithGoogle();

  Future<void> logout();

  Future<AppUser?> curentUser();

  Future<String> sendPasswordResetEmail(String email);

  Future<void> deleteAccount({String? password});
}
