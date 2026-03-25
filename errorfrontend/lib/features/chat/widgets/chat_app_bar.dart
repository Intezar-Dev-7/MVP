import 'package:flutter/material.dart';
import 'package:gitgossip/features/userProfile/screens/other_user_profile_screen.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final String name;
  // final String status;

  final String avatar;

  const ChatAppBar({
    super.key,
    required this.context,
    required this.name,

    // required this.status,
    required this.avatar,
  });

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF1F2C33),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white70),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  OtherUserProfileScreen(name: name, avatar: avatar),
            ),
          );
        },
        child: Row(
          children: [
            CircleAvatar(radius: 20, backgroundImage: NetworkImage(avatar)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        // Call and video Icon , this feature in not yet implemented
        IconButton(
          icon: const Icon(Icons.videocam, color: Colors.white70),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Video call coming soon "),
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(12),
              ),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.call, color: Colors.white70),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text("Voice call coming soon "),
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(12),
              ),
            );
          },
        ),
      ],
    );
  }
}
