import 'package:flutter/material.dart';
import 'package:gitgossip/features/DiscoverUsers/screens/discovers_screen.dart';
import 'package:gitgossip/features/Home/screens/feed_screen.dart';
import 'package:gitgossip/features/chat/screens/chat_screen.dart';
import 'package:gitgossip/features/post/screens/create_post_screen.dart';
import 'package:gitgossip/features/userProfile/screens/user_profile.dart';
import 'package:provider/provider.dart';
import '../controllers/nav_controller.dart';
import '../widgets/bottom_nav_bar.dart';

class MainNavScreen extends StatelessWidget {
  const MainNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navController = Provider.of<NavController>(context);

    final List<Widget> pages = [
      const FeedScreen(),
      const DiscoverScreen(),
      const SizedBox.shrink(),
      const ChatScreen(),
      const UserProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true, // Make body extend behind the nav bar
      body: pages[navController.currentIndex],

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24), // Add padding to float
        child: const BottomNavBar(),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreatePostScreen()),
          );
        },
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(colors: [Colors.green, Colors.blue]),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.5),
                blurRadius: 20,
                offset: const Offset(0, 5),
              )
            ]
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 28),
        ),
      ),
    );
  }
}
