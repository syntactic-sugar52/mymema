import 'dart:async';

import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  String username;

  void submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      SnackBar snackbar = SnackBar(
        content: Text("Welcome $username"),
      );
      _scaffoldKey.currentState.showSnackBar(snackbar);
      Timer(Duration(seconds: 2), () {
        Navigator.of(context, rootNavigator: true).pop(username);
      });
    }
  }

  @override
  Widget build(BuildContext parentContext) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Set up you profile."),
      ),
      body: Center(
        child: ListView(
          children: [
            Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 50.0),
                    child: Center(
                      child: Center(
                        child: Text(
                          "Create a Username",
                          style: TextStyle(fontSize: 25.0, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Container(
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.always,
                          validator: (val) {
                            if (val.trim().length < 3 || val.isEmpty) {
                              return "Username too short.";
                            } else if (val.trim().length > 12) {
                              return "Username too long";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (val) => username = val,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Username",
                            labelStyle: TextStyle(fontSize: 15.0),
                            hintText: "Must be at least 3 characters",
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: submit,
                    child: Container(
                      height: 50.0,
                      width: 350.0,
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      child: Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
