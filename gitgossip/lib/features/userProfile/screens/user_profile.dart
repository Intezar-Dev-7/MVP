import 'package:flutter/material.dart';
import 'package:gitgossip/features/userProfile/screens/edit_profile_screen.dart';
import 'package:gitgossip/features/userProfile/widgets/profile_header.dart';
import 'package:gitgossip/features/userProfile/widgets/project_section.dart';
import 'package:gitgossip/features/userProfile/widgets/social_button.dart';
import 'package:gitgossip/features/userProfile/widgets/tech_stack_section.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  void _navigateToEditProfile(BuildContext context) {
    // Navigate to edit profile screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfileScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Profile',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            ProfileHeader(onEditPressed: () => _navigateToEditProfile(context)),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Full-stack developer building modern web apps. Open source enthusiast. Always learning something new.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  SocialButton(icon: Icons.code, label: 'GitHub'),
                  SizedBox(width: 12),
                  SocialButton(icon: Icons.tag, label: 'Twitter'),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const TechStackSection(),
            const SizedBox(height: 32),
            const ProjectsSection(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
