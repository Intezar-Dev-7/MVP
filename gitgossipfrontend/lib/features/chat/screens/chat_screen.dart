import 'package:flutter/material.dart';
import 'package:gitgossip/features/chat/widgets/chat_tile_widget.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chats',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
        backgroundColor: Colors.black,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.more_vert, size: 28),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.06),
                borderRadius: BorderRadius.circular(14),
              ),
              child: const TextField(
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search chat & messages...',
                  hintStyle: TextStyle(color: Colors.white54),
                  icon: Icon(Icons.search, color: Colors.white54),
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Chat List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              children: const [
                ChatTile(
                  name: 'Jordan Lee',
                  message: 'Awesome! Also sharing the updated compo...',
                  time: '7:54 PM',
                  avatar: 'https://i.pravatar.cc/150?img=12',
                  online: true,
                ),
                ChatTile(
                  name: 'Frontend Team',
                  message: "Alex: Here's the latest architecture design",
                  time: '5:56 PM',
                  avatar: null,
                  unreadCount: 3,
                ),
                ChatTile(
                  name: 'Sarah Chen',
                  message: "Thanks for the review! I'll push the fixes soon",
                  time: 'Yesterday',
                  avatar: 'https://i.pravatar.cc/150?img=32',
                  online: true,
                ),
                ChatTile(
                  name: 'Backend Guild',
                  message: 'Priya: const handleAuth = async () =>',
                  time: 'Yesterday',
                  avatar: null,
                  unreadCount: 12,
                ),
                ChatTile(
                  name: 'Maya Rodriguez',
                  message: "Perfect! Let's sync tomorrow morning.",
                  time: '2d ago',
                  avatar: 'https://i.pravatar.cc/150?img=55',
                ),
                ChatTile(
                  name: 'DevOps Squad',
                  message: 'Alex: Pipeline is green! 🎉',
                  time: '3d ago',
                  avatar: null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
