import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fixly/features/auth/model/repository/firebase_repo.dart';
import 'package:fixly/features/auth/widget/read_write_to_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);

final firestoreProvider = Provider(
  (ref) => FirebaseFirestore.instance,
);

final readWriteProvider = Provider(
  (ref) =>
      ReadWriteToFirestore(ref.read(firestoreProvider)),
);

final firebaseRepoProvider = Provider(
  (ref) => FirebaseRepo(ref),
);
