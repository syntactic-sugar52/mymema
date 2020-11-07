// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:my_mema/models/cards.dart';
// import 'package:my_mema/models/messages.dart';
// import 'package:my_mema/models/teams.dart';
// import 'package:my_mema/models/user.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:my_mema/screens/auth/signup.dart';
//
// final usersRef = FirebaseFirestore.instance.collection('users');
// final GoogleSignIn googleSignIn = GoogleSignIn();
//
// class Database {
//   final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
//
//   Future<String> createUser(Users users) async {
//     String retVal = "error";
//
//     try {
//       await _firebaseFirestore.collection("users").doc(users.uid).set({
//         "displayName": users.displayName,
//         "email": users.email,
//         'accountCreated': Timestamp.now(),
//         "userName": users.userName,
//         "status": "",
//         "groupId": users.groupId,
//         // "messageId": users.messageId,
//         // "uid": users.uid
//       });
//       retVal = "success";
//     } catch (e) {
//       print(e);
//     }
//     return retVal;
//   }
//
//   Future<Users> getUserInfo(String uid) async {
//     Users retVal = Users();
//     try {
//       DocumentSnapshot _docSnapshot =
//           await _firebaseFirestore.collection("users").doc(uid).get();
//       retVal.uid = uid;
//       retVal.displayName = _docSnapshot.data()["displayName"];
//       retVal.email = _docSnapshot.data()["email"];
//       retVal.accountCreated = _docSnapshot.data()["accountCreated"];
//       retVal.userName = _docSnapshot.data()["userName"];
//       retVal.status = _docSnapshot.data()["status"];
//       retVal.groupId = _docSnapshot.data()["groupId"];
//       // retVal.messageId = _docSnapshot.data()["messageId"];
//     } catch (e) {
//       print(e);
//     }
//     return retVal;
//   }
// }
