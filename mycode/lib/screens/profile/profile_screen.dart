// lib/screens/profile/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        elevation: 0,
        title: Text(
          'Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const Divider(height: 1),
          // User profile section
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                // User avatar
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.network(
                      'https://i.pravatar.cc/150?img=8',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return CircleAvatar(
                          backgroundColor: Colors.grey.shade300,
                          child: const Icon(
                            Icons.person,
                            size: 40,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // User info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'John Doe',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '(+1) 234 567 890',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                // Logout button
                TextButton(
                  onPressed: () {
                    // Implement logout functionality
                  },
                  child: Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.red.shade400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          
          // Menu items
          Expanded(
            child: ListView(
              children: [
                _buildMenuItem(
                  icon: Icons.person,
                  title: 'My Account',
                  iconColor: const Color(0xFF54408C),
                  isDarkMode: isDarkMode,
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.location_on,
                  title: 'Address',
                  iconColor: const Color(0xFF54408C),
                  isDarkMode: isDarkMode,
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.local_offer,
                  title: 'Offers & Promos',
                  iconColor: const Color(0xFF54408C),
                  isDarkMode: isDarkMode,
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.favorite,
                  title: 'Your Favorites',
                  iconColor: const Color(0xFF54408C),
                  isDarkMode: isDarkMode,
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.receipt_long,
                  title: 'Order History',
                  iconColor: const Color(0xFF54408C),
                  isDarkMode: isDarkMode,
                  onTap: () {},
                ),
                _buildMenuItem(
                  icon: Icons.help,
                  title: 'Help Center',
                  iconColor: const Color(0xFF54408C),
                  isDarkMode: isDarkMode,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context, isDarkMode),
    );
  }
  
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required Color iconColor,
    required bool isDarkMode,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Row(
          children: [
            // Icon container
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            // Menu title
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            // Arrow icon
            Icon(
              Icons.chevron_right,
              color: Colors.grey,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildBottomNavigationBar(BuildContext context, bool isDarkMode) {
  return BottomNavigationBar(
    currentIndex: 3, // Change from 4 to 3 (Profile is the 4th item, index 3)
    onTap: (index) {
      if (index != 3) { // Change from 4 to 3
        // If not the profile tab, navigate to home
        if (index == 0) {
          Navigator.pushReplacementNamed(context, '/home');
        }
        // Add other navigation options as needed
      }
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