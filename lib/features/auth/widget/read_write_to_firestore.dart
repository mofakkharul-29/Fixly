import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixly/features/auth/model/app_user.dart';
import 'package:flutter/material.dart';

class ReadWriteToFirestore {
  final FirebaseFirestore _firestore;

  const ReadWriteToFirestore(this._firestore);

  Future<void> writeUserDataToFirestore(
    AppUser user,
  ) async {
    try {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .set(user.toMap(), SetOptions(merge: true));
    } catch (e, st) {
      debugPrint('Firestore error: $e');
      debugPrint('$st');
    }
  }

  Future<AppUser?> getUserFromFirestore(String uid) async {
    final snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .get();

    if (!snapshot.exists || snapshot.data() == null) {
      return null;
    }

    return AppUser.fromMap(
      snapshot.data() as Map<String, dynamic>,
    );
  }
}
