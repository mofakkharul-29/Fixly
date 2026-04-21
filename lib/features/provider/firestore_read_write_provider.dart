import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixly/core/utils/read_write_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreServiceProvider =
    Provider<ReadWriteFirestore>(
      (ref) =>
          ReadWriteFirestore(FirebaseFirestore.instance),
    );
