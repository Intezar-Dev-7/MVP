import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthServices {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email', 'profile']);

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // ---------------------------
  // SIGN IN WITH GOOGLE
  // ---------------------------
  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Step 1: Pick Google account
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null; // user cancelled

      // Step 2: Get auth details from Google
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Step 3: Convert Google token → Firebase credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Step 4: Sign in to Firebase
      return await _firebaseAuth.signInWithCredential(credential);
    } catch (e) {
      print("Google Sign-in Error: $e");
      return null;
    }
  }

  // ---------------------------
  // SIGN OUT FROM GOOGLE
  // ---------------------------
  Future<bool> signOutFromGoogle() async {
    try {
      await _googleSignIn.signOut(); // sign out Google
      await _firebaseAuth.signOut(); // sign out Firebase
      return true;
    } catch (e) {
      print("Sign out error: $e");
      return false;
    }
  }
}
