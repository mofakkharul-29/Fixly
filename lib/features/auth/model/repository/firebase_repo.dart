import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixly/core/utils/app_firebase_exception.dart';
import 'package:fixly/features/auth/model/app_user.dart';
import 'package:fixly/features/auth/model/repository/auth_repo.dart';
import 'package:fixly/features/auth/widget/user_role.dart';
import 'package:fixly/features/provider/firebase_provider.dart';
import 'package:fixly/features/provider/firestore_read_write_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirebaseRepo implements AuthRepo {
  final Ref _ref;
  const FirebaseRepo(this._ref);

  @override
  Future<AppUser?> registerWithEmailPassword(
    String email,
    String password,
    String name,
    UserRole role,
  ) async {
    final FirebaseAuth auth = _ref.read(
      authInstanceProvider,
    );
    try {
      final UserCredential credential = await auth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          );
      final User? firebaseUser = credential.user;
      if (firebaseUser == null) return null;

      await credential.user!.updateDisplayName(name);

      final appUser = AppUser(
        uid: firebaseUser.uid,
        email: email,
        name: name,
        role: role,
        photoUrl: firebaseUser.photoURL,
        createdAt:
            firebaseUser.metadata.creationTime ??
            DateTime.now(),
      );
      await _ref
          .read(firestoreServiceProvider)
          .writeToFirestore(appUser);
      return appUser;
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseException.fromFirebaseAuth(e);
    }
  }

  @override
  Future<AppUser?> loginWithEmailPassword(
    String email,
    String password,
  ) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<AppUser?> loginWithGoogle() {
    // TODO: implement loginWithGoogle
    throw UnimplementedError();
  }

  @override
  Stream<AppUser?> currentUser() {
    final FirebaseAuth auth = _ref.read(
      authInstanceProvider,
    );
    return auth.authStateChanges().asyncExpand((
      firebaseUser,
    ) {
      if (firebaseUser == null) {
        return Stream.value(null);
      }

      return _ref
          .read(firestoreServiceProvider)
          .watchUserFromFirestore(firebaseUser.uid);
    });
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<String> sendPasswordResetEmail(String email) {
    // TODO: implement sendPasswordResetEmail
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAccount({String? password}) {
    // TODO: implement deleteAccount
    throw UnimplementedError();
  }
}
