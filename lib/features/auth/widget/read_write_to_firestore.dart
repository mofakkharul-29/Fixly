import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixly/features/auth/model/app_user.dart';

class ReadWriteToFirestore {
  final FirebaseFirestore _firestore;

  const ReadWriteToFirestore(this._firestore);

  Future<void> writeUserDataToFirestore(
    AppUser user,
  ) async {
    await _firestore
        .collection('users')
        .doc(user.uid)
        .collection('authData')
        .doc()
        .set({...user.toMap()}, SetOptions(merge: true));
  }
}
