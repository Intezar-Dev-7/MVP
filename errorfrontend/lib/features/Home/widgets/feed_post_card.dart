// import 'package:flutter/material.dart';
// import 'package:gitgossip/features/Home/models/feed_model.dart';

// class FeedPostCard extends StatelessWidget {
//   final FeedPost post;

//   const FeedPostCard({super.key, required this.post});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       padding: const EdgeInsets.all(12),
//       color: Colors.black,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           /// 🔹 USER INFO
//           Row(
//             children: [
//               CircleAvatar(
//                 backgroundImage: post.userAvatar.isNotEmpty
//                     ? NetworkImage(post.userAvatar)
//                     : null,
//                 child: post.userAvatar.isEmpty
//                     ? const Icon(Icons.person)
//                     : null,
//               ),
//               const SizedBox(width: 10),
//               Text(
//                 post.userName,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 10),

//           /// 🔹 POST TEXT
//           Text(post.content, style: const TextStyle(color: Colors.white)),

//           const SizedBox(height: 10),

//           /// 🔹 IMAGE (optional)
//           if (post.imageUrl != null && post.imageUrl!.isNotEmpty)
//             ClipRRect(
//               borderRadius: BorderRadius.circular(10),
//               child: Image.network(post.imageUrl!),
//             ),

//           const SizedBox(height: 10),

//           /// 🔹 DESCRIPTION
//           Text(post.description, style: const TextStyle(color: Colors.white70)),

//           const SizedBox(height: 12),

//           /// 🔹 ACTIONS (LIKE / COMMENT / SHARE)
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               IconButton(
//                 onPressed: () {},
//                 icon: const Icon(Icons.favorite_border, color: Colors.white),
//               ),
//               IconButton(
//                 onPressed: () {},
//                 icon: const Icon(
//                   Icons.chat_bubble_outline,
//                   color: Colors.white,
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {},
//                 icon: const Icon(Icons.send, color: Colors.white),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:gitgossip/features/Home/models/feed_model.dart';

class FeedPostCard extends StatelessWidget {
  final FeedPost post;

  const FeedPostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF121212),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 USER INFO
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[800],
                backgroundImage: post.userProfilePic.isNotEmpty
                    ? NetworkImage(post.userProfilePic)
                    : null,
                child: post.userProfilePic.isEmpty
                    ? const Icon(Icons.person, color: Colors.white54)
                    : null,
              ),
              const SizedBox(width: 10),

              Text(
                post.username,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// 🔹 TITLE (this replaced "content")
          if (post.title.isNotEmpty)
            Text(
              post.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),

          const SizedBox(height: 8),

          /// 🔹 IMAGE (this replaced "imageUrl")
          if (post.images.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(post.images.first),
            ),

          const SizedBox(height: 10),

          /// 🔹 DESCRIPTION
          if (post.description.isNotEmpty)
            Text(
              post.description,
              style: const TextStyle(color: Colors.white70),
            ),

          const SizedBox(height: 12),

          /// 🔹 ACTIONS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    post.likes.toString(),
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),

              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.chat_bubble_outline,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    post.comments.toString(),
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),

              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.send, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
