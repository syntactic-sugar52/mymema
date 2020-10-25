import 'package:flutter/cupertino.dart';
import 'package:my_mema/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class CurrentUser extends ChangeNotifier {
  Users _currentUser;
  String _uid;
  String _email;

  String get getUid => _uid;
  String get getEmail => _email;
  FirebaseAuth _auth = FirebaseAuth.instance;

  // Future<String> onStartUpAsync() {
  //   String retval = "error";
  //   try{
  //     FirebaseUser _firebaseUser =
  //   }
  // }
}
