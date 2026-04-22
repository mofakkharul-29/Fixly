import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixly/features/auth/model/repository/firebase_repo.dart';
import 'package:fixly/features/provider/firestore_read_write_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';

final authInstanceProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);

final firebaseRepoProvider = Provider<FirebaseRepo>(
  (ref) => FirebaseRepo(
    auth: ref.read(authInstanceProvider),
    firestore: ref.read(firestoreServiceProvider),
    google: ref.read(googleServiceProvider),
  ),
);

final googleServiceProvider = Provider<GoogleSignIn>(
  (ref) => GoogleSignIn(),
);
