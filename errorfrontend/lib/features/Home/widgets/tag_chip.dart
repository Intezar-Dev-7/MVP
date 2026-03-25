import 'package:flutter/material.dart';

class TagChip extends StatelessWidget {
  final String tag;
  const TagChip({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.green[900],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: Colors.greenAccent,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
