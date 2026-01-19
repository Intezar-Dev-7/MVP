import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:gitgossip/features/userProfile/screens/edit_profile_screen.dart';
import 'package:gitgossip/features/userProfile/widgets/profile_header.dart';
import 'package:gitgossip/features/userProfile/widgets/project_section.dart';
import 'package:gitgossip/features/userProfile/widgets/social_button.dart';
import 'package:gitgossip/features/userProfile/widgets/tech_stack_section.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  void _navigateToEditProfile(BuildContext context) {
    // Navigate to edit profile screen
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
          PopupMenuButton(
            icon: const Icon(Icons.more_vert, color: Colors.white70),
            color: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(color: Colors.grey, width: 1),
            ),
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: 'EDIT',
                height: 48,
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditProfileScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Edit Profile",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  const SocialButton(
                    icon: FontAwesomeIcons.github,
                    label: 'GitHub',
                  ),
                  const SizedBox(width: 12),
                  SocialButton(
                    icon: FontAwesomeIcons.linkedin,
                    label: 'Twitter',
                  ),
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
