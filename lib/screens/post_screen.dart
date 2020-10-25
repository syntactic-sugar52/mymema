import 'package:flutter/material.dart';
import 'package:my_mema/components/post_item.dart';
import 'package:my_mema/components/progress.dart';
import 'package:my_mema/screens/header.dart';
import 'package:my_mema/screens/main_screen.dart';
import 'main_screen.dart';

class PostScreen extends StatelessWidget {
  final String userId;
  final String postId;
  PostScreen({this.userId, this.postId});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: postsRef.doc(userId).collection('userPosts').doc(postId).get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        PostItem postItem = PostItem.fromDocument(snapshot.data);
        return Center(
          child: Scaffold(
            appBar: header(context, titleText: postItem.description),
            body: ListView(
              children: [
                Container(
                  child: postItem,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
