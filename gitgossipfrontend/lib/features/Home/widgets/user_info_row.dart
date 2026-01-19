import 'package:flutter/material.dart';
import 'package:gitgossip/features/Home/models/feed_model.dart';

class UserInfoRow extends StatelessWidget {
  final FeedPostModel post;
  const UserInfoRow({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(backgroundImage: NetworkImage(post.avatarUrl), radius: 21),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.username,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Text(
                  post.username,
                  style: TextStyle(color: Colors.white70, fontSize: 13),
                ),
                const SizedBox(width: 7),
                Text(
                  '· ${post.time}',
                  style: TextStyle(color: Colors.white38, fontSize: 13),
                ),
              ],
            ),
          ],
        ),
        Spacer(),
        Icon(Icons.more_horiz, color: Colors.white60),
      ],
    );
  }
}
