import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proteam_app/features/user/domain/entities/user_entity.dart';

// Data model for user entities
class UserModel extends UserEntity {
  const UserModel({required super.uid, required super.username, required super.email, super.pfpUrl});

  // Factory method to create user models from firestore document snapshots
  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final snap = snapshot.data() as Map<String, dynamic>;

    return UserModel(
      uid: snap['uid'],
      username: snap['username'],
      email: snap['email'],
      pfpUrl: snap['pfpUrl'],
    );
  }

  // Convert user models into firestore compatible maps
  Map<String, dynamic> toDocument() => {
        'uid': uid,
        'username': username,
        'email': email,
        'pfpUrl': pfpUrl,
      };
}
