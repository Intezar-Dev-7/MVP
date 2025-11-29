import 'package:flutter/material.dart';
import '../widgets/notification_tile.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF1F2C33),
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        children: const [
          SizedBox(height: 16),
          NotificationTile(
            icon: Icons.person_add_alt_1,
            iconColor: Colors.blue,
            title: 'New Follower',
            message: 'John Doe started following you.',
            time: '15m ago',
          ),
          NotificationTile(
            icon: Icons.comment,
            iconColor: Colors.green,
            title: 'New Comment',
            message: 'Jane Smith commented on your post.',
            time: '1h ago',
          ),
          NotificationTile(
            icon: Icons.favorite,
            iconColor: Colors.red,
            title: 'New Like',
            message: 'Someone liked your post.',
            time: '3h ago',
          ),
          NotificationTile(
            icon: Icons.repeat,
            iconColor: Colors.purple,
            title: 'New Repost',
            message: 'Your post was reposted.',
            time: '1d ago',
          ),
          NotificationTile(
            icon: Icons.security,
            iconColor: Colors.orange,
            title: 'Security Alert',
            message: 'Your password was recently changed.',
            time: '2d ago',
          ),
        ],
      ),
    );
  }
}
