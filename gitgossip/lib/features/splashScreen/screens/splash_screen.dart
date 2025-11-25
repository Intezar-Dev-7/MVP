import 'package:flutter/material.dart';
import 'dart:async';

import 'package:gitgossip/features/authentication/screens/signin_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Color(0xFF17c1c1); // Use the teal accent from screenshot

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: themeColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: themeColor.withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Icon(Icons.code, color: Colors.white, size: 48),
            ),
            const SizedBox(height: 32),
            const Text(
              'GitGossip',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.2,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.ac_unit,
                  color: themeColor,
                  size: 16,
                ), // Replace with yours if you want
                const SizedBox(width: 6),
                Text(
                  'Code. Grow. Connect.',
                  style: TextStyle(
                    color: themeColor,
                    fontSize: 16,
                    fontFamily: 'monospace',
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(width: 6),
                Icon(
                  Icons.ac_unit,
                  color: themeColor,
                  size: 16,
                ), // Replace with yours if you want
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _dot(themeColor),
                const SizedBox(width: 6),
                _dot(themeColor),
                const SizedBox(width: 6),
                _dot(themeColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _dot(Color color) => Container(
    width: 8,
    height: 8,
    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
  );
}
