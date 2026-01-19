import 'package:flutter/material.dart';
import 'package:gitgossip/features/notifications/screens/notification_screen.dart';
import 'package:gitgossip/features/post/services/post_services.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final PostServices _postServices = PostServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   actions: [

      //   ],
      // ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Feed',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Notification Button
                  IconButton(
                    icon: const Icon(
                      Icons.notifications,
                      color: Colors.white70,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.builder(
                  // itemCount: feedData.length,
                  itemBuilder: (context, index) {
                    // final post = feedData[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      // child: FeedPostCard(post: post),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
