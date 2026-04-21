import 'package:fixly/features/auth/model/app_user.dart';
import 'package:fixly/features/auth/widget/user_role.dart';

abstract class AuthRepo {
  Future<AppUser?> registerWithEmailPassword(
    String email,
    String password,
    String name,
    UserRole role,
  );

  Future<AppUser?> loginWithEmailPassword(
    String email,
    String password,
  );

  Future<AppUser?> loginWithGoogle();

  Future<void> logout();

  Stream<AppUser?> currentUser();

  Future<String> sendPasswordResetEmail(String email);

  Future<void> deleteAccount({String? password});
}
