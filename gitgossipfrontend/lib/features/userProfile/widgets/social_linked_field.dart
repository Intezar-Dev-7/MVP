import 'package:flutter/material.dart';

class SocialLinkField extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String? hintText; // Fixed type
  final TextEditingController controller;
  final Color backgroundColor;
  final TextInputType keyboardType; // new

  const SocialLinkField({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.controller,
    required this.backgroundColor,
    this.hintText,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType, // use keyboardType here
              style: const TextStyle(color: Colors.white70),
              decoration: InputDecoration(
                hintText: hintText, // Use hintText here
                hintStyle: const TextStyle(color: Colors.white38),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
