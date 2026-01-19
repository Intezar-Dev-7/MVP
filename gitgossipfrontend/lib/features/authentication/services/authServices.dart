import 'package:gitgossip/core/config/api.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  Future<void> saveUserToBackend(String token) async {
    final response = await http.post(
      Uri.parse("$baseUrl/auth/saveUser"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    print("1");
    if (response.statusCode != 200) {
      throw Exception("Backend error: ${response.body}");
    }
  }
}
