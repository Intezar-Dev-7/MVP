import 'package:flutter/material.dart';

class CodeSnippet extends StatelessWidget {
  final String language;
  final String code;

  const CodeSnippet({super.key, required this.language, required this.code});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: const BoxDecoration(
            color: Color(0xFF0D1418),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.code, color: Color(0xFF00A884), size: 16),
                  const SizedBox(width: 8),
                  Text(
                    language,
                    style: const TextStyle(
                      color: Color(0xFF00A884),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const Icon(Icons.content_copy, color: Colors.white60, size: 18),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Color(0xFF0A0F13),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: Text(
            code,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              fontFamily: 'monospace',
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
