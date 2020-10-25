// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:my_mema/components/rounded_button.dart';
// import 'package:my_mema/screens/create_Account.dart';
// import 'login.dart';
// import 'auth/register.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:my_mema/models/user.dart';
//
// final GoogleSignIn googleSignIn = GoogleSignIn();
// final usersRef = FirebaseFirestore.instance.collection('users');
// final DateTime timestamp = DateTime.now();
// Users currentUser;
//
// class WelcomeScreen extends StatefulWidget {
//   static const String id = 'welcome_screen';
//   @override
//   _WelcomeScreenState createState() => _WelcomeScreenState();
// }
//
// class _WelcomeScreenState extends State<WelcomeScreen>
//     with SingleTickerProviderStateMixin {
//   AnimationController controller;
//   Animation animation;
//   PageController _pageController;
//   bool isAuth = false;
//   int _page = 2;
//   // PageController pageController;
//   int pageIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     controller =
//         AnimationController(duration: Duration(seconds: 1), vsync: this);
//     animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
//         .animate(controller);
//     controller.forward();
//     controller.addListener(
//       () {
//         setState(() {});
//         // print(controller.value);
//       },
//     );
//     _pageController = PageController();
//     googleSignIn.onCurrentUserChanged.listen((account) {
//       handleSignIn(account);
//     }, onError: (err) {
//       print("Error signing in: $err");
//     });
//     googleSignIn.signInSilently(suppressErrors: false).then((account) {
//       handleSignIn(account);
//     }).catchError((err) {
//       print("Error signing in: $err");
//     });
//   }
//
//   handleSignIn(GoogleSignInAccount account) {
//     if (account != null) {
//       createUserInFirestore();
//       setState(() {
//         isAuth = true;
//       });
//     } else {
//       isAuth = false;
//     }
//   }
//
//   createUserInFirestore() async {
//     final GoogleSignInAccount user = googleSignIn.currentUser;
//     DocumentSnapshot doc = await usersRef.doc(user.id).get();
//     if (!doc.exists) {
//       final username = await Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => CreateAccount(),
//         ),
//       );
//       usersRef.doc(user.id).set({
//         "id": user.id,
//         "username": username,
//         "photoUrl": user.photoUrl,
//         "email": user.email,
//         "displayName": user.displayName,
//         "bio": "",
//         "timestamp": timestamp
//       });
//       doc = await usersRef.doc(user.id).get();
//     }
//     currentUser = Users.fromDocument(doc);
//     print(currentUser);
//     print(currentUser.username);
//   }
//
//   logout() {
//     googleSignIn.signOut();
//   }
//
//   login() {
//     googleSignIn.signIn();
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     controller.dispose(); //to stop the loop of the animation in memory;
//     super.dispose();
//   }
//
//   RoundedButton roundedButton = RoundedButton();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: animation.value,
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 24.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             Row(
//               children: <Widget>[
//                 Hero(
//                   tag: 'logo',
//                   child: Container(
//                     child: Image.asset('images/logo.png'),
//                     height: 60.0,
//                   ),
//                 ),
//                 TypewriterAnimatedTextKit(
//                   text: ['mema'],
//                   textStyle: TextStyle(
//                     fontSize: 45.0,
//                     fontWeight: FontWeight.w900,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 48.0,
//             ),
//             RoundedButton(
//               color: Colors.lightBlueAccent,
//               buttonTitle: 'Log in',
//               onPressed: () {
//                 Navigator.pushNamed(context, LoginScreen.id);
//               },
//             ),
//             RoundedButton(
//               color: Colors.blueAccent,
//               buttonTitle: 'Register',
//               onPressed: () {
//                 Navigator.pushNamed(context, RegistrationScreen.id);
//               },
//             ),
//             GestureDetector(
//               onTap: login,
//               child: Container(
//                 width: 50.0,
//                 height: 40.0,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage(
//                         'assets/google_signin_button.png',
//                       ),
//                       fit: BoxFit.cover),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
