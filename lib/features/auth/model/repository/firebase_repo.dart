import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixly/core/utils/app_firebase_exception.dart';
import 'package:fixly/features/auth/model/app_user.dart';
import 'package:fixly/features/auth/model/repository/auth_repo.dart';
import 'package:fixly/features/auth/widget/read_write_to_firestore.dart';
import 'package:fixly/features/auth/widget/user_role.dart';
import 'package:fixly/features/provider/firebase_all_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseRepo implements AuthRepo {
  final Ref ref;
  final GoogleSignIn _googleSignIn;

  FirebaseRepo(this.ref) : _googleSignIn = GoogleSignIn();

  FirebaseAuth get _auth => ref.read(firebaseAuthProvider);
  ReadWriteToFirestore get _activity =>
      ref.read(readWriteProvider);

  @override
  Future<AppUser?> registerWithEmailPassword(
    String email,
    String password,
    String name,
    UserRole role,
  ) async {
    try {
      debugPrint('firebase register started ===');

      final UserCredential credential = await _auth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

      final User? firebaseUser = credential.user;
      if (firebaseUser == null) return null;

      await credential.user!.updateDisplayName(name);

      final AppUser appUser = AppUser(
        uid: firebaseUser.uid,
        email: email,
        role: role,
        name: name,
        photoUrl: firebaseUser.photoURL,
        createdAt:
            firebaseUser.metadata.creationTime ??
            DateTime.now(),
      );

      await _activity.writeUserDataToFirestore(appUser);

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
      final UserCredential credential = await _auth
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          );

      final User? firebaseUser = credential.user;
      if (firebaseUser == null) return null;

      final AppUser? appUser = await _activity
          .getUserFromFirestore(firebaseUser.uid);

      return appUser;
    } on FirebaseAuthException catch (e) {
      throw AppFirebaseException.fromFirebaseAuth(e);
    }
  }

  @override
  Future<AppUser?> loginWithGoogle() {
    throw UnimplementedError();
  }

  @override
  Future<AppUser?> currentUser() async {
    final User? user = _auth.currentUser;
    if (user == null) return null;

    final AppUser? appUser = await _activity
        .getUserFromFirestore(user.uid);

    return appUser;
  }

  @override
  Future<void> logout() {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAccount({String? password}) {
    throw UnimplementedError();
  }

  @override
  Future<String> sendPasswordResetEmail(String email) {
    throw UnimplementedError();
  }
}
