import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_mema/components/progress.dart';
import 'package:my_mema/screens/main_screen.dart';
import 'package:my_mema/screens/post_screen.dart';
import 'package:my_mema/util/data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'profile.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  getActivityFeed() async {
    QuerySnapshot snapshot = await activityFeedRef
        .doc(currentUser.id)
        .collection('feedItems')
        .orderBy('timestamp', descending: true)
        .limit(50)
        .get();
    List<ActivityFeedItem> feedItem = [];
    snapshot.docs.forEach((docs) {
      ActivityFeedItem.fromDocument(docs);
      feedItem.add(ActivityFeedItem.fromDocument(docs));
      // print('Activity feed items : ${docs.data}');
    });
    return feedItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.filter_list,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: getActivityFeed(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return circularProgress();
            }
            return ListView(
              children: snapshot.data,
            );
          },
        ),
      ),
      // body: ListView.separated(
      //   padding: EdgeInsets.all(10),
      //   separatorBuilder: (BuildContext context, int index) {
      //     return Align(
      //       alignment: Alignment.centerRight,
      //       child: Container(
      //         height: 0.5,
      //         width: MediaQuery.of(context).size.width / 1.3,
      //         child: Divider(),
      //       ),
      //     );
      //   },
      //   itemCount: notifications.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     Map notif = notifications[index];
      //     return Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: ListTile(
      //         leading: CircleAvatar(
      //           backgroundImage: AssetImage(
      //             notif['dp'],
      //           ),
      //           radius: 25,
      //         ),
      //         contentPadding: EdgeInsets.all(0),
      //         title: Text(notif['notif']),
      //         trailing: Text(
      //           notif['time'],
      //           style: TextStyle(
      //             fontWeight: FontWeight.w300,
      //             fontSize: 11,
      //           ),
      //         ),
      //         onTap: () {},
      //       ),
      //     );
      //   },
      // ),
    );
  }
}

Widget mediaPreview;
String activityItemText;

class ActivityFeedItem extends StatelessWidget {
  final String username;
  final String userId;
  final String type;
  final String mediaUrl;
  final String postId;
  final String userProfileImg;
  final String commentData;
  final Timestamp timestamp;
  ActivityFeedItem(
      {this.username,
      this.userId,
      this.type,
      this.mediaUrl,
      this.postId,
      this.userProfileImg,
      this.commentData,
      this.timestamp});

  factory ActivityFeedItem.fromDocument(DocumentSnapshot doc) {
    return ActivityFeedItem(
      username: doc['username'],
      userId: doc['userId'],
      type: doc['type'],
      postId: doc['postId'],
      userProfileImg: doc['userProfileImg'],
      commentData: doc['commentData'],
      timestamp: doc['timestamp'],
      mediaUrl: doc['mediaUrl'],
    );
  }

  showPost(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostScreen(
          postId: postId,
          userId: userId,
        ),
      ),
    );
  }

  configureMediaPreview(context) {
    if (type == "like" || type == "comment") {
      mediaPreview = GestureDetector(
        onTap: () => showPost(context),
        child: Container(
          height: 50.0,
          width: 50.0,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(mediaUrl),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      mediaPreview = Text("");
    }
    if (type == "like") {
      activityItemText = "liked your post";
    } else if (type == "follow") {
      activityItemText = "is Following you";
    } else if (type == "comment") {
      activityItemText = "replied: $commentData";
    } else {
      activityItemText = "Error: Unknown type `$type`";
    }
  }

  @override
  Widget build(BuildContext context) {
    configureMediaPreview(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 2.0),
      child: Container(
        color: Colors.white54,
        child: ListTile(
          title: GestureDetector(
            onTap: () => showProfile(context, profileId: userId),
            child: RichText(
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                style: TextStyle(fontSize: 14.0, color: Colors.black),
                children: [
                  TextSpan(
                    text: username,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: '$activityItemText')
                ],
              ),
            ),
          ),
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(userProfileImg),
          ),
          subtitle: Text(
            timeago.format(
              timestamp.toDate(),
            ),
            overflow: TextOverflow.ellipsis,
          ),
          trailing: mediaPreview,
        ),
      ),
    );
  }
}

showProfile(BuildContext context, {String profileId}) {
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => Profile(profileId: profileId)));
}
