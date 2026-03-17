import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:gitgossip/features/userProfile/screens/edit_profile_screen.dart';
import 'package:gitgossip/features/userProfile/widgets/profile_header.dart';
import 'package:gitgossip/features/userProfile/widgets/user_posts_section.dart';
import 'package:gitgossip/features/userProfile/widgets/social_button.dart';
import 'package:gitgossip/features/userProfile/widgets/tech_stack_section.dart';
import 'package:gitgossip/features/userProfile/models/user_model.dart';
import 'package:gitgossip/features/userProfile/services/editProfileServices.dart';

//making stateful widget to async data to ensure profile screen is dynamic - changes by aditya
class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late Future<UserModel> _profileFuture;

  @override
  void initState() {
    super.initState();
    _profileFuture = Editprofileservices().getMyProfileDetails();
  }

  void _navigateToEditProfile(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditProfileScreen()),
    );

    // refresh profile after editing
    setState(() {
      _profileFuture = Editprofileservices().getMyProfileDetails();
    });
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
                      // onPressed: () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => EditProfileScreen(),
                      //     ),
                      //   );
                      // },
                      onPressed: () =>
                          _navigateToEditProfile(context), // change by aditya
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
      body: FutureBuilder<UserModel>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Failed to load profile",
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final user = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                ProfileHeader(
                  user: user,
                  onEditPressed: () => _navigateToEditProfile(context),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    user.userBio ?? "No bio yet",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // new changes by aditya to make social link section dynamic
                if (user.socialLinks != null &&
                    (user.socialLinks!.github?.isNotEmpty == true ||
                        user.socialLinks!.linkedin?.isNotEmpty == true ||
                        user.socialLinks!.instagram?.isNotEmpty == true ||
                        user.socialLinks!.portfolio?.isNotEmpty == true))
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        if (user.socialLinks!.github?.isNotEmpty == true)
                          const SocialButton(
                            icon: FontAwesomeIcons.github,
                            label: 'GitHub',
                          ),

                        if (user.socialLinks!.linkedin?.isNotEmpty == true) ...[
                          const SizedBox(width: 12),
                          const SocialButton(
                            icon: FontAwesomeIcons.linkedin,
                            label: 'LinkedIn',
                          ),
                        ],

                        if (user.socialLinks!.instagram?.isNotEmpty ==
                            true) ...[
                          const SizedBox(width: 12),
                          const SocialButton(
                            icon: FontAwesomeIcons.instagram,
                            label: 'Instagram',
                          ),
                        ],

                        if (user.socialLinks!.portfolio?.isNotEmpty ==
                            true) ...[
                          const SizedBox(width: 12),
                          const SocialButton(
                            icon: FontAwesomeIcons.link,
                            label: 'Portfolio',
                          ),
                        ],
                      ],
                    ),
                  ),
                const SizedBox(height: 32),
                TechStackSection(
                  techStack: user.techStack ?? [],
                ), // dynamic data
                const SizedBox(height: 32),
                const UsersPostSection(),
                const SizedBox(height: 100),
              ],
            ),
          );
        }, //builder
      ),
    );
  }
}
