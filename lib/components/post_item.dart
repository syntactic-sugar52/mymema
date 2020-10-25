import 'dart:async';

import 'package:animator/animator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_mema/components/progress.dart';
import 'package:my_mema/custom_image.dart';
import 'package:my_mema/screens/comments.dart';
import 'package:my_mema/screens/main_screen.dart';
import 'package:my_mema/models/user.dart';
import 'package:my_mema/screens/notifications.dart';

class PostItem extends StatefulWidget {
  final String postId;
  final String ownerId;
  final String username;
  final String location;
  final String description;
  final String mediaUrl;
  // final String type;
  final dynamic likes;
  PostItem(
      {Key key,
      @required this.postId,
      @required this.ownerId,
      @required this.username,
      @required this.location,
      @required this.description,
      // @required this.type,
      @required this.mediaUrl,
      @required this.likes})
      : super(key: key);

  factory PostItem.fromDocument(DocumentSnapshot doc) {
    return PostItem(
      postId: doc['postId'],
      ownerId: doc['ownerId'],
      username: doc['username'],
      location: doc['location'],
      description: doc['description'],
      mediaUrl: doc['mediaUrl'],
      likes: doc['likes'],
      // type: doc['type'],
    );
  }

  int getLikesCount(likes) {
    if (likes == null) {
      return 0;
    }
    int count = 0;
    likes.values.forEach((val) {
      if (val == true) {
        count += 1;
      }
    });
    return count;
  }

  @override
  _PostItemState createState() => _PostItemState(
        postId: this.postId,
        ownerId: this.ownerId,
        username: this.username,
        location: this.location,
        description: this.description,
        mediaUrl: this.mediaUrl,
        likes: this.likes,
        likeCount: getLikesCount(this.likes),
      );
}

class _PostItemState extends State<PostItem> {
  final String currentUserId = currentUser?.id;
  final String postId;
  final String ownerId;
  final String username;
  final String location;
  final String description;
  final String mediaUrl;
  bool showHeart = false;
  Map likes;
  int likeCount;
  bool isLiked;

  _PostItemState(
      {@required this.postId,
      @required this.ownerId,
      @required this.username,
      @required this.location,
      @required this.description,
      @required this.mediaUrl,
      this.likeCount,
      @required this.likes});
  // bool isClicked = false;
  // int click = 0;
  // int view = 0;
  // Color _colorChange = Colors.black;
  // final List<String> images = [
  //   "assets/cm0.jpeg",
  //   "assets/cm1.jpeg",
  //   "assets/cm2.jpeg"
  // ];
  int _current = 0;

