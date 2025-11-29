import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/nav_controller.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final navController = Provider.of<NavController>(context);

    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: const Color(0xFF1F2C33), // Dark color from your chat input
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 25,
            spreadRadius: -5,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          shape: const CircularNotchedRectangle(),
          notchMargin: 8.0,
          child: SizedBox(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navItem(Icons.home_outlined, "Feed", 0, navController),
                _navItem(Icons.explore_outlined, "Discover", 1, navController),
                const SizedBox(width: 40), // The space for the FAB
                _navItem(Icons.chat_bubble_outline, "Chat", 3, navController),
                _navItem(Icons.person_outline, "Profile", 4, navController),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(
    IconData icon,
    String label,
    int index,
    NavController controller,
  ) {
    final bool isSelected = controller.currentIndex == index;
    final Color activeColor = Colors.green.shade400;
    final Color inactiveColor = Colors.grey.shade600;

    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeTab(index),
        behavior: HitTestBehavior.translucent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              icon,
              color: isSelected ? activeColor : inactiveColor,
              size: 26,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? activeColor : inactiveColor,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
