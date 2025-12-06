import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gitgossip/features/authentication/services/authServices.dart';
import 'package:gitgossip/features/authentication/services/google_auth_service.dart';

import 'package:gitgossip/features/authentication/widgets/signin_buttons.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GoogleAuthServices _googleAuth = GoogleAuthServices();
  final AuthServices _authServices = AuthServices();

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
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Choose your preferred sign-in method',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                SignInButton(
                  icon: FontAwesomeIcons.google,
                  label: 'Sign in with Google',
                  onPressed: () async {
                    print("Google button tapped");
                    await _authServices.signInWithGoogle();
                  },
                ),
                const SizedBox(height: 16),
                SignInButton(
                  icon: FontAwesomeIcons
                      .github, // You can use Icons.adb or another icon for GitHub
                  label: 'Sign in with GitHub',
                  onPressed: () async {},
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
