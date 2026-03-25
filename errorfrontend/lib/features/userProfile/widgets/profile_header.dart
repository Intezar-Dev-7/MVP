import 'package:flutter/material.dart';
import 'package:gitgossip/features/userProfile/models/user_model.dart';

class ProfileHeader extends StatelessWidget {
  final UserModel user; //changes by aditya
  final VoidCallback onEditPressed;

  const ProfileHeader({
    super.key,
    required this.user,
    required this.onEditPressed,
  });

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
              image: DecorationImage(
                image: NetworkImage(user.profilePic),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.fullName,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '@${user.username ?? ""}', //changes by aditya
                  style: TextStyle(fontSize: 15, color: Colors.white60),
                ),
                const SizedBox(height: 16),
                //                 Row(
                //  children: [
                //   StatColumn(label: 'Followers', value: '1247'),
                //   SizedBox(width: 24),
                //   StatColumn(label: 'Following', value: '342'),
                //   SizedBox(width: 24),
                //   StatColumn(label: 'Posts', value: '89'),
                //  ],
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
