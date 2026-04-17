import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fixly/features/auth/widget/user_role.dart';

class AppUser {
  final String uid;
  final String email;
  final UserRole role;
  final String? name;
  final String? photoUrl;
  final DateTime createdAt;

  const AppUser({
    required this.uid,
    required this.email,
    this.role = UserRole.consumer,
    this.name,
    this.photoUrl,
    required this.createdAt,
  });

  AppUser copyWith({
    String? uid,
    String? email,
    UserRole? role,
    String? name,
    String? photoUrl,
    DateTime? createdAt,
  }) {
    return AppUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      role: role ?? this.role,
      name: name ?? this.name,
      photoUrl: photoUrl ?? this.photoUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory AppUser.fromMap(Map<String, dynamic> user) {
    return AppUser(
      uid: user['uid'] as String,
      email: user['email'] as String,
      role: UserRole.values.firstWhere(
        (e) => e.name == user['role'],
      ),
      name: user['name'] as String,
      photoUrl: user['photoUrl'] as String?,
      createdAt: user['createdAt'] is Timestamp
          ? (user['createdAt'] as Timestamp).toDate()
          : DateTime.parse(user['createdAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'role': role,
      'name': name,
      'photoUrl': photoUrl,
      'createdAt': createdAt,
    };
  }
}
