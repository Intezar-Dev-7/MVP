import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gitgossip/core/config/api.dart';
import 'package:gitgossip/core/widgets/custom_snack_bar.dart';
import 'package:gitgossip/features/post/models/post_model.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class PostServices {
  Future<Map<String, dynamic>> createPost({
    required String title,
    required String description,
    String? githubUrl,
    String? liveDemoUrl,
    required List<XFile> images,
  }) async {
    try {
      // 1️⃣ Get Firebase ID Token
      final idToken = await FirebaseAuth.instance.currentUser!.getIdToken();

      // 2️⃣ Upload images to backend (Cloudinary handled there)
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("$baseUrl/posts/createNewPost"),
      );

      request.headers['Authorization'] = "Bearer $idToken";

      request.fields['description'] = description;
      if (githubUrl != null) request.fields['githubUrl'] = githubUrl;
      if (liveDemoUrl != null) request.fields['liveDemoUrl'] = liveDemoUrl;

      // ADD IMAGES
      for (var img in images) {
        request.files.add(
          await http.MultipartFile.fromPath("images", img.path),
        );
      }

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);

      return {"success": response.statusCode == 201, "message": response.body};
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  // Fetch user post
  Future<List<PostModel>> fetchUsersPosts({
    required BuildContext context,
  }) async {
    try {
      final idToken = await FirebaseAuth.instance.currentUser!.getIdToken();

      final response = await http.get(
        Uri.parse("$baseUrl/posts/getUserPosts"),
        headers: {
          "Authorization": "Bearer $idToken",
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => PostModel.fromJson(e)).toList();
      } else {
        showAnimatedSnackBar(
          context,
          "Failed to fetch posts (${response.statusCode})",
        );
        return [];
      }
    } catch (e) {
      showAnimatedSnackBar(context, e.toString());
      return [];
    }
  }
}
