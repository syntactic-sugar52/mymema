import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_mema/components/icon_badge.dart';
import 'package:my_mema/screens/chat/chats.dart';
import 'package:my_mema/screens/upload.dart';
import 'package:my_mema/search.dart';
import 'friends.dart';
import 'home.dart';
import 'notifications.dart';
import 'profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_mema/models/user.dart';
import 'create_Account.dart';
import 'notifications.dart';
import 'package:my_mema/components/rounded_button.dart';
import 'auth/login.dart';
import 'auth/register.dart';
import 'package:firebase_storage/firebase_storage.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
final StorageReference storageRef = FirebaseStorage.instance.ref();
final usersRef = FirebaseFirestore.instance.collection('users');
final postsRef = FirebaseFirestore.instance.collection('posts');
final commentsRef = FirebaseFirestore.instance.collection('comments');
final followersRef = FirebaseFirestore.instance.collection('followers');
final followingRef = FirebaseFirestore.instance.collection('following');
final timelineRef = FirebaseFirestore.instance.collection('timeline');
final activityFeedRef = FirebaseFirestore.instance.collection('feed');
final chatRef = FirebaseFirestore.instance.collection('chat');
final DateTime timestamp = DateTime.now();
Users currentUser;

class MainScreen extends StatefulWidget {
  static const String id = 'main_screen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // PageController _pageController;
  bool isAuth = false;
  int _page = 2;
  PageController pageController;
  int pageIndex = 2;
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    // _pageController = PageController(initialPage: 2);
    getCurrentUser();
    // googleSignIn.onCurrentUserChanged.listen((account) {
    //   handleSignIn(account);
    // }, onError: (err) {
    //   print("Error signing in: $err");
    // });
    // googleSignIn.signInSilently(suppressErrors: false).then((account) {
    //   handleSignIn(account);
    // }).catchError((err) {
    //   print("Error signing in: $err");
    // });
    // _pageController = PageController();
  }

  // handleSignIn(GoogleSignInAccount account) async {
  //   if (account != null) {
  //     // print("User signed in: $account");
  //     await createUserInFirestore();
  //     setState(() {
  //       isAuth = true;
  //     });
  //   } else {
  //     isAuth = false;
  //   }
  // }
  //
  // createUserInFirestore() async {
  //   final GoogleSignInAccount user = googleSignIn.currentUser;
  //   DocumentSnapshot doc = await usersRef.doc(user.id).get();
  //   if (!doc.exists) {
  //     final username = await Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => CreateAccount(),
  //       ),
  //     );
  //     usersRef.doc(user.id).set({
  //       "id": user.id,
  //       "username": username,
  //       "photoUrl": user.photoUrl,
  //       "email": user.email,
  //       "displayName": user.displayName,
  //       "status": "",
  //       "timestamp": timestamp,
  //       "password": "",
  //       "isActive": "",
  //     });
  //     await followersRef
  //         .doc(user.id)
  //         .collection('userFollowers')
  //         .doc(user.id)
  //         .set({});
  //     doc = await usersRef.doc(user.id).get();
  //   }
  //   currentUser = Users.fromDocument(doc);
  //   print(currentUser);
  //   print(currentUser.username);
  // }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void getCurrentUser() async {
    final user = _auth.currentUser;
    try {
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  login() {
    googleSignIn.signIn();
  }

  logout() {
    googleSignIn.signOut();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(pageIndex,
        duration: Duration(milliseconds: 200), curve: Curves.bounceInOut);
  }

  RoundedButton roundedButton = RoundedButton();
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
                  child: Text("mema logo"),
                ),
                SizedBox(
                  height: 20.0,
                ),
                LoginScreen()
              ],
            ),
          )
        ],
      ),
    );
  }

  Scaffold buildAuthScreen() {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: onPageChanged,
        children: <Widget>[
          // Upload(currentUser: currentUser),
          Chats(),
          Friends(),
          Home(
            currentUser: currentUser,
          ),
          Notifications(),
          Profile(profileId: currentUser?.id),
          // Search()
        ],
      ),
      // bottomNavigationBar: CupertinoTabBar(
      //   currentIndex: pageIndex,
      //   onTap: onTap,
      //   activeColor: Colors.black,
      //   items: [
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: Theme.of(context).primaryColor,
          // canvasColor: Color(0xff756c83),
          // sets the active color of the `BottomNavigationBar` if `Brightness` is light
          primaryColor: Colors.black,
          // primaryColor: Color(0xff756c83),
          textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(color: Colors.grey[500]),
              ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.message,
              ),
              title: Container(height: 0.0),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.group,
              ),
              title: Container(height: 0.0),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              title: Container(height: 0.0),
            ),
            BottomNavigationBarItem(
              icon: IconBadge(
                icon: Icons.notifications,
              ),
              title: Container(height: 0.0),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              title: Container(height: 0.0),
            ),
          ],
          onTap: onTap,
          currentIndex: _page,
        ),
      ),
    );
    // endDrawer: DrawerInfo(),
  }

  @override
  Widget build(BuildContext context) {
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }

  // void navigationTapped(int page) {
  //   pageController.jumpToPage(page);
  // }

}
