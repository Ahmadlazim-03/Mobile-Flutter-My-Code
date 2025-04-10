// lib/widgets/custom_bottom_nav_bar.dart
import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';
import '../screens/profile/profile_screen.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final BuildContext context;
  final bool isDarkMode;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.context,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        // Handle navigation based on the selected index
        if (index == 3 && currentIndex != 3) {
          // Navigate to Profile screen if not already there
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()),
          );
        } else if (index == 0 && currentIndex != 0) {
          // Navigate to Home screen if not already there
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false,
          );
        }
        // Add other navigation options as needed
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      selectedItemColor: const Color(0xFF54408C),
      unselectedItemColor: isDarkMode ? Colors.grey.shade500 : Colors.grey,
      showUnselectedLabels: true,
      elevation: 8,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category_outlined),
          label: 'Challenges',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          label: 'Forum',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );
  }
}