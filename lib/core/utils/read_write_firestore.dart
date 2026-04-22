import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixly/features/auth/model/app_user.dart';

class ReadWriteFirestore {
  final FirebaseFirestore _firestore;

  const ReadWriteFirestore(this._firestore);

  Future<void> writeToFirestore(AppUser user) async {
    try {
      await _firestore
          .collection('users')
          .doc(user.uid)
          .set(user.toMap(), SetOptions(merge: true));
    } catch (e) {
      throw Exception('Firestore write failed: $e');
    }
  }

  Stream<AppUser?> watchUserFromFirestore(String uid) {
    return _firestore
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((snapshot) {
          if (!snapshot.exists || snapshot.data() == null) {
            return null;
          }
          return AppUser.fromMap(snapshot.data()!);
        });
  }

  Future<void> deleteUser(String uid) async {
    await _firestore.collection('users').doc(uid).delete();
  }
}
