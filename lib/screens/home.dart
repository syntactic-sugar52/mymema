import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_mema/components/post_item.dart';
import 'package:my_mema/components/post_tile.dart';
import 'package:my_mema/screens/upload.dart';
import 'package:my_mema/search.dart';
import 'bottom_sheet.dart';
import 'drawer_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_mema/util/data.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:my_mema/components/progress.dart';
import 'main_screen.dart';
import 'package:my_mema/models/user.dart';

// import '';
User loggedInUser;
// final usersRef = FirebaseFirestore.instance.collection('users');

class Home extends StatefulWidget {
  static const String id = 'home_screen';
  final Users currentUser;
  Home({this.currentUser});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<PostItem> posts = [];
  List<String> followingList = [];
  bool showSpinner = false;
  final messageTextController =
      TextEditingController(); //controller prop for TextField. to use it to clear the textfield after pressing send.
  final _auth = FirebaseAuth.instance;
  // final _auth = FirebaseAuth.instance;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   // getUsers();
  //   // getUserById();
  //   // createUser();
  //   // updateUser();
  //   // deleteUser();
  //   super.initState();
  //   // getCurrentUser();
  // }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    getTimeline();
    getFollowing();
  }

  getTimeline() async {
    QuerySnapshot snapshot = await timelineRef
        .doc(widget.currentUser.id)
        .collection('timelinePosts')
        .orderBy('timestamp', descending: true)
        .get();
    List<PostItem> posts =
        snapshot.docs.map((doc) => PostItem.fromDocument(doc)).toList();
    setState(() {
      this.posts = posts;
    });
  }

  void getCurrentUser() async {
    final user = _auth.currentUser;
    final uid = user.uid;
    try {
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }

    //will be null if no one signed in
  }

  getFollowing() async {
    QuerySnapshot snapshot = await followingRef
        .doc(currentUser.id)
        .collection('userFollowing')
        .get();
    setState(() {
      followingList = snapshot.docs.map((doc) => doc.id).toList();
    });
  }
//get data
//   void messageStream() async {
//     await for (var snapshot in usersRef.snapshots()) {
//       for (var message in snapshot.docs) {
//         print(message.data());
//       }
//     }
//   }
//   createUser() {
//     usersRef
//         .doc("ddsdssds")
//         .set({"username": "jack", "postCount": 0, "isAdmin": false});
//   }
  //
  // updateUser() async {
  //   final doc = await usersRef.doc("1210ez1BOfh3w4tO3MqE").get();
  //   if (doc.exists) {
  //     doc.reference
  //         .update({"username": "jack", "postCount": 0, "isAdmin": false});
  //   }
  //   // .update({"username": "john", "postCount": 0, "isAdmin": false});
  // }
  //
  // deleteUser() async {
  //   final DocumentSnapshot doc =
  //       await usersRef.doc("1210ez1BOfh3w4tO3MqE").get();
  //   if (doc.exists) {
  //     doc.reference.delete();
  //   }
  // }
  //
  // getUsers() {
  //   usersRef.get().then((QuerySnapshot snapshot) {
  //     snapshot.docs.forEach((DocumentSnapshot doc) {
  //       print(doc.data);
  //       print(doc.id);
  //       print(doc.exists);
  //     });
  //   });
  // }

  // getUserById() async {
  //   final String id = "1210ez1BOfh3w4tO3MqE";
  //   final DocumentSnapshot doc = await usersRef.doc(id).get();
  //   print(doc.id);
  //   print(doc.exists);
  //   print(doc.data);
  //   print(doc.data);
  //   print(doc.exists);
  //   print(doc.data);
  //     .then((DocumentSnapshot doc) {
  //   print(doc.id);
  //   print(doc.exists);
  //   print(doc.data);
  // });
  // }
  //
  // void getCurrentUser() async {
  //   final user = _auth.currentUser;
  //   try {
  //     if (user != null) {
  //       loggedInUser = user;
  //       print(loggedInUser.email);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  buildTimeline() {
    if (posts == null) {
      return circularProgress;
    } else if (posts.isEmpty) {
      return buildUsersToFollow();
    } else {
      return ListView(
        children: posts,
      );
    }
  }

  buildUsersToFollow() {
    return StreamBuilder(
      stream:
          usersRef.orderBy('timestamp', descending: true).limit(30).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        List<UserResult> userResults = [];
        snapshot.data.docs.forEach((doc) {
          Users users = Users.fromDocument(doc);
          final bool isAuthUser = currentUser.id == users.id;
          final bool isFollowingUser = followingList.contains(users.id);
          if (isAuthUser) {
            return;
          } else if (isFollowingUser) {
            return;
          } else {
            UserResult userResult = UserResult(users);
            userResults.add(userResult);
          }
        });
        return Container(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_add,
                      color: Colors.black,
                      size: 30.0,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      "users to follow",
                      style: TextStyle(fontSize: 30.0),
                    )
                  ],
                ),
              ),
              Column(
                children: userResults,
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            // automaticallyImplyLeading: false,
            title: Text("mema"),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.filter_list,
                ),
                onPressed: () {},
              ),
            ],
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20.0),
              child: Container(
                color: Colors.white,
                child: TabBar(
                  labelColor: Colors.black,
                  indicatorColor: Color(0xff6886c5),
                  // indicatorSize: TabBarIndicatorSize.label,
                  tabs: [
                    Tab(child: Text('Social')),
                    Tab(
                      child: Text('Commerce'),
                    )
                  ],
                ),
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () => getTimeline(),
            child: buildTimeline(),
          ),
          // body: StreamBuilder<QuerySnapshot>(
          //   stream: usersRef.snapshots(),
          //   builder: (context, snapshot) {
          //     if (!snapshot.hasData) {
          //       return circularProgress();
          //     }
          //     final List<Text> children = snapshot.data.docs
          //         .map((doc) => Text(doc["username"]))
          //         .toList();
          //     return Container(
          //       child: ListView(children: children),
          //     );
          //   },
          // ),
          // body: ListView.builder(
          //   padding: EdgeInsets.symmetric(horizontal: 20),
          //   itemCount: posts.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     Map post = posts[index];
          //     return PostItem(
          //       img: post['img'],
          //       name: post['name'],
          //       dp: post['dp'],
          //       time: post['time'],
          //     );
          //   },
          // ),
          floatingActionButton: FloatingActionButton(
            heroTag: "homebtn",
            backgroundColor: Color(0xff6886c5),
            child: Icon(
              Icons.camera,
              color: Colors.white,
            ),
            onPressed: () => Upload(),
          ),
          endDrawer: DrawerInfo(),
        ),
      ),
    );
  }
}
