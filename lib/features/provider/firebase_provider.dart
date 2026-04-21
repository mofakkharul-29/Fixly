import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixly/features/auth/model/repository/firebase_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authInstanceProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);

final firebaseRepoProvider = Provider<FirebaseRepo>(
  (ref) => FirebaseRepo(ref),
);
