import 'package:flutter/material.dart';

class ReceivedMessage extends StatelessWidget {
  final String time;
  final Widget child;

  const ReceivedMessage({super.key, required this.time, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.85,
            ),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1F2C33),
              borderRadius: BorderRadius.circular(8),
            ),
            child: child,
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: const TextStyle(color: Colors.white38, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
