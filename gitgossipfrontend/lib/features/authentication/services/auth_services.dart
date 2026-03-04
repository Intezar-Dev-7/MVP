import 'package:gitgossip/core/config/api.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  Future<void> saveUserToBackend({String? token}) async {
    try {
      print("🔥 Google sign-in success");
      print("🔥 About to call saveUser API");
      print("📍 BASE_URL: $baseUrl"); //new temp change by aditya
      print("📍 FULL_URL: $baseUrl/auth/saveUser"); //new temp change by aditya
      print("📍 TOKEN_PROVIDED: ${token != null ? 'YES (${token.substring(0, 20)}...)' : 'NO'}"); //new temp change by aditya

      print("🚀 [BEFORE HTTP.POST] Initiating POST request..."); //new temp change by aditya
      final response = await http.post(
        Uri.parse("$baseUrl/auth/saveUser"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      print("🚀 [AFTER HTTP.POST] Response received! Status: ${response.statusCode}"); //new temp change by aditya
      
      if (response.statusCode == 200) {
        print("✅ User successfully saved to MongoDB"); //new temp change by aditya
        return;
      } else {
        print("❌ BACKEND_ERROR: Status ${response.statusCode}"); //new temp change by aditya
        print("❌ BACKEND_RESPONSE: ${response.body}"); //new temp change by aditya
        throw Exception("Failed to save user");
      }
    } catch (e) {
      print("💥 Network/Server error: $e");
      // CRITICAL: Remove silent catch - let SignInScreen handle
      rethrow; // Pass error to UI
    }
  }
}
