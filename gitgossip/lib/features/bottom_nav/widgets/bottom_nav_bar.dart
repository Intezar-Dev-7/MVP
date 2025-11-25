import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/nav_controller.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final navController = Provider.of<NavController>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(40),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 20,
                spreadRadius: 5,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: BottomAppBar(
            color: Colors.transparent,
            elevation: 2,
            shape: const CircularNotchedRectangle(),
            notchMargin: 5,
            child: SizedBox(
              height: 65,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _navItem(Icons.home_outlined, "Feed", 0, navController),
                  _navItem(
                    Icons.explore_outlined,
                    "Discover",
                    1,
                    navController,
                  ),
                  const SizedBox(width: 30),
                  _navItem(Icons.chat_bubble_outline, "Chat", 3, navController),
                  _navItem(Icons.person_outline, "Profile", 4, navController),
                ],
              ),
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

    return GestureDetector(
      onTap: () => controller.changeTab(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: isSelected
            ? BoxDecoration(
                color: Colors.green.withOpacity(0.25),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.green : Colors.white70,
              size: 22,
            ),
            // const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.green : Colors.white70,
                fontSize: 11,
              ),
            ),
            if (isSelected)
              Container(
                // margin: const EdgeInsets.only(top: 2),
                height: 4,
                width: 5,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
