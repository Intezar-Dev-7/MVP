import 'package:flutter/material.dart';
import 'package:gitgossip/features/DiscoverUsers/model/discover_user_model.dart';
import 'package:gitgossip/features/DiscoverUsers/widgets/tech_stack_chip_widget.dart';
import 'package:gitgossip/features/chat/screens/message_screen.dart';

class DeveloperCard extends StatelessWidget {
  final DiscoverUser user;

  const DeveloperCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF232325),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 TOP ROW
          Row(
            children: [
              /// Avatar
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[800],
                backgroundImage: user.profilePic.isNotEmpty
                    ? NetworkImage(user.profilePic)
                    : null,
                child: user.profilePic.isEmpty
                    ? const Icon(Icons.person, color: Colors.white54)
                    : null,
              ),

              const SizedBox(width: 10),

              /// Name + Username
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.fullName.isNotEmpty ? user.fullName : "Unknown",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),

                  if (user.username != null && user.username!.isNotEmpty)
                    Text(
                      "@${user.username}",
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// 🔹 BIO (safe handling)
          if (user.userBio != null && user.userBio!.isNotEmpty)
            Text(
              user.userBio!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),

          const SizedBox(height: 12),

          /// 🔹 TECH STACK
          if (user.techStack.isNotEmpty)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: user.techStack
                  .take(4)
                  .map((tech) => TechStackChip(tech: tech))
                  .toList(),
            ),

          const SizedBox(height: 14),

          /// 🔹 CHAT BUTTON
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MessageScreen(
                      receiverId: "",
                      conversationId: user.id,
                      receiverName: user.fullName,
                      receiverAvatar: user.profilePic,
                    ),
                  ),
                );
              },
              child: const Text(
                'Chat',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
