import 'package:flutter/material.dart';
import 'package:my_mema/custom_image.dart';
import 'post_item.dart';
import 'package:my_mema/screens/post_screen.dart';

class PostTile extends StatelessWidget {
  final PostItem post;
  PostTile(this.post);

  showPost(context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostScreen(
          postId: post.postId,
          userId: post.ownerId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showPost(context),
      child: cachedNetworkImage(post.mediaUrl),
    );
  }
}
