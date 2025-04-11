import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/challenges/all_challenge_screen.dart';
import '../screens/forum/forum_screen.dart'; // Add this import

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
    // Define colors based on theme
    final primaryColor = const Color(0xFF54408C);
    final backgroundColor = isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
    final inactiveColor = isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400;
    
    return Container(
      height: 70,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: isDarkMode 
                ? Colors.black.withOpacity(0.3) 
                : Colors.grey.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Icons.home_rounded,
            label: 'Home',
            index: 0,
            primaryColor: primaryColor,
            inactiveColor: inactiveColor,
          ),
          _buildNavItem(
            icon: Icons.explore_rounded,
            label: 'Challenges',
            index: 1,
            primaryColor: primaryColor,
            inactiveColor: inactiveColor,
          ),
          _buildCenterNavItem(
            primaryColor: primaryColor,
            backgroundColor: backgroundColor,
          ),
          _buildNavItem(
            icon: Icons.forum_rounded,
            label: 'Forum',
            index: 2,
            primaryColor: primaryColor,
            inactiveColor: inactiveColor,
          ),
          _buildNavItem(
            icon: Icons.person_rounded,
            label: 'Profile',
            index: 3,
            primaryColor: primaryColor,
            inactiveColor: inactiveColor,
          ),
        ],
      ),
    );
  }
  
  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required Color primaryColor,
    required Color inactiveColor,
  }) {
    final isSelected = currentIndex == index;
    
    return InkWell(
      onTap: () => _onItemTapped(index),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected 
              ? primaryColor.withOpacity(0.1) 
              : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? primaryColor : inactiveColor,
              size: isSelected ? 26 : 22,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? primaryColor : inactiveColor,
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCenterNavItem({
    required Color primaryColor,
    required Color backgroundColor,
  }) {
    return GestureDetector(
      onTap: () {
        // Show a dialog or bottom sheet with quick actions
        _showQuickActionsMenu();
      },
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: primaryColor,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              primaryColor,
              primaryColor.withBlue(primaryColor.blue + 20),
            ],
          ),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
  
  void _showQuickActionsMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildQuickAction(
                  icon: Icons.play_circle_fill,
                  label: 'Start Challenge',
                  color: const Color(0xFF54408C),
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to AllChallengeScreen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AllChallengeScreen()),
                    );
                  },
                ),
                _buildQuickAction(
                  icon: Icons.search,
                  label: 'Search',
                  color: const Color(0xFF1E88E5),
                  onTap: () {
                    Navigator.pop(context);
                    // Add search functionality
                  },
                ),
                _buildQuickAction(
                  icon: Icons.forum,
                  label: 'New Post',
                  color: const Color(0xFFE53935),
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to Forum screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ForumScreen()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  
  Widget _buildQuickAction({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: color,
              size: 30,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
  
  void _onItemTapped(int index) {
    if (index == currentIndex) return;
    
    switch (index) {
      case 0:
        // Navigate to Home screen
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false,
        );
        break;
      case 1:
        // Navigate to Challenges screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AllChallengeScreen()),
        );
        break;
      case 2:
        // Navigate to Forum screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ForumScreen()),
        );
        break;
      case 3:
        // Navigate to Profile screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
    }
  }
}