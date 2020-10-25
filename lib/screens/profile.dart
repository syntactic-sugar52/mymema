import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_mema/components/post_item.dart';
import 'package:my_mema/components/post_tile.dart';
import 'package:my_mema/util/data.dart';

import 'main_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_mema/components/progress.dart';
import 'package:my_mema/models/user.dart';
import 'package:my_mema/screens/home.dart';
import 'package:my_mema/screens/edit_profile.dart';

class Profile extends StatefulWidget {
  final String profileId;
  Profile({this.profileId});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isFollowing = false;
  final String currentUserId = currentUser?.id;
  String postOrientation = "grid";
  bool isLoading = false;
  int postCount = 0;
  int followerCount = 0;
  int followingCount = 0;
  List<PostItem> post = [];

  @override
  void initState() {
    super.initState();
    getProfilePost();
    getFollowers();
    getFollowing();
    checkIfFollowing();
  }

  checkIfFollowing() async {
    DocumentSnapshot doc = await followersRef
        .doc(widget.profileId)
        .collection('userFollowers')
        .doc(currentUserId)
        .get();
    setState(() {
      isFollowing = doc.exists;
    });
  }

  getFollowing() async {
    QuerySnapshot snapshot = await followingRef
        .doc(widget.profileId)
        .collection('userFollowing')
        .get();
    setState(() {
      followingCount = snapshot.docs.length;
    });
  }

  getFollowers() async {
    QuerySnapshot snapshot = await followersRef
        .doc(widget.profileId)
        .collection('userFollowers')
        .get();
    setState(() {
      followerCount = snapshot.docs.length;
    });
  }

  getProfilePost() async {
    setState(() {
      isLoading = true;
    });
    QuerySnapshot snapshot = await postsRef
        .doc(widget.profileId)
        .collection('userPosts')
        .orderBy('timestamp', descending: true)
        .get();
    setState(() {
      isLoading = false;
      postCount = snapshot.docs.length;
      posts = snapshot.docs.map((doc) => PostItem.fromDocument(doc)).toList();
    });
  }

