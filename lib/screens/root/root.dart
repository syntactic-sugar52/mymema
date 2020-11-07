import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_mema/models/user.dart';
import 'package:my_mema/screens/auth/login_container.dart';
import 'package:my_mema/screens/create_Account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../home.dart';

Users currentUser;
final StorageReference storageRef = FirebaseStorage.instance.ref();
final usersRef = FirebaseFirestore.instance.collection('users');
final postsRef = FirebaseFirestore.instance.collection("posts");
final DateTime timestamp = DateTime.now();
final GoogleSignIn googleSignIn = GoogleSignIn();
enum LoginType { email, google }

class MyRoot extends StatefulWidget {
  static const String id = "myRootId";
  @override
  _MyRootState createState() => _MyRootState();
}

class _MyRootState extends State<MyRoot> {
  TextEditingController _emailController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();
  bool showSpinner = false;
  bool isAuth = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    googleSignIn.onCurrentUserChanged.listen((account) {
      handleSignIn(account);
    }, onError: (err) {
      print('Error signing in: $err');
    });
    googleSignIn.signInSilently(suppressErrors: false).then((account) {
      handleSignIn(account);
    }).catchError((err) {
      print('$err');
    });
  }

  handleSignIn(GoogleSignInAccount account) {
    if (account != null) {
      createUserInFirestore();
      setState(() {
        isAuth = true;
      });
    } else {
      setState(() {
        isAuth = false;
      });
    }
  }

  createUserInFirestore() async {
    final GoogleSignInAccount user = googleSignIn.currentUser;
    DocumentSnapshot doc = await usersRef.doc(user.id).get();
    if (!doc.exists) {
      final username = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CreateAccount()),
      );
      usersRef.doc(user.id).set({
        "uid": user.id,
        "username": username,
        "photoUrl": user.photoUrl,
        "email": user.email,
        "displayName": user.displayName,
        "status": "",
        "timestamp": timestamp,
      });
      doc = await usersRef.doc(user.id).get();
    }
    currentUser = Users.fromDocument(doc);
    print(currentUser);
    print(currentUser.username);
  }

  logIn() {
    googleSignIn.signIn();
  }

  logOut() {
    googleSignIn.signOut();
  }

//controller prop for TextField. to use it to clear the textfield after pressing send.
  Home buildAuthScreen() {
    return Home();
    // return Scaffold(
    //   appBar: AppBar(),
    //   body: Center(
    //     child: Text("hello"),
    //   ),
    // );
    // return RaisedButton(
    //   child: Text(
    //     "logout",
    //     style: TextStyle(color: Colors.white),
    //   ),
    //   onPressed: logOut,
    // );
  }

  // void _loginUser(
  //     {@required LoginType type,
  //     String email,
  //     String password,
  //     BuildContext context}) async {
  //   CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
  //   try {
  //     String _returnString;
  //     switch (type) {
  //       case LoginType.email:
  //         _returnString =
  //             await _currentUser.loginUserWithEmail(email, password);
  //
  //         break;
  //       case LoginType.google:
  //         await _currentUser.loginUserWithGoogle();
  //         break;
  //       default:
  //     }
  //     if (_returnString == "success") {
  //       Navigator.pushAndRemoveUntil(context,
  //           MaterialPageRoute(builder: (context) => Home()), (route) => false);
  //     } else {
  //       Scaffold.of(context).showSnackBar(SnackBar(
  //         content: Text(_returnString),
  //         duration: Duration(seconds: 2),
  //       ));
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  Widget _googleButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        logIn();
      }
      // _loginUser(type: LoginType.google, context: context);
      ,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
              image: AssetImage("assets/icons8-google-48.png"),
              height: 25.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(fontSize: 20.0, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Scaffold buildUnAuthScreen() {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.0),
              children: [
                Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Image.asset(
                    "assets/Mema.png",
                    height: 300.0,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                LoginContainer(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 8.0),
                        child: Text(
                          "Log In",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.alternate_email),
                            hintText: "Email"),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline),
                            hintText: "Password"),
                      ),
                      SizedBox(height: 20.0),
                      RaisedButton(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 100),
                          child: Text(
                            "Log In",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                        ),
                        onPressed: () {
                          // _loginUser(
                          //     type: LoginType.email,
                          //     email: _emailController.text,
                          //     password: _passwordController.text,
                          //     context: context);
                          // _emailController.addListener(emailListen);
                          // _passwordController.addListener(passwordListen);
                        },
                      ),
                      FlatButton(
                        child: Text("Don't have an account? Sign up here"),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: () {
                          //   Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //           builder: (context) => SignUpForm()));
                        },
                      ),
                      _googleButton()
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}
