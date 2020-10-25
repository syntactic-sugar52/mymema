import 'package:flutter/material.dart';
import 'package:my_mema/screens/auth/login_container.dart';
import 'package:my_mema/screens/main_screen.dart';
import 'package:my_mema/screens/splash/splash.dart';
import 'package:my_mema/util/const.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_mema/screens/home.dart';
import 'package:my_mema/components/rounded_button.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  bool showSpinner = false;

  void inputData() {
    final User user = _auth.currentUser;
    final uid = user.uid;
    // here you write the codes to input the data into firestore
  }

  @override
  Widget build(BuildContext context) {
    //   return Scaffold(
    //     backgroundColor: Colors.white,
    //     body: ModalProgressHUD(
    //       inAsyncCall: showSpinner,
    //       child: Padding(
    //         padding: EdgeInsets.symmetric(horizontal: 24.0),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           crossAxisAlignment: CrossAxisAlignment.stretch,
    //           children: <Widget>[
    //             Flexible(
    //               child: Hero(
    //                 tag: 'logo',
    //                 child: Container(
    //                   height: 200.0,
    //                   child: Splash(),
    //                 ),
    //               ),
    //             ),
    //             SizedBox(
    //               height: 48.0,
    //             ),
    //             TextField(
    //               keyboardType: TextInputType.emailAddress,
    //               textAlign: TextAlign.center,
    //               onChanged: (value) {
    //                 //Do something with the user input.
    //                 email = value;
    //               },
    //               decoration:
    //                   kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
    //             ),
    //             SizedBox(
    //               height: 8.0,
    //             ),
    //             TextField(
    //                 obscureText: true,
    //                 textAlign: TextAlign.center,
    //                 onChanged: (value) {
    //                   //Do something with the user input.
    //                   password = value;
    //                 },
    //                 decoration: kTextFieldDecoration.copyWith(
    //                     hintText: 'Enter your password')),
    //             SizedBox(
    //               height: 24.0,
    //             ),
    //             RoundedButton(
    //               color: Colors.black,
    //               buttonTitle: 'login',
    //               onPressed: () async {
    //                 setState(() {
    //                   showSpinner = true;
    //                 });
    //                 try {
    //                   final oldUser = await _auth.signInWithEmailAndPassword(
    //                       email: email, password: password);
    //                   if (oldUser != null) {
    //                     // Navigator.pushNamed(context, MainScreen.id);
    //                     Navigator.push(
    //                         context,
    //                         MaterialPageRoute(
    //                             builder: (context) => MainScreen()));
    //                   }
    //                   setState(() {
    //                     showSpinner = false;
    //                   });
    //                 } catch (e) {
    //                   print(e);
    //                   // if (e.code == 'user-not-found') {
    //                   //   print('No user found for that email.');
    //                   // } else if (e.code == 'wrong-password') {
    //                   //   print('Wrong password provided for that user.');
    //                   // }
    //                 }
    //               },
    //             ),
    //           ],
    //         ),
    //       ),
    //     ),
    //   );
    // }
    return LoginContainer(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
            child: Text(
              "Log In",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.alternate_email), hintText: "Email"),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_outline), hintText: "Password"),
          ),
          SizedBox(height: 20.0),
          RaisedButton(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
            ),
          )
        ],
      ),
    );
  }
}
