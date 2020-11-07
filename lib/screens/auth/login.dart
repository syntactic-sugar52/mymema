// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:my_mema/screens/auth/signup_form.dart';
// import 'package:my_mema/screens/home.dart';
// import 'package:my_mema/screens/root/root.dart';
// import 'package:provider/provider.dart';
// import '../../states/current_user.dart';
// import 'login_container.dart';
// import 'signup.dart';
//

//
// class LoginScreen extends StatefulWidget {
//   static const String id = 'login_screen';
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//
//   final _auth = FirebaseAuth.instance;
//   String email;
//   String password;
//   bool showSpinner = false;
//   bool isAuth = false;
//   final GoogleSignIn googleSignIn = GoogleSignIn();
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
//     //   handleSignIn(account);
//     //   googleSignIn.signInSilently(suppressErrors: false).then((account) {
//     //     handleSignIn(account);
//     //   }).catchError((err) {
//     //     print(err);
//     //   });
//     // });
//   }
//
//   // handleSignIn(GoogleSignInAccount account) {
//   //   if (account != null) {
//   //     print(account);
//   //     setState(() {
//   //       isAuth = true;
//   //     });
//   //   } else {
//   //     setState(() {
//   //       isAuth = false;
//   //     });
//   //   }
//   // }
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     // TODO: implement dispose
//     super.dispose();
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Material(
//
//     );
//   }
// }
