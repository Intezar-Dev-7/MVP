import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final String? avatar;
  final VoidCallback onTap;

  const ChatTile({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    this.avatar,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            // Avatar / Group Icon
            Stack(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.grey.shade800,
                  backgroundImage: avatar != null
                      ? NetworkImage(avatar!)
                      : null,
                  child: avatar == null
                      ? const Icon(Icons.group, color: Colors.white70, size: 28)
                      : null,
                ),
              ],
            ),

            const SizedBox(width: 14),

            // Name & message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white54, fontSize: 14),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            // Time
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  time,
                  style: const TextStyle(color: Colors.white54, fontSize: 13),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
