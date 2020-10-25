import 'dart:async';
import 'package:my_mema/util/const.dart';
import 'package:flutter/material.dart';
import 'package:my_mema/components/animations/type_write.dart';
import 'package:my_mema/screens/auth/check_email.dart';
import 'package:my_mema/util/const.dart';
import 'package:my_mema/util/router.dart';

class Splash extends StatefulWidget {
  static const String id = 'splash_screen';
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  // Timer to change the screen in 1.2 seconds
  // startTimeout() {
  //   return Timer(Duration(milliseconds: 1200), handleTimeout);
  // }
  //
  // void handleTimeout() {
  //   changeScreen();
  // }
  //
  // changeScreen() async {
  //   RouterNav.pushPageWithFadeAnimation(context, CheckEmail());
  // }
  //
  // @override
  // void initState() {
  //   super.initState();
  //   startTimeout();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Center(
            child: Material(
              type: MaterialType.transparency,
              child: TypeWrite(
                word: '${Constants.appName}',
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
                seconds: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
