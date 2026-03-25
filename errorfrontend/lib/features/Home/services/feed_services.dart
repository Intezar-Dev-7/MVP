import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gitgossip/core/config/api.dart';
import '../models/feed_model.dart';

class FeedServices {
  Future<List<FeedPost>> fetchFeedPosts() async {
    final user = FirebaseAuth.instance.currentUser;
    final token = await user!.getIdToken();

    final response = await http.get(
      Uri.parse("$baseUrl/feed/fetchPostsForFeed"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.map((e) => FeedPost.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load feed");
    }
  }
}
