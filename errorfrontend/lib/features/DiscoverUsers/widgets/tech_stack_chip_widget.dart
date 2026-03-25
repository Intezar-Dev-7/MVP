import 'package:flutter/material.dart';

class TechStackChip extends StatelessWidget {
  final String tech;
  const TechStackChip({super.key, required this.tech});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.green[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        tech,
        style: TextStyle(
          color: Colors.greenAccent,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
