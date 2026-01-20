import 'package:flutter/material.dart';
import 'package:gitgossip/core/config/api.dart';
import 'package:gitgossip/core/widgets/custom_snack_bar.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  Future<void> saveUserToBackend({
    required BuildContext context,
    String? token,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/saveUser"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        showAnimatedSnackBar(context, "Logged In Successfully");
      } else {
        print("BACKEND RESPONSE ${response.body}");
        showAnimatedSnackBar(context, "Something Went Wrong");
      }
    } catch (e) {
      print("server error $e");
    }
  }
}