  editProfile() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditProfile(currentUserId: currentUserId)));
  }

  buildButton({String text, Function function}) {
    return FlatButton(
      onPressed: function,
      child: Container(
        width: 220.0,
        height: 25.0,
        child: Text(
          text,
          style: TextStyle(
              color: isFollowing ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold),
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isFollowing ? Colors.white : Colors.blue,
          border: Border.all(color: isFollowing ? Colors.grey : Colors.blue),
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    );
  }

  buildProfileButton() {
    //if viewing own profile show profile button
    bool isProfileOwner = currentUserId == widget.profileId;
    if (isProfileOwner) {
      return buildButton(text: "Edit Profile", function: editProfile);
    } else if (isFollowing) {
      return buildButton(
        text: "Unfollow",
        function: handleUnfollowUser,
      );
    } else if (!isFollowing) {
      return buildButton(
        text: "Follow",
        function: handleFollowUser,
      );
    }
  }

  handleFollowUser() {
    setState(() {
      isFollowing = true;
    });
    followersRef
        .doc(widget.profileId)
        .collection('userFollowers')
        .doc(currentUserId)
        .set({});
    followingRef
        .doc(currentUserId)
        .collection('userFollowing')
        .doc(widget.profileId)
        .set({});
    activityFeedRef
        .doc(widget.profileId)
        .collection('feedItems')
        .doc(currentUserId)
        .set({
      "type": "follow",
      "ownerId": widget.profileId,
      "username": currentUser.username,
      "userId": currentUser.id,
      "userProfileImg": currentUser.photoUrl,
      "timestamp": timestamp,
    });
  }

  handleUnfollowUser() {
    setState(() {
      isFollowing = false;
    });
    followersRef
        .doc(widget.profileId)
        .collection('userFollowers')
        .doc(currentUserId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    followingRef
        .doc(currentUserId)
        .collection('userFollowing')
        .doc(widget.profileId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    activityFeedRef
        .doc(widget.profileId)
        .collection('feedItems')
        .doc(currentUserId)
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    //     .set({
    //   "type": "follow",
    //   "ownerId": widget.profileId,
    //   "username": currentUser.username,
    //   "userId": currentUser.id,
    //   "userProfileImg": currentUser.photoUrl,
    //   "timestamp": timestamp,
    // });
  }

  Column buildCategory(String label, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          count.toString(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 4.0),
          child: Text(
            label,
            style: TextStyle(
                color: Colors.grey,
                fontSize: 16.0,
                fontWeight: FontWeight.w400),
          ),
        )
        // SizedBox(height: 4),
        // Text(
        //   label,
        //   style: TextStyle(),
        // ),
      ],
    );
  }

  buildProfileHeader() {
    return FutureBuilder(
      future: usersRef.doc(widget.profileId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        Users users = Users.fromDocument(snapshot.data);
        return Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  users.photoUrl,
                ),
                radius: 40,
              ),
              SizedBox(height: 10),
              Text(
                users.displayName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              SizedBox(height: 3),
              Text(
                users.status,
                style: TextStyle(),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  buildProfileButton()
                  // FlatButton(
                  //   child: Icon(
                  //     Icons.message,
                  //     color: Colors.white,
                  //   ),
                  //   color: Colors.grey,
                  //   onPressed: () {},
                  // ),
                  // SizedBox(width: 10),
                  // FlatButton(
                  //   child: Icon(
                  //     Icons.add,
                  //     color: Colors.white,
                  //   ),
                  //   color: Theme.of(context).accentColor,
                  //   onPressed: () {},
                  // ),
                ],
              ),
              SizedBox(height: 40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    buildCategory("Cards", postCount),
                    buildCategory("Friends", followerCount),
                    buildCategory("Teams", followingCount),
                  ],
                ),
              ),
              // SizedBox(height: 60),
              // CircleAvatar(
              //   radius: 40.0,
              //   backgroundColor: Colors.grey,
              //   backgroundImage: CachedNetworkImageProvider(
              //     users.photoUrl,
              //   ),
              // ),
              // SafeArea(
              //   // flex: 1,
              //   child: Column(
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         mainAxisSize: MainAxisSize.max,
              //         children: [
              //           buildCategory("Posts", postCount),
              //           buildCategory("Friends", 0),
              //           buildCategory("Teams", 0),
              //         ],
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           buildProfileButton(),
              //         ],
              //       )
              //     ],
              //   ),
              // ),
              // Container(
              //   alignment: Alignment.centerLeft,
              //   padding: EdgeInsets.only(top: 12.0),
              //   child: Text(
              //     users.username,
              //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              //   ),
              // ),
              // Container(
              //   alignment: Alignment.centerLeft,
              //   padding: EdgeInsets.only(top: 4.0),
              //   child: Text(
              //     users.displayName,
              //     style: TextStyle(),
              //   ),
              // )
            ],
          ),
        );
      },
    );
  }

  buildProfilePost() {
    if (isLoading) {
      return circularProgress();
    } else if (postOrientation == "grid") {
      List<GridTile> gridTiles = [];
      posts.forEach((post) {
        gridTiles.add(GridTile(child: PostTile(post)));
      });
      return GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        mainAxisSpacing: 1.5,
        crossAxisSpacing: 1.5,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: gridTiles,
      );
    } else if (postOrientation == "list") {
      return Column(
        children: posts,
      );
    }
  }

  setPostOrientation(String postOrientation) {
    setState(() {
      this.postOrientation = postOrientation;
    });
  }

  buildTogglePostOrientation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          onPressed: () => setPostOrientation("grid"),
          icon: Icon(Icons.grid_on),
          color: postOrientation == 'grid' ? Colors.black : Colors.grey,
          // color: Theme.of(context).primaryColor,
        ),
        IconButton(
          onPressed: () => setPostOrientation("list"),
          icon: Icon(Icons.list),
          color: postOrientation == 'list' ? Colors.black : Colors.grey,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          buildProfileHeader(),
          buildTogglePostOrientation(),
          buildProfilePost()
        ],
      ),
      // body: SingleChildScrollView(
      //   padding: EdgeInsets.symmetric(horizontal: 10),
      //   child: Container(
      //     width: MediaQuery.of(context).size.width,
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: [
      //         SizedBox(height: 60),
      //         buildProfileHeader(),
      //         buildTogglePostOrientation(),
      //         buildProfilePost()
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
