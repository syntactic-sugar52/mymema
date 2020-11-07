// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:my_mema/models/user.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:my_mema/services/database.dart';
//
// final GoogleSignIn googleSignIn = GoogleSignIn();
//
// class CurrentUser extends ChangeNotifier {
//   Users _currentUser = Users();
//
//   Users get getCurrentUser => _currentUser;
//
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   Future<String> onStartUp() async {
//     String retVal = "error";
//     try {
//       User _firebaseUser = await _auth.currentUser;
//       _currentUser = await Database().getUserInfo(_firebaseUser.uid);
//       if (_currentUser != null) {
//         retVal = "success";
//       }
//     } catch (e) {
//       print(e);
//     }
//     return retVal;
//   }
//
//   Future<String> signOut() async {
//     String retVal = "error";
//     try {
//       await _auth.signOut();
//       _currentUser = Users();
//       retVal = "success";
//     } catch (e) {
//       print(e);
//     }
//     return retVal;
//   }
//
//   Future<String> signUpUser(String email, String password, String displayName,
//       String userName) async {
//     String retVal = "error";
//     Users _user = Users();
//     try {
//       UserCredential _authResult = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//       _user.uid = _authResult.user.uid;
//       _user.email = _authResult.user.email;
//       _user.displayName = displayName;
//       _user.userName = userName;
//       // _user.groupId = _authResult.user
//       String _returnString = await Database().createUser(_user);
//       if (_returnString == "success") {
//         retVal = "success";
//       }
//     } on PlatformException catch (e) {
//       retVal = e.message;
//     } catch (e) {
//       print(e);
//     }
//     return retVal;
//   }
//
//   Future<String> loginUserWithEmail(String email, String password) async {
//     String retVal = "error";
//
//     try {
//       UserCredential _authResult = await _auth.signInWithEmailAndPassword(
//           email: email, password: password);
//       _currentUser = await Database().getUserInfo(_authResult.user.uid);
//       if (_currentUser != null) {
//         retVal = "success";
//       }
//     } catch (e) {
//       retVal = e.message;
//     }
//     return retVal;
//   }
//
//   // Future<String> loginUserWithGoogle() async {
//   //   String retVal = "error";
//   //   GoogleSignIn _googleSignIn = GoogleSignIn(
//   //     scopes: [
//   //       'email',
//   //       'https://www.googleapis.com/auth/contacts.readonly',
//   //     ],
//   //   );
//   //   Users _users = Users();
//   //   try {
//   //     GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
//   //     GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
//   //     final AuthCredential credential = GoogleAuthProvider.credential(
//   //         idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);
//   //     UserCredential _authResult = await _auth.signInWithCredential(credential);
//   //     if (_authResult.additionalUserInfo.isNewUser) {
//   //       _users.uid = _authResult.user.uid;
//   //       _users.email = _authResult.user.email;
//   //       _users.displayName = _authResult.user.displayName;
//   //       Database().createUser(_users);
//   //     }
//   //     _currentUser = await Database().getUserInfo(_authResult.user.uid);
//   //
//   //     if (_currentUser != null) {
//   //       retVal = "success";
//   //     }
//   //   } on PlatformException catch (e) {
//   //     retVal = e.message;
//   //   } catch (e) {
//   //     retVal = e.message;
//   //   }
//   //   return retVal;
//   // }
//
//   // loginUserWithGoogle() async {
//   //   final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
//   //   final GoogleSignInAuthentication googleSignInAuthentication =
//   //       await googleSignInAccount.authentication;
//   //   final AuthCredential credential = GoogleAuthProvider.getCredential(
//   //     accessToken: googleSignInAuthentication.accessToken,
//   //     idToken: googleSignInAuthentication.idToken,
//   //   );
//   //
//   //   final UserCredential authResult = await _auth.signInWithCredential(credential);
//   //   final User user = authResult.user;
//   //
//   // }
//   loginUserWithGoogle() async {
//     await googleSignIn.signIn();
//   }
// }
