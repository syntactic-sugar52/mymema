import 'package:flutter/material.dart';
import 'package:my_mema/screens/main_screen.dart';
import 'package:my_mema/util/const.dart';
import 'package:my_mema/components/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_mema/components/rounded_button.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:my_mema/screens/home.dart';
import 'file:///C:/Users/angka/AndroidStudioProjects/my_mema/lib/screens/auth/login.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  //Create variable to store value
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  //Do something with the user input.
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                color: Colors.blueAccent,
                buttonTitle: 'Register',
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      Navigator.pushNamed(context, LoginScreen.id);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class Register extends StatefulWidget {
//   final String email;
//
//   Register({@required this.email});
//
//   @override
//   _RegisterState createState() => _RegisterState();
// }
//
// class _RegisterState extends State<Register> {
//   final _auth = FirebaseAuth.instance;
//   bool loading = false;
//   bool validate = false;
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   String email, password, name = '';
//   FocusNode nameFN = FocusNode();
//   FocusNode emailFN = FocusNode();
//   FocusNode passFN = FocusNode();
//
//   register() {
//     FormState form = formKey.currentState;
//     form.save();
//     if (!form.validate()) {
//       validate = true;
//       setState(() async {});
//       showInSnackBar('Please fix the errors in red before submitting.');
//     } else {
//       // Router.pushPage(context, MainScreen());
//
//     }
//   }
//
//   void registerUser() async {
//     try {
//       final newUser = await _auth.createUserWithEmailAndPassword(
//           email: email, password: password);
//
//       if (newUser != null) {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => MainScreen()));
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   void showInSnackBar(String value) {
//     _scaffoldKey.currentState.removeCurrentSnackBar();
//     _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(value)));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20.0),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Hero(
//                 tag: 'appname',
//                 child: Material(
//                   type: MaterialType.transparency,
//                   child: Text(
//                     'Register',
//                     style: TextStyle(
//                       fontSize: 40.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 100.0,
//               ),
//               Form(
//                 autovalidate: validate,
//                 key: formKey,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     CustomTextField(
//                       enabled: !loading,
//                       hintText: "Name",
//                       textInputAction: TextInputAction.next,
//                       validateFunction: Validations.validateName,
//                       onSaved: (String val) {
//                         name = val;
//                       },
//                       focusNode: nameFN,
//                       nextFocusNode: emailFN,
//                     ),
//                     SizedBox(
//                       height: 20.0,
//                     ),
//                     CustomTextField(
//                       enabled: false,
//                       initialValue: widget.email,
//                       hintText: "mema@gmail.com",
//                       textInputAction: TextInputAction.next,
//                       validateFunction: Validations.validateEmail,
//                       onSaved: (String val) {
//                         email = val;
//                         // print(email);
//                       },
//                       focusNode: emailFN,
//                       nextFocusNode: passFN,
//                     ),
//                     SizedBox(
//                       height: 20.0,
//                     ),
//                     CustomTextField(
//                       enabled: !loading,
//                       hintText: "Password",
//                       textInputAction: TextInputAction.done,
//                       validateFunction: Validations.validatePassword,
//                       submitAction: register,
//                       obscureText: true,
//                       onSaved: (String val) {
//                         password = val;
//                         // print(password);
//                       },
//                       focusNode: passFN,
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 40.0,
//               ),
//               buildButton(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   buildButton() {
//     return loading
//         ? Center(child: CircularProgressIndicator())
//         : CustomButton(
//             label: "Register",
//             onPressed: () async {
//               // print(email);
//               // print(password);
//
//               // Navigator.push(
//               //     context, MaterialPageRoute(builder: (context) => register()));
//             });
//   }
// }
