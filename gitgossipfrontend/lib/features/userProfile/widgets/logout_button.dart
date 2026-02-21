import 'package:flutter/material.dart';
import 'package:gitgossip/core/widgets/custom_snack_bar.dart';
import 'package:gitgossip/features/authentication/screens/signin_screen.dart';
import 'package:gitgossip/features/authentication/services/google_auth_service.dart';

class logoutButton extends StatelessWidget {
  const logoutButton({
    super.key,
    required GoogleAuthServices googleAuthServices,
  }) : _googleAuthServices = googleAuthServices;

  final GoogleAuthServices _googleAuthServices;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          await _googleAuthServices.signOut();

          // Navigate to SignInScreen and remove all routes
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const SignInScreen()),
            (route) => false,
          );
          showAnimatedSnackBar(context, "Logged out successfully");
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Logout',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
