import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixly/core/utils/auth_exception.dart';

class AppFirebaseException {
  static AuthException fromFirebaseAuth(
    FirebaseAuthException e,
  ) {
    switch (e.code) {
      case 'email-already-in-use':
        return const AuthException(
          code: 'email-in-use',
          message: 'Email already registered.',
        );

      case 'weak-password':
        return const AuthException(
          code: 'weak-password',
          message: 'Password is too weak.',
        );

      case 'invalid-email':
        return const AuthException(
          code: 'invalid-email',
          message: 'Invalid email address.',
        );

      case 'user-not-found':
        return const AuthException(
          code: 'user-not-found',
          message: 'No user found with this email.',
        );

      case 'wrong-password':
        return const AuthException(
          code: 'wrong-password',
          message: 'Incorrect password.',
        );

      case 'user-disabled':
        return const AuthException(
          code: 'user-disabled',
          message: 'This account has been disabled.',
        );

      case 'too-many-requests':
        return const AuthException(
          code: 'too-many-requests',
          message: 'Too many attempts. Try again later.',
        );

      case 'operation-not-allowed':
        return const AuthException(
          code: 'operation-not-allowed',
          message: 'This operation is not allowed.',
        );

      default:
        return AuthException(
          code: e.code,
          message: e.message ?? 'Authentication failed',
        );
    }
  }
}
