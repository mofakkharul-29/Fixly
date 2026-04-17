import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixly/features/auth/model/app_user.dart';

class ReadWriteToFirestore {
  final FirebaseFirestore _firestore;

  const ReadWriteToFirestore(this._firestore);

  DocumentReference _userDoc(String id) => _firestore
      .collection('users')
      .doc(id)
      .collection('authData')
      .doc('profile');

  Future<void> writeUserDataToFirestore(
    AppUser user,
  ) async {
    await _userDoc(
      user.uid,
    ).set({...user.toMap()}, SetOptions(merge: true));
  }

  Future<AppUser?> getUserFromFirestore(String uid) async {
    final snapshot = await _userDoc(uid).get();

    if (!snapshot.exists || snapshot.data() == null) {
      return null;
    }

    return AppUser.fromMap(
      snapshot.data() as Map<String, dynamic>,
    );
  }
}
