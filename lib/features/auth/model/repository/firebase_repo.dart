import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixly/core/utils/app_firebase_exception.dart';
import 'package:fixly/core/utils/auth_exception.dart';
import 'package:fixly/features/auth/model/app_user.dart';
import 'package:fixly/features/auth/model/repository/auth_repo.dart';
import 'package:fixly/features/auth/widget/user_role.dart';
import 'package:fixly/features/provider/firebase_provider.dart';
import 'package:fixly/features/provider/firestore_read_write_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
  ) async {
    try {
      final FirebaseAuth auth = _ref.read(
        authInstanceProvider,
      );
      final UserCredential credential = await auth
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          );
      final User? firebaseUser = credential.user;
      if (firebaseUser == null) {
        throw const AuthException(
          code: 'null-user',
          message: 'Login failed. Please try again',
        );
      }

      final appUser = await _ref
          .read(firestoreServiceProvider)
          .watchUserFromFirestore(firebaseUser.uid)
          .first;
      return appUser;
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseException.fromFirebaseAuth(e);
    }
  }

  @override
  Future<AppUser?> loginWithGoogle() async {
    final GoogleSignIn googleService = _ref.read(
      googleServiceProvider,
    );
    final FirebaseAuth auth = _ref.read(
      authInstanceProvider,
    );

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleService.signIn();

      if (googleSignInAccount == null) {
        throw AuthException(
          code: 'not-selected',
          message: 'No account selected',
        );
      }
      final GoogleSignInAuthentication authentication =
          await googleSignInAccount.authentication;

      final OAuthCredential oAuthCredential =
          GoogleAuthProvider.credential(
            accessToken: authentication.accessToken,
            idToken: authentication.idToken,
          );
      final UserCredential credential = await auth
          .signInWithCredential(oAuthCredential);
      final User? firebaseUser = credential.user;
      if (firebaseUser == null) return null;

      final existingUser = await _ref
          .read(firestoreServiceProvider)
          .watchUserFromFirestore(firebaseUser.uid)
          .first;

      if (existingUser != null) {
        return existingUser;
      }

      final AppUser appUser = AppUser(
        uid: firebaseUser.uid,
        email: firebaseUser.email ?? '',
        name: firebaseUser.displayName ?? 'unknown',
        role: UserRole
            .consumer, // later this will be set as dynamic not hardcoded
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
