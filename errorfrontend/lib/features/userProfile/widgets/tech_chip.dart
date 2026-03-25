import 'package:flutter/material.dart';

class TechChip extends StatelessWidget {
  final String label;

  const TechChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF4CAF50), width: 1.5),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFF4CAF50),
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