  buildPostHeader() {
    return FutureBuilder(
      future: usersRef.doc(ownerId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        Users users = Users.fromDocument(snapshot.data);
        bool isPostOwner = currentUserId == ownerId;
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
              users.photoUrl,
            ),
          ),
          contentPadding: EdgeInsets.all(0),
          title: GestureDetector(
            onTap: () => showProfile(context, profileId: users.id),
            child: Text(
              users.username,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          trailing: isPostOwner
              ? IconButton(
                  onPressed: () => handleDeletePost(context),
                  icon: Icon(Icons.more_vert),
                )
              : Text(""),
          // trailing: Text(
          //   location,
          //   style: TextStyle(
          //     fontWeight: FontWeight.w300,
          //     fontSize: 11,
          //   ),
          // ),
        );
      },
    );
  }

  handleLikePost() {
    bool _isLiked = likes[currentUserId] == true;
    if (_isLiked) {
      postsRef
          .doc(ownerId)
          .collection('userPosts')
          .doc(postId)
          .update({'likes.$currentUserId': false});
      removeLikeFromActivityFeed();
      setState(() {
        likeCount -= 1;
        isLiked = false;
        likes[currentUserId] = false;
      });
    } else if (!isLiked) {
      postsRef
          .doc(ownerId)
          .collection('userPosts')
          .doc(postId)
          .update({'likes.$currentUserId': true});
      addLikeToActivityFeed();
      setState(() {
        likeCount += 1;
        isLiked = true;
        likes[currentUserId] = true;
        showHeart = true;
      });
      Timer(Duration(milliseconds: 500), () {
        setState(() {
          showHeart = false;
        });
      });
    }
  }

  handleDeletePost(BuildContext parentContext) {
    return showDialog(
        context: parentContext,
        builder: (context) {
          return SimpleDialog(
            title: Text("Remove this post?"),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                  deletePost();
                },
                child: Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "Cancel",
                  // style: TextStyle(color: Colors.red),
                ),
              )
            ],
          );
        });
  }

  deletePost() async {
    postsRef.doc(ownerId).collection('userPosts').doc(postId).get().then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    storageRef.child("post_$postId.jpg").delete();
    QuerySnapshot activityFeedSnapshot = await activityFeedRef
        .doc(ownerId)
        .collection("feedItems")
        .where('postId', isEqualTo: postId)
        .get();
    activityFeedSnapshot.docs.forEach((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
    QuerySnapshot commentsSnapshot =
        await commentsRef.doc(postId).collection('comments').get();
    commentsSnapshot.docs.forEach((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }

  removeLikeFromActivityFeed() {
    bool isNotPostOwner = currentUserId != ownerId;
    if (isNotPostOwner) {
      activityFeedRef
          .doc(ownerId)
          .collection("feedItems")
          .doc(postId)
          .get()
          .then((doc) {
        if (doc.exists) {
          doc.reference.delete();
        }
      });
    }
  }

  addLikeToActivityFeed() {
    bool isNotPostOwner = currentUserId != ownerId;
    if (isNotPostOwner) {
      activityFeedRef.doc(ownerId).collection("feedItems").doc(postId).set({
        "type": "like",
        "username": currentUser.username,
        "userId": currentUser.id,
        "userProfileImg": currentUser.photoUrl,
        "postId": postId,
        "mediaUrl": mediaUrl,
        "timestamp": timestamp
      });
    }
  }

  buildPostImage() {
    return GestureDetector(
      onDoubleTap: handleLikePost,
      child: Stack(alignment: Alignment.center, children: [
        cachedNetworkImage(mediaUrl),
        showHeart
            ? Animator(
                duration: Duration(milliseconds: 300),
                tween: Tween(begin: 0.8, end: 1.4),
                curve: Curves.elasticOut,
                cycles: 0,
                builder: (context, animatorState, child) => Transform.scale(
                  scale: animatorState.value,
                  child: Opacity(
                    opacity: 0.5,
                    child: Icon(
                      Icons.favorite,
                      size: 80.0,
                      color: Colors.red,
                    ),
                  ),
                ),
              )
            : Text(""),
        showHeart
            ? Icon(
                Icons.favorite,
                size: 80.0,
                color: Colors.red,
              )
            : Text("")
      ]),
    );
  }

  buildPostFooter() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40.0, left: 20.0),
            ),
            GestureDetector(
              onTap: handleLikePost,
              child: Icon(
                isLiked ? Icons.favorite : Icons.favorite_border,
                size: 28.0,
                color: Colors.pink,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40.0, right: 20.0),
            ),
            GestureDetector(
              onTap: () => showComments(context,
                  postId: postId, ownerId: ownerId, mediaUrl: mediaUrl),
              child: Icon(
                Icons.chat,
                size: 28.0,
                color: Colors.blue[900],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20.0),
              child: Text(
                "$likeCount likes",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20.0),
              child: Text(
                "$username",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Text(description),
            )
          ],
        )
      ],
    );
  }
  // buildPostFooter() {
  //   return Column(
  //     children: [
  //       Padding(
  //         padding: EdgeInsets.only(top: 10, left: 12),
  //         child: Container(
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text(
  //                 "Hair Extensions", //item
  //                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800),
  //               ),
  //               Text(
  //                 "Service",
  //                 style:
  //                     TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
  //               )
  //             ],
  //           ),
  //         ),
  //       )
  //     ],
  //   );
  // }

  buildPostFooterIcons() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40.0, left: 20.0),
            ),
            GestureDetector(
              onTap: () => print('liked posts'),
              child: Icon(
                Icons.favorite_border,
                size: 28.0,
                color: Colors.pink,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.0),
            ),
            GestureDetector(
              onTap: () => print('show comments'),
              child: Icon(
                Icons.chat,
                size: 28.0,
                color: Colors.blue[900],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20.0),
              child: Text(
                "$likeCount likes",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20.0),
              child: Text(
                "$username",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Text(description),
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    isLiked = (likes[currentUserId] == true);
    return Scaffold(
      body: Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.topLeft,
        children: <Widget>[
          Image.asset(
            "images/cm0.jpeg",
            fit: BoxFit.cover,
            height: 280,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32.0, left: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(24.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius:
                                20.0, // has the effect of softening the shadow
                            spreadRadius: 2.0,
                            offset: Offset(
                              5.0, // horizontal, move right 10
                              5.0, // vertical, move down 10
                            ),
                          ),
                        ],
                        color: Colors.black45),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 62,
                ),
                Container(
                  height: 24,
                  width: 72,
                  decoration: BoxDecoration(
                      color: Color(0xFFffffffff),
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Center(
                    child: Text(
                      "Design",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Product_Sans_Regular",
                          fontSize: 12.0,
                          height: 1.4),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Basics of \nColour theory",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32.0,
                        fontFamily: "Product_Sans_Bold"),
                  ),
                )
              ],
            ),
          ),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16.0),
                      topLeft: Radius.circular(16.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 16.0,
                    ),
                  ],
                  color: Color(0xfffafafa)),
              margin: EdgeInsets.only(top: 266),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 16.0,
                      ),
                      ClipOval(
                        child: Image.asset(
                          "images/image_one.jpg",
                          fit: BoxFit.cover,
                          height: 42,
                          width: 42,
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 2.0, horizontal: 0.0),
                            child: Text(
                              "Raj Krishnan",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontFamily: "Product_Sans_Regular"),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 0.0),
                            child: Text(
                              "Oct 16 3 Min Read",
                              style: TextStyle(
                                  color: Color(0xff9b9b9b),
                                  fontSize: 12.0,
                                  fontFamily: "Product_Sans_Regular"),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16.0),
                    child: Text(
                      '''Colour has long been used to influence sales. And come on, who hasn’t made a purchase just because they liked the colour the product came in? Shade associations are important and frequently used to reflect ideals and function in branding. For example, green — the colour of health, tranquility and nature — can be used in stores to relax customers. Orange and yellow encourage brightness and optimism, while blue — a popular colour, especially among men — promotes trust among more conservative
                          ''',
                      style: TextStyle(
                          height: 1.4,
                          color: Color(0xff464646),
                          fontSize: 18.0,
                          fontFamily: "Product_Sans_Regular"),
                    ),
                  )
                ],
              )),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 242, right: 32),
              child: Container(
                height: 48,
                width: 48,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(24.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius:
                            20.0, // has the effect of softening the shadow
                        spreadRadius: 2.0,
                        offset: Offset(
                          5.0, // horizontal, move right 10
                          5.0, // vertical, move down 10
                        ),
                      ),
                    ],
                    color: Colors.white),
                child: IconButton(
                  icon: Icon(
                    Icons.bookmark_border,
                    color: Colors.black,
                    size: 24.0,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: MediaQuery.of(context).size.height * .27,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16.0),
                        topLeft: Radius.circular(16.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 20.0,
                      ),
                    ],
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            color: Color(0xffd8d8d8),
                            height: 5,
                            width: 80,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 24.0,
                          top: 16,
                        ),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Read premium article.",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24.0,
                                fontFamily: "Product_Sans_Bold"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 24.0,
                          top: 4,
                        ),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Upgrade to premium in just 5\$/month.",
                            style: TextStyle(
                                color: Color(0xff9b9b9b),
                                fontSize: 14.0,
                                fontFamily: "Product_Sans_Regular"),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: RaisedButton(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                "Upgrade Now",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24.0,
                                    fontFamily: "Product_Sans_Bold"),
                              ),
                            ),
                            onPressed: () {},
                          ),
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
    // return Padding(
    //   padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
    //   child: InkWell(
    //     child: Column(
    //       children: <Widget>[
    // buildPostHeader(),
    //
    // buildPostImage(),
    // buildPostFooter(),
    // CarouselSlider.builder(
    //     options: CarouselOptions(
    //         autoPlay: false,
    //         enlargeCenterPage: true,
    //         viewportFraction: 10,
    //         aspectRatio: 1.5,
    //         initialPage: images.length,
    //         scrollDirection: Axis.horizontal,
    //         onPageChanged: (index, reason) {
    //           setState(() {
    //             _current = index;
    //           });
    //         }),
    //     itemCount: 3,
    //     itemBuilder: (BuildContext context, int itemIndex) => Container(
    //           child: Image.asset(images[itemIndex], fit: BoxFit.cover),
    //         )),
    // Row(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   // crossAxisAlignment: CrossAxisAlignment.stretch,
    //   children: images.map((url) {
    //     int index = images.indexOf(url);
    //     return Container(
    //       width: 5.0,
    //       height: 5.0,
    //       margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
    //       decoration: BoxDecoration(
    //         shape: BoxShape.circle,
    //         color: _current == index
    //             ? Color.fromRGBO(0, 0, 0, 0.9)
    //             : Color.fromRGBO(0, 0, 0, 0.4),
    //       ),
    //     );
    //   }).toList(),
    // ),
    // Image.asset(
    //   "${widget.img}",
    //   height: 210,
    //   width: MediaQuery.of(context).size.width,
    //   fit: BoxFit.cover,
    // ),
    //         SizedBox(
    //           height: 7.0,
    //         ),
    //         Column(
    //           children: [
    //             Padding(
    //               padding: EdgeInsets.only(top: 10, left: 12),
    //               child: Container(
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Text(
    //                       "Hair Extensions", //item
    //                       style: TextStyle(
    //                           fontSize: 15, fontWeight: FontWeight.w800),
    //                     ),
    //                     Text(
    //                       "Service",
    //                       style: TextStyle(
    //                           color: Colors.red, fontWeight: FontWeight.w700),
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             )
    //           ],
    //         ),
    //         Column(
    //           children: [
    //             Padding(
    //               padding: EdgeInsets.only(top: 10, left: 10),
    //               child: Container(
    //                 child: Row(
    //                   children: [
    //                     Text(
    //                       "Trade for Interior Designers.",
    //                       style: TextStyle(fontWeight: FontWeight.w500),
    //                     ) // summary
    //                   ],
    //                 ),
    //               ),
    //             )
    //           ],
    //         ),
    //         Column(
    //           children: [
    //             Padding(
    //               padding: EdgeInsets.only(top: 10, left: 10),
    //               child: Container(
    //                 child: Row(
    //                   children: [
    //                     Text(
    //                       "A fast and easy way to clip hair extensions.",
    //                       style: TextStyle(fontWeight: FontWeight.w500),
    //                     ) // summary
    //                   ],
    //                 ),
    //               ),
    //             )
    //           ],
    //         ),
    //         SizedBox(
    //           height: 10,
    //         ),
    //         Column(
    //           children: [
    //             Padding(
    //               padding: EdgeInsets.only(top: 10, left: 10),
    //               child: Container(
    //                 child: Row(
    //                   children: [
    //                     IconButton(
    //                       icon: Icon(Icons.remove_red_eye),
    //                       onPressed: () {},
    //                     ),
    //                     Padding(
    //                       padding: EdgeInsets.only(right: 6.0),
    //                     ),
    //                     // Text("$view"),
    //                     Padding(padding: EdgeInsets.only(right: 30.0)),
    //                     IconButton(
    //                       icon: Icon(
    //                         Icons.favorite_border,
    //                         // color: _colorChange,
    //                       ),
    //                       onPressed: () {
    //                         print('pressed');
    //                       },
    //                     ),
    //                     Padding(
    //                       padding: EdgeInsets.only(right: 6.0),
    //                     ),
    //                     // Text("$click")
    //                   ],
    //                 ),
    //               ),
    //             )
    //           ],
    //
    //           // SizedBox(
    //           //   height: 8,
    //           // )
    //         ),
    //       ],
    //     ),
    //     // onLongPress: () {
    //     //   Scaffold.of(context).openEndDrawer();
    //     // },
    //   ),
    // );
  }
}

showComments(BuildContext context,
    {String postId, String ownerId, String mediaUrl}) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Comments(
              postId: postId, postOwnerId: ownerId, postMediaUrl: mediaUrl)));
}

// GridView.builder(
// shrinkWrap: true,
// physics: NeverScrollableScrollPhysics(),
// primary: false,
// padding: EdgeInsets.all(5),
// itemCount: 15,
// gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// crossAxisCount: 3,
// childAspectRatio: 200 / 200,
// ),
// itemBuilder: (BuildContext context, int index) {
// return Padding(
// padding: EdgeInsets.all(5.0),
// child: Image.asset(
// "assets/cm${random.nextInt(10)}.jpeg",
// fit: BoxFit.cover,
// ),
// );
// },
// ),
