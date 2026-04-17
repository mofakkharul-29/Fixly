import 'dart:async';

import 'package:fixly/core/utils/auth_exception.dart';
import 'package:fixly/features/auth/model/app_user.dart';
import 'package:fixly/features/auth/model/repository/firebase_repo.dart';
import 'package:fixly/features/auth/widget/user_role.dart';
import 'package:fixly/features/provider/firebase_all_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends AsyncNotifier<AppUser?> {
  late final FirebaseRepo _authRepo;

  @override
  Future<AppUser?> build() async {
    _authRepo = ref.read(firebaseRepoProvider);
    final AppUser? user = await _authRepo.currentUser();

    return user;
  }

  void reset() {
    state = const AsyncValue.data(null);
  }

  Future<void> registerWithEmailPassword(
    String email,
    String password,
    String name,
    UserRole role,
  ) async {
    state = const AsyncValue.loading();
    try {
      final AppUser? appUser = await _authRepo
          .registerWithEmailPassword(
            email,
            password,
            name,
            role,
          );

      state = AsyncValue.data(appUser);
    } on AuthException catch (e, st) {
      state = AsyncValue.error(e, st);
      debugPrint('error from auth notifier: ${e.message}');
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> loginWithEmailPassword(
    String email,
    String password,
  ) async {
    state = const AsyncValue.loading();

    try {
      final AppUser? user = await _authRepo
          .loginWithEmailPassword(email, password);
      state = AsyncValue.data(user);
    } on AuthException catch (e, st) {
      state = AsyncValue.error(e, st);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
