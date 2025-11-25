import 'package:flutter/material.dart';
import 'package:gitgossip/features/userProfile/widgets/project_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Projects',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const ProjectCard(
          imageUrl:
              'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?w=800',
          title: 'MobileFirst UI Kit',
          description:
              'Reusable component library for mobile-first applications',
          tags: ['Flutter', 'Dart'],
          stars: 189,
        ),
        const SizedBox(height: 16),
        const ProjectCard(
          imageUrl:
              'https://images.unsplash.com/photo-1542273917363-3b1817f69a2d?w=800',
          title: 'API Gateway Service',
          description:
              'Scalable microservices architecture with Docker and K8s',
          tags: ['NodeJS', 'Docker'],
          stars: 156,
        ),
      ],
    );
  }
}
