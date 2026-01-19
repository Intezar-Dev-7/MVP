import 'package:flutter/material.dart';
import 'package:gitgossip/features/userProfile/widgets/stat_column.dart';

class ProfileHeader extends StatelessWidget {
  final VoidCallback onEditPressed;

  const ProfileHeader({super.key, required this.onEditPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: const DecorationImage(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Alex Morgan',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '@alexmorgan',
                  style: TextStyle(fontSize: 15, color: Colors.white60),
                ),
                const SizedBox(height: 16),
                const Row(
                  children: [
                    StatColumn(label: 'Followers', value: '1247'),
                    SizedBox(width: 24),
                    StatColumn(label: 'Following', value: '342'),
                    SizedBox(width: 24),
                    StatColumn(label: 'Posts', value: '89'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
