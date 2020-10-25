import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_mema/screens/auth/register.dart';
import 'package:my_mema/screens/main_screen.dart';
import 'package:my_mema/screens/welcome_Screen.dart';
// import 'file:///C:/Users/angka/AndroidStudioProjects/my_mema/lib/screens/login.dart';
import 'screens/splash/splash.dart';
import 'util/const.dart';
import 'util/theme_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/auth/login.dart';
import 'screens/home.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: themeData(ThemeConfig.lightTheme),
      darkTheme: themeData(ThemeConfig.darkTheme),
      initialRoute: MainScreen.id,
      routes: {
        // Splash.id: (context) => Splash(),
        MainScreen.id: (context) => MainScreen(),
        // WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        Home.id: (context) => Home(),
      },
    );
  }

  ThemeData themeData(ThemeData theme) {
    return theme.copyWith(
      textTheme: GoogleFonts.sourceSansProTextTheme(
        theme.textTheme,
      ),
    );
  }
}
