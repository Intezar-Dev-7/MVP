import 'package:flutter/material.dart';
import 'package:gitgossip/features/Home/models/feed_model.dart';
import 'package:gitgossip/features/Home/widgets/action_button.dart';
import 'package:gitgossip/features/Home/widgets/user_info_row.dart';

class FeedPostCard extends StatelessWidget {
  final FeedPostModel post;
  const FeedPostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF232325),
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserInfoRow(post: post),
          const SizedBox(height: 12),
          Text(post.content, style: TextStyle(color: Colors.white)),
          const SizedBox(height: 12),

          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              post.imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ActionButton(
                icon: Icons.code,
                label: 'GitHub',
                color: Colors.white24,
              ),
              const SizedBox(width: 16),
              ActionButton(
                icon: Icons.link,
                label: 'Live Demo',
                color: Colors.blue,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.favorite, color: Colors.redAccent, size: 20),
              Text(' ${post.likes}', style: TextStyle(color: Colors.white70)),
              const SizedBox(width: 20),
              Icon(Icons.comment, color: Colors.white38, size: 20),
              Text(
                ' ${post.comments}',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(width: 20),
              Icon(Icons.share, color: Colors.white38, size: 20),
              Text(' ${post.shares}', style: TextStyle(color: Colors.white70)),
              Spacer(),
              Icon(Icons.bookmark, color: Colors.green, size: 22),
            ],
          ),
        ],
      ),
    );
  }
}
