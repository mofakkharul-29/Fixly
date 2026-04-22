import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixly/core/utils/app_firebase_exception.dart';
import 'package:fixly/core/utils/auth_exception.dart';
import 'package:fixly/core/utils/read_write_firestore.dart';
import 'package:fixly/features/auth/model/app_user.dart';
import 'package:fixly/features/auth/model/repository/auth_repo.dart';
import 'package:fixly/features/auth/widget/user_role.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseRepo implements AuthRepo {
  final FirebaseAuth auth;
  final GoogleSignIn google;
  final ReadWriteFirestore firestore;

  const FirebaseRepo({
    required this.auth,
    required this.google,
    required this.firestore,
  });

  @override
  Future<AppUser?> registerWithEmailPassword(
    String email,
    String password,
    String name,
    UserRole role,
  ) async {
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
      await firestore.writeToFirestore(appUser);
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

      final appUser = await firestore
          .watchUserFromFirestore(firebaseUser.uid)
          .first;
      return appUser;
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseException.fromFirebaseAuth(e);
    }
  }

  @override
  Future<AppUser?> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await google.signIn();

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

      final existingUser = await firestore
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
      await firestore.writeToFirestore(appUser);
      return appUser;
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseException.fromFirebaseAuth(e);
    }
  }

  @override
  Stream<AppUser?> currentUser() {
    return auth.authStateChanges().asyncExpand((
      firebaseUser,
    ) {
      if (firebaseUser == null) {
        return Stream.value(null);
      }

      return firestore.watchUserFromFirestore(
        firebaseUser.uid,
      );
    });
  }

  @override
  Future<void> logout() async {
    try {
      await Future.wait([google.signOut(), auth.signOut()]);
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseException.fromFirebaseAuth(e);
    }
  }

  @override
  Future<String> sendPasswordResetEmail(
    String email,
  ) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return 'Password reset email sent! check your inbox';
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseException.fromFirebaseAuth(e);
    }
  }

  @override
  Future<void> deleteAccount({String? password}) async {
    final user = auth.currentUser;
    if (user == null) return;

    try {
      final providerId = user.providerData.first.providerId;
      if (providerId == 'password') {
        if (password == null) { 
          throw Exception(
            'Password required for re-authentication',
          );
        }
        final credential = EmailAuthProvider.credential(
          email: user.email!,
          password: password,
        );
        await user.reauthenticateWithCredential(credential);
      } else if (providerId == 'google.com') {
        final googleUser = await google.signIn();
        if (googleUser == null) {
          throw Exception('Google sign-in cancelled');
        }
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
        await user.reauthenticateWithCredential(credential);
      }
      await firestore.deleteUser(user.uid);
      await user.delete();
      await google.signOut();
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseException.fromFirebaseAuth(e);
    }
  }
}
