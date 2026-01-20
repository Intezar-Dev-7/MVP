import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gitgossip/core/config/api.dart';
import 'package:gitgossip/core/widgets/custom_snack_bar.dart';
import 'package:gitgossip/features/userProfile/models/social_links_model.dart';
import 'package:gitgossip/features/userProfile/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

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

    required BuildContext context,
  }) async {
    try {
      final firebaseUser = FirebaseAuth.instance.currentUser;

      if (firebaseUser == null) {
        showAnimatedSnackBar(context, "User Not Logged In");
        return;
      }

      final token = await firebaseUser.getIdToken();

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

      // IMAGE
      if (profilePic != null) {
        request.files.add(
          await http.MultipartFile.fromPath('profilePic', profilePic.path),
        );
      }

      final response = await request.send();

      if (response.statusCode != 200 && response.statusCode != 201) {
        showAnimatedSnackBar(context, "Unable to update profile");
      } else {
        showAnimatedSnackBar(context, "User Profile Updated Successfully");
      }
    } catch (e) {
      showAnimatedSnackBar(context, e.toString());
      rethrow;
    }
  }

  // Fetch user details
  Future<UserModel?> getMyProfileDetails({
    required BuildContext context,
  }) async {
    try {
      final firebaseUser = FirebaseAuth.instance.currentUser;

      if (firebaseUser == null) return null;

      final token = await firebaseUser.getIdToken();

      final res = await http.get(
        Uri.parse('$baseUrl/user/getUserDetails'),
        headers: {"Authorization": "Bearer $token"},
      );

      if (res.statusCode != 200) {
        showAnimatedSnackBar(context, "Failed to fetch profile");
        return null;
      }

      final data = jsonDecode(res.body);
      return UserModel.fromJson(data["user"]);
    } catch (e) {
      showAnimatedSnackBar(context, e.toString());
      return null;
    }
  }
}
