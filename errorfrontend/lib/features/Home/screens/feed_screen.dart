import 'package:flutter/material.dart';
import '../services/feed_services.dart';
import '../models/feed_model.dart';
import '../widgets/feed_post_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final FeedServices _feedServices = FeedServices();
  late Future<List<FeedPost>> _feedPosts;

  @override
  void initState() {
    super.initState();
    _feedPosts = _feedServices.fetchFeedPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Feed"),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: FutureBuilder<List<FeedPost>>(
        future: _feedPosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Error loading feed",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final posts = snapshot.data ?? [];

          if (posts.isEmpty) {
            return const Center(
              child: Text(
                "No posts yet",
                style: TextStyle(color: Colors.white70),
              ),
            );
          }

          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              return FeedPostCard(post: posts[index]);
            },
          );
        },
      ),
    );
  }
}
