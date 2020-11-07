import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_mema/models/user.dart';
import 'package:my_mema/screens/navigation_drawer.dart';
import 'package:my_mema/screens/root/root.dart';
import 'package:my_mema/screens/upload.dart';
import 'package:my_mema/search.dart';
import 'package:google_sign_in/google_sign_in.dart';

// User loggedInUser;
final GoogleSignIn googleSignIn = GoogleSignIn();

class Home extends StatefulWidget {
  static const String id = 'home_screen';
  // final Users currentUser;
  // Home({this.currentUser});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final PageController ctrl = PageController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // appBar: DefaultAppBar(),
        appBar: AppBar(
            backgroundColor: Colors.black87,
            title: Text("mema"),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(70.0),
              child: Container(
                color: Colors.white,
                child: TabBar(
                  labelColor: Colors.black,
                  indicatorColor: Color(0xff6886c5),
                  indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    Tab(child: Text('Social')),
                    Tab(
                      child: Text('Commerce'),
                    )
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              GestureDetector(
                // onTapUp: onSearchTapUp,
                behavior: HitTestBehavior.translucent,
                child: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Search()));
                    }),
                // onTap: () => onSearchTapUp,
              ),
            ]),
        drawer: NavigationDrawer(),
        floatingActionButton: FloatingActionButton(
          heroTag: "homebtn",
          backgroundColor: Color(0xff6886c5),
          child: Icon(
            Icons.camera,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Upload(
                          currentUser: currentUser,
                        )));
          },
        ),
      ),
    );
  }
}
