import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String uid;
  final String id;
  final String username;
  final String email;
  final String photoUrl;
  final String displayName;
  final String status;
  final String password;
  final bool isActive;
  final String groupId;
  Timestamp accountCreated;
  final String mobile;

  Users(
      {this.id,
      this.uid,
      this.groupId,
      this.username,
      this.email,
      this.photoUrl,
      this.displayName,
      this.accountCreated,
      this.password,
      this.isActive,
      this.mobile,
      this.status});

  factory Users.fromDocument(DocumentSnapshot doc) {
    return Users(
      id: doc["id"],
      email: doc["email"],
      username: doc["username"],
      photoUrl: doc["photoUrl"],
      status: doc["status"],
      displayName: doc["displayName"],
      mobile: doc["mobile"],
      isActive: doc["isActive"],
      password: doc["password"],
    );
  }
}
