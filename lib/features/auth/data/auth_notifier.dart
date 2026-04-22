import 'dart:async';

import 'package:fixly/features/auth/model/app_user.dart';
import 'package:fixly/features/auth/model/repository/firebase_repo.dart';
import 'package:fixly/features/auth/widget/user_role.dart';
import 'package:fixly/features/provider/firebase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends AsyncNotifier<AppUser?> {
  late final FirebaseRepo _firebaseRepo;
  @override
  FutureOr<AppUser?> build() {
    _firebaseRepo = ref.read(firebaseRepoProvider);
    return null;
  }

  Future<void> registerWithEmailPassword(
    String email,
    String password,
    String name,
    UserRole role,
  ) async {
    state = const AsyncValue.loading();
    try {
      final AppUser? user = await _firebaseRepo
          .registerWithEmailPassword(
            email,
            password,
            name,
            role,
          );
      state = AsyncValue.data(user);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> loginWithEmailPassword(
    String email,
    String password,
  ) async {
    state = const AsyncValue.loading();
    try {
      final AppUser? user = await _firebaseRepo
          .loginWithEmailPassword(email, password);
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> loginWithGoogle() async {
    state = const AsyncValue.loading();
    try {
      final AppUser? user = await _firebaseRepo
          .loginWithGoogle();
      state = AsyncValue.data(user);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    try {
      await _firebaseRepo.logout();
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> deleteAccount(String password) async {
    state = const AsyncValue.loading();
    try {
      await _firebaseRepo.deleteAccount(password: password);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    state = const AsyncValue.loading();

    try {
      await _firebaseRepo.sendPasswordResetEmail(email);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
