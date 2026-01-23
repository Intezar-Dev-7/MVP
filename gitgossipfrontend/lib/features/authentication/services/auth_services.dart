import 'package:gitgossip/core/config/api.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  Future<void> saveUserToBackend({String? token}) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/saveUser"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      if (response.statusCode == 200) {
        print("User successfully saved to MongoDB");
      } else {
        print("BACKEND RESPONSE ${response.body}");
        throw Exception("Failed to save user");
      }
    } catch (e) {
      print("server error $e");
    }
  }
}
