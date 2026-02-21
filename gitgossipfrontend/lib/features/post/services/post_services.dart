import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:gitgossip/core/config/api.dart';
import 'package:gitgossip/features/post/models/post_model.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

// Service files have ONLY two jobs

// Return data (success path)

// Throw errors (failure path)
class PostServices {
  Future<void> createPost({
    required String title,
    required String description,
    String? githubUrl,
    String? liveDemoUrl,
    required List<XFile> images,
  }) async {
    // 1️⃣ Get Firebase ID Token
    final token = await FirebaseAuth.instance.currentUser!.getIdToken();

    // 2️⃣ Upload images to backend (Cloudinary handled there)
    var request = http.MultipartRequest(
      "POST",
      Uri.parse("$baseUrl/posts/createNewPost"),
    );

    request.headers['Authorization'] = "Bearer $token";

    request.fields['title'] = title;
    request.fields['postDescription'] = description;
    if (githubUrl != null) request.fields['githubUrl'] = githubUrl;
    if (liveDemoUrl != null) request.fields['liveDemoUrl'] = liveDemoUrl;

    // ADD IMAGES
    for (var img in images) {
      request.files.add(await http.MultipartFile.fromPath("images", img.path));
    }

    final streamed = await request.send();
    final response = await http.Response.fromStream(streamed);
    if (response.statusCode != 201) {
      throw Exception("Failed to create post");
    }
  }

  // Fetch user post
  Future<List<PostModel>> fetchUsersPosts() async {
    final token = await FirebaseAuth.instance.currentUser!.getIdToken();

    final response = await http.get(
      Uri.parse("$baseUrl/posts/getUserPosts"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode != 200) {
      throw Exception("Failed to fetch posts");
    }

    final List<dynamic> data = jsonDecode(response.body);
    return data.map((e) => PostModel.fromJson(e)).toList();
  }
}
