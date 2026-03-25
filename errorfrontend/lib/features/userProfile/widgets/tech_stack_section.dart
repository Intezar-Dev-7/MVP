import 'package:flutter/material.dart';
import 'package:gitgossip/features/userProfile/widgets/tech_chip.dart';

class TechStackSection extends StatelessWidget {
  final List<String> techStack;
  const TechStackSection({super.key, required this.techStack});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tech Stack',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: techStack
      .map((tech) => TechChip(label: tech))
      .toList(),
          ),
        ],
      ),
    );
  }
}
