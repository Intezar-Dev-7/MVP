import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gitgossip/core/widgets/custom_snack_bar.dart';
import 'package:gitgossip/features/authentication/services/auth_services.dart';
import 'package:gitgossip/features/authentication/services/google_auth_service.dart';
import 'package:gitgossip/features/authentication/widgets/signin_buttons.dart';

/// Screen that allows the user to sign in using Google or GitHub.
/// Currently, only Google sign-in is implemented.
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GoogleAuthServices googleAuthServices = GoogleAuthServices();
  final AuthServices authServices = AuthServices();

  /// Tracks whether a sign-in process is ongoing
  bool _isLoading = false;

  // signin_screen.dart
  Future<void> _login() async {
    if (!mounted) return;

    setState(() => _isLoading = true);
    try {
      // Step 1: Google Sign-In
      final token = await googleAuthServices.signInWithGoogleAndGetToken();
      // if (!mounted) return; //new temp change1 by aditya

      if (token == null) {
        showAnimatedSnackBar(context, "Google sign-in failed or cancelled");
        return;
      }

      // if (!mounted) return; //new temp change2 by aditya

      // Step 2: Save to Backend
      try {
        await authServices.saveUserToBackend(token: token);
        if (!mounted) return;
        showAnimatedSnackBar(context, "Logged in successfully");
      } catch (backendError) {
        if (!mounted) return;
        // Specific error for backend failure
        showAnimatedSnackBar(
          context,
          "Failed to save user to database: ${backendError.toString()}",
        );
        // Optionally sign out from Google if backend fails
        await googleAuthServices.signOut();
      }
    } catch (e) {
      if (!mounted) return;
      // This catches Google sign-in errors
      showAnimatedSnackBar(context, "Sign-in error: $e");
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title
                const Text(
                  'Sign in to continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                // Subtitle
                const Text(
                  'Choose your preferred sign-in method',
                  style: TextStyle(color: Colors.white70),
                ),

                const SizedBox(height: 32),

                // Google sign-in button
                SignInButton(
                  icon: FontAwesomeIcons.google,
                  label: _isLoading ? 'Signing in...' : 'Sign in with Google',
                  onPressed: _isLoading
                      ? null
                      : _login, // disable during loading
                ),

                const SizedBox(height: 16),

                // GitHub sign-in button (disabled for now)
                SignInButton(
                  icon: FontAwesomeIcons.github,
                  label: 'Sign in with GitHub',
                  onPressed: null, // disabled
                ),

                const SizedBox(height: 40),

                // Optional: Loading indicator below buttons
                if (_isLoading)
                  const CircularProgressIndicator(color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
