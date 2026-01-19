import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gitgossip/features/authentication/services/google_auth_service.dart';

import 'package:gitgossip/features/authentication/widgets/signin_buttons.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GoogleAuthServices _googleAuthServices = GoogleAuthServices();
  bool _isSigningIn = false;

  Future<void> _handleGoogleSignIn() async {
    if (_isSigningIn) return;

    _isSigningIn = true;
    try {
      await _googleAuthServices.signInWithGoogle();
    } catch (e, s) {
      debugPrint("Google Sign In failed");
      debugPrint("$s");
    } finally {
      _isSigningIn = false;
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
                const Text(
                  'Sign in to continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Choose your preferred sign-in method',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 32),

                SignInButton(
                  icon: FontAwesomeIcons.google,
                  label: 'Sign in with Google',
                  onPressed: _handleGoogleSignIn,
                ),

                const SizedBox(height: 16),

                SignInButton(
                  icon: FontAwesomeIcons.github,
                  label: 'Sign in with GitHub',
                  onPressed: () {}, // later
                ),

                const SizedBox(height: 120),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
