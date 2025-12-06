import 'package:firebase_auth/firebase_auth.dart';
import 'package:gitgossip/core/config/api.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // -------------------------------------------------
  // SIGN IN WITH GOOGLE
  // -------------------------------------------------
  Future<void> signInWithGoogle() async {
    // Step 1: Google Sign In
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Step 2: Firebase Sign In
    UserCredential userCredential = await _auth.signInWithCredential(
      credential,
    );
    User? user = userCredential.user;
    if (user == null) throw Exception("User is null");

    // Step 3: Firebase Token
    String? token = await user.getIdToken();

    // Step 4: Send token to backend
    final response = await http.post(
      Uri.parse("$baseUrl/auth/saveUser"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      print("User saved to MongoDB");
    } else {
      print("Backend Error: ${response.body}");
      throw Exception("Failed saving user");
    }
  }

  // -------------------------------------------------
  // LOGOUT FROM GOOGLE + FIREBASE
  // -------------------------------------------------
  Future<void> signOutFromGoogle() async {
    try {
      // Sign out from Google
      await _googleSignIn.signOut();

      // Sign out from Firebase
      await _auth.signOut();

      print("User logged out successfully ✓");
    } catch (e) {
      print("Logout Error: $e");
      throw Exception("Failed to log out");
    }
  }

  // Optional helper → Check if user logged in
  // User? get currentUser => _auth.currentUser;
}
