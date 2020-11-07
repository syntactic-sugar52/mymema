import 'package:flutter/material.dart';
import 'package:my_mema/screens/root/root.dart';
import 'package:my_mema/states/current_user.dart';
import 'package:provider/provider.dart';
import 'util/const.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/home.dart';
import 'util/mytheme.dart';
import 'screens/root/root.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      title: Constants.appName,
      theme: MyTheme().buildTheme(),
      home: MyRoot(),
      // home: MyRoot(),
      // darkTheme: themeData(ThemeConfig.darkTheme),
      // initialRoute: MyRoot.id,
      // routes: {
      //   MyRoot.id: (context) => MyRoot(),
      //   // Splash.id: (context) => Splash(),
      //   // WelcomeScreen.id: (context) => WelcomeScreen(),
      //   // LoginMain.id: (context) => LoginMain(),
      //   // LoginScreen.id: (context) => LoginScreen(),
      //   Home.id: (context) => Home(),
      // },
    );
  }

//   ThemeData themeData(ThemeData theme) {
//     return theme.copyWith(
//       textTheme: GoogleFonts.sourceSansProTextTheme(
//         theme.textTheme,
//       ),
//     );
//   }
// }
}
