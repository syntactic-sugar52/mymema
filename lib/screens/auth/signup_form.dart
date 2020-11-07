// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:my_mema/states/current_user.dart';
// import 'login_container.dart';
//
// class SignUpForm extends StatefulWidget {
//   @override
//   _SignUpFormState createState() => _SignUpFormState();
// }
//
// class _SignUpFormState extends State<SignUpForm> {
//   TextEditingController _fullNameController = TextEditingController();
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//   TextEditingController _confirmPasswordController = TextEditingController();
//   TextEditingController _userNameController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   String userName;
//
//   void _signUpUser(String email, String password, String displayName,
//       String userName, BuildContext context) async {
//     CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
//     final form = _formKey.currentState;
//     try {
//       // onSubmit();
//       String _returnString =
//           await _currentUser.signUpUser(email, password, displayName, userName);
//       if (_returnString == "success") {
//         if (form.validate()) {
//           form.save();
//           SnackBar snackBar = SnackBar(
//             content: Text("Welcome to mema"),
//           );
//           _scaffoldKey.currentState.showSnackBar(snackBar);
//           Timer(Duration(seconds: 2), () {
//             Navigator.pop(context);
//           });
//         }
//       } else {
//         Scaffold.of(context).showSnackBar(SnackBar(
//           content: Text(_returnString),
//           duration: Duration(seconds: 2),
//         ));
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       body: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//             child: ListView(
//               padding: EdgeInsets.all(20.0),
//               children: [
//                 Padding(
//                   padding: EdgeInsets.all(10.0),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     BackButton(),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 40.0,
//                 ),
//                 LoginContainer(
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                             vertical: 20.0, horizontal: 8.0),
//                         child: Text(
//                           "Sign Up",
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 25.0,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       TextField(
//                         controller: _fullNameController,
//                         decoration: InputDecoration(
//                             prefixIcon: Icon(Icons.person_outline),
//                             hintText: "Full Name"),
//                       ),
//                       SizedBox(
//                         height: 20.0,
//                       ),
//                       Form(
//                         key: _formKey,
//                         // autovalidateMode: ,
//                         child: TextFormField(
//                           validator: (val) {
//                             if (val.trim().length < 3 || val.isEmpty) {
//                               return "Username too short.";
//                             } else if (val.trim().length > 12) {
//                               return "Username too long.";
//                             } else {
//                               return null;
//                             }
//                           },
//                           controller: _userNameController,
//                           decoration: InputDecoration(
//                               prefixIcon: Icon(Icons.person),
//                               hintText: "User Name"),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20.0,
//                       ),
//                       TextField(
//                         controller: _emailController,
//                         decoration: InputDecoration(
//                             prefixIcon: Icon(Icons.alternate_email),
//                             hintText: "Email"),
//                       ),
//                       SizedBox(
//                         height: 20.0,
//                       ),
//                       TextField(
//                         controller: _passwordController,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                             prefixIcon: Icon(Icons.lock_outline),
//                             hintText: "Password"),
//                       ),
//                       SizedBox(
//                         height: 20.0,
//                       ),
//                       TextField(
//                         controller: _confirmPasswordController,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                             prefixIcon: Icon(Icons.lock_open),
//                             hintText: "Confirm Password"),
//                       ),
//                       SizedBox(height: 20.0),
//                       RaisedButton(
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(horizontal: 100),
//                           child: Text(
//                             "Sign Up",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20.0),
//                           ),
//                         ),
//                         onPressed: () {
//                           if (_passwordController.text ==
//                               _confirmPasswordController.text) {
//                             _signUpUser(
//                                 _emailController.text,
//                                 _passwordController.text,
//                                 _fullNameController.text,
//                                 _userNameController.text,
//                                 context);
//                           } else {
//                             Scaffold.of(context).showSnackBar(SnackBar(
//                               content: Text("Passwords do not match"),
//                               duration: Duration(seconds: 2),
//                             ));
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
