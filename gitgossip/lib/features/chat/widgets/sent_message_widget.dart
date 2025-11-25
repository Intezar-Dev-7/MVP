import 'package:flutter/material.dart';

class SentMessage extends StatelessWidget {
  final String time;
  final String text;
  final bool isDelivered;

  const SentMessage({
    super.key,
    required this.time,
    required this.text,
    this.isDelivered = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.85,
          ),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF005C4B),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              time,
              style: const TextStyle(color: Colors.white38, fontSize: 12),
            ),
            const SizedBox(width: 4),
            if (isDelivered)
              const Icon(Icons.done_all, size: 16, color: Color(0xFF53BDEB)),
          ],
        ),
      ],
    );
  }
}
