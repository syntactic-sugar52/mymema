import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_mema/components/progress.dart';
import 'package:my_mema/components/post_item.dart';

class Comments extends StatefulWidget {
  final String postId;
  final String postOwnerId;
  final String postMediaUrl;

  Comments({this.postId, this.postOwnerId, this.postMediaUrl});
  @override
  _CommentsState createState() => _CommentsState(
      postId: this.postId,
      postOwnerId: this.postOwnerId,
      postMediaUrl: this.postMediaUrl);
}

class _CommentsState extends State<Comments> {
  TextEditingController commentController = TextEditingController();
  final String postId;
  final String postOwnerId;
  final String postMediaUrl;

  _CommentsState({this.postId, this.postOwnerId, this.postMediaUrl});

  // buildComments() {
  //   return StreamBuilder(
  //     stream: commentsRef
  //         .doc(postId)
  //         .collection('comments')
  //         .orderBy("timestamp", descending: true)
  //         .snapshots(),
  //     builder: (context, snapshot) {
  //       if (!snapshot.hasData) {
  //         return circularProgress();
  //       }
  //       List<Comment> comments = [];
  //       snapshot.data.documents.forEach((doc) {
  //         comments.add(Comment.fromDocument(doc));
  //       });
  //       return ListView(
  //         children: comments,
  //       );
  //     },
  //   );
  // }

  // addComments() {
  //   commentsRef.doc(postId).collection("comments").add({
  //     "username": currentUser.username,
  //     "comment": commentController.text,
  //     "timestamp": timestamp,
  //     "avatarUrl": currentUser.photoUrl,
  //     "userId": currentUser.id
  //   });
  //   bool isNotPostOwner = postOwnerId != currentUser.id;
  //   if (isNotPostOwner) {
  //     activityFeedRef.doc(postOwnerId).collection('feedItems').add({
  //       "type": "comment",
  //       "commentData": commentController.text,
  //       "timestamp": timestamp,
  //       "postId": postId,
  //       "username": currentUser.username,
  //       "userId": currentUser.id,
  //       "userProfileImg": currentUser.photoUrl,
  //       "mediaUrl": postMediaUrl,
  //     });
  //   }
  //   commentController.clear();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Text("comments"),
          ),
          Divider(),
          ListTile(
            title: TextFormField(
              controller: commentController,
              decoration: InputDecoration(labelText: "Write a comment"),
            ),
            trailing: OutlineButton(
              onPressed: () {},
              borderSide: BorderSide.none,
              child: Text("Post"),
            ),
          )
        ],
      ),
    );
  }
}

class Comment extends StatelessWidget {
  final String username;
  final String userId;
  final String avatarUrl;
  final String comment;
  final Timestamp timestamp;
  Comment(
      {this.username,
      this.userId,
      this.avatarUrl,
      this.comment,
      this.timestamp});
  factory Comment.fromDocument(DocumentSnapshot doc) {
    return Comment(
      username: doc['username'],
      userId: doc['userId'],
      comment: doc['comment'],
      timestamp: doc['timestamp'],
      avatarUrl: doc['avatarUrl'],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(comment),
          leading: CircleAvatar(
              // backgroundImage: CachedNetworkImageProvider(avatarUrl),
              ),
          // subtitle: Text(timeago.format(timestamp.toDate())),
        ),
        Divider()
      ],
    );
  }
}
