import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gitgossip/core/config/api.dart';
import 'package:gitgossip/features/DiscoverUsers/model/discover_user_model.dart';
import 'package:http/http.dart' as http;

class DiscoverServices {
  Future<List<DiscoverUser>> fetchUsersForDiscoverScreen() async {
    final user = FirebaseAuth.instance.currentUser;
    final idToken = await user!.getIdToken();
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/discover/fetchUsersForDiscoverScreen"),
        headers: {"Authorization": "Bearer $idToken"},
      );

      /// ✅ Check status code
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        /// ✅ Convert JSON → List<UserModel>
        return data.map((userJson) => DiscoverUser.fromJson(userJson)).toList();
      } else {
        throw Exception("Failed to load users");
      }
    } catch (e) {
      throw Exception("Error fetching users: $e");
    }
  }
}
