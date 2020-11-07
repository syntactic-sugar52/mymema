import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  String uid;
  String username;
  String email;
  String photoUrl;
  String displayName;
  String status;
  // String password;
  // bool isActive;
  // String groupId;
  // String messageId;
  Timestamp accountCreated;
  // String mobile;
  // String id;
  // String messages;
  Users(
      {this.uid,
      // this.id,
      // this.messageId,
      this.username,
      // this.messages,
      // this.groupId,
      this.email,
      this.photoUrl,
      this.displayName,
      this.accountCreated,
      // this.password,
      // this.isActive,
      // this.mobile,
      this.status});

  factory Users.fromDocument(DocumentSnapshot doc) {
    return Users(
      uid: doc["uid"],
      email: doc["email"],
      username: doc["username"],
      photoUrl: doc["photoUrl"],
      status: doc["status"],
      displayName: doc["displayName"],
      // mobile: doc["mobile"],
      // isActive: doc["isActive"],
      // password: doc["password"],
      // groupId: doc["groupId"],
      // messageId: doc["messageId"]
    );
  }
}
