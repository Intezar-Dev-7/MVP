import 'package:flutter/material.dart';
import 'package:gitgossip/features/authentication/widgets/signin_buttons.dart';
import 'package:gitgossip/features/bottom_nav/screens/main_nav_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

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
                  icon: Icons
                      .g_mobiledata, // You can use another icon if you prefer
                  label: 'Sign in with Google',
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MainNavScreen()),
                    );
                  },
                ),
                const SizedBox(height: 16),
                SignInButton(
                  icon: Icons
                      .code, // You can use Icons.adb or another icon for GitHub
                  label: 'Sign in with GitHub',
                  onPressed: () {},
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
