import 'package:fixly/features/auth/model/app_user.dart';
import 'package:fixly/features/provider/firebase_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authStateProvider = StreamProvider<AppUser?>((ref) {
  return ref.read(firebaseRepoProvider).currentUser();
});
