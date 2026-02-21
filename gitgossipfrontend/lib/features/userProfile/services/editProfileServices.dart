import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:gitgossip/core/config/api.dart';
import 'package:gitgossip/features/userProfile/models/social_links_model.dart';
import 'package:gitgossip/features/userProfile/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

// Services return data or throw errors. UI decides how to display them.
class Editprofileservices {
  // Function to add or update user Details // Edit user profile
  Future<void> editUserProfile({
    required String fullName,
    required String username,

    required String userPhoneNumber,
    required String userBio,
    required XFile? profilePic,

    required List<String?> techStack,
    required SocialLinks? socialLinks,
  }) async {
    try {
      print("📝 Starting profile update...");
      final firebaseUser = FirebaseAuth.instance.currentUser;

      if (firebaseUser == null) {
        throw Exception("User not logged in");
      }

      final token = await firebaseUser.getIdToken();
      print("✅ Token obtained");
      final request = http.MultipartRequest(
        'PATCH',
        Uri.parse('$baseUrl/user/updateUserDetails'),
      );

      request.headers['Authorization'] = 'Bearer $token';

      // TEXT DATA
      request.fields['fullName'] = fullName;
      request.fields['username'] = username;
      request.fields['userPhoneNumber'] = userPhoneNumber;
      request.fields['userBio'] = userBio;
      request.fields['techStack'] = jsonEncode(
        techStack.whereType<String>().toList(),
      );
      request.fields['socialLinks'] = jsonEncode(socialLinks?.toJson());
      print("📦 Request fields: ${request.fields}");
      // IMAGE
      if (profilePic != null) {
        request.files.add(
          await http.MultipartFile.fromPath('profilePic', profilePic.path),
        );
      }
      print("🚀 Sending request to: $baseUrl/user/updateUserDetails");
      final response = await request.send();
      // ✅ FIXED: Read the response body properly
      final responseBody = await response.stream.bytesToString();

      print("📡 Response status: ${response.statusCode}");
      print("📡 Response body: $responseBody");

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception("Unable to update profile: $responseBody");
      }

      print("✅ Updated successfully");
    } catch (e) {
      print("$e");
      rethrow;
    }
  }

  // Fetch user details
  Future<UserModel> getMyProfileDetails() async {
    print("1");
    final firebaseUser = FirebaseAuth.instance.currentUser;

    if (firebaseUser == null) throw Exception("User not logged in");

    final token = await firebaseUser.getIdToken();

    final response = await http.get(
      Uri.parse('$baseUrl/user/getUserDetails'),
      headers: {"Authorization": "Bearer $token"},
    );

    print("PROFILE RESPONSE => ${response.body}");
    if (response.statusCode != 200) {
      throw Exception("Failed to fetch profile");
    }
    final data = jsonDecode(response.body);

    return UserModel.fromJson(data["data"]);
  }
}
