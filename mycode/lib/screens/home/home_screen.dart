// lib/screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:mycode/screens/challenges/all_challenge_screen.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/custom_buttom_nav_bar.dart';
import 'programming_screen.dart';
import 'course_screen.dart';
import 'notification_screen.dart';
import 'training_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentOfferPage = 0;
  final PageController _offerPageController = PageController();
  
  @override
  void dispose() {
    _offerPageController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    // Get the theme provider from the context
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    
    return Scaffold(
      backgroundColor: isDarkMode ? const Color(0xFF121212) : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Custom App Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Greeting and title
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello, Developer!',
                          style: TextStyle(
                            fontSize: 14,
                            color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Find Your Course',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Action buttons
                  Row(
                    children: [
                      // Search button
                      _buildActionButton(
                        icon: Icons.search,
                        onTap: () {
                          // Show search dialog
                        },
                        isDarkMode: isDarkMode,
                      ),
                      
                      const SizedBox(width: 12),
                      
                      // Theme toggle button
                      _buildActionButton(
                        icon: isDarkMode ? Icons.light_mode : Icons.dark_mode,
                        onTap: () {
                          themeProvider.toggleTheme();
                        },
                        isDarkMode: isDarkMode,
                      ),
                      
                      const SizedBox(width: 12),
                      
                      // Notification button
                      _buildActionButton(
                        icon: Icons.notifications_outlined,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NotificationScreen(),
                            ),
                          );
                        },
                        isDarkMode: isDarkMode,
                        showBadge: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Main Content
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 16),
                  
                  // Special offer banner
                  _buildSpecialOfferBanner(isDarkMode),
                  
                  const SizedBox(height: 24),
                  
                  // Categories section
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildCategoriesList(isDarkMode),
                  
                  const SizedBox(height: 24),
                  
                  // Top of Week section
                  _buildSectionHeader('Top Courses This Week', onSeeAllPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CourseScreen()),
                    );
                  }, isDarkMode: isDarkMode),
                  const SizedBox(height: 16),
                  _buildBooksList(isDarkMode),
                  
                  const SizedBox(height: 24),
                  
                  // Programming Languages section
                  _buildSectionHeader('Programming Languages', onSeeAllPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProgrammingScreen()),
                    );
                  }, isDarkMode: isDarkMode),
                  const SizedBox(height: 16),
                  _buildVendorsList(isDarkMode),
                  
                  const SizedBox(height: 24),
                  
                  // Trending Challenges section
                  _buildSectionHeader('Trending Challenges', onSeeAllPressed: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AllChallengeScreen()),
                    );
                  }, isDarkMode: isDarkMode),
                  const SizedBox(height: 16),
                  _buildChallengesList(isDarkMode),
                  
                  // Add extra padding at the bottom
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0, // Home screen is index 0
        context: context,
        isDarkMode: isDarkMode,
      ),
    );
  }
  
  Widget _buildActionButton({
    required IconData icon,
    required VoidCallback onTap,
    required bool isDarkMode,
    bool showBadge = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(14),
              boxShadow: isDarkMode
                  ? []
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
            ),
            child: Icon(
              icon,
              color: isDarkMode ? Colors.white : Colors.black,
              size: 22,
            ),
          ),
          if (showBadge)
            Positioned(
              right: 4,
              top: 4,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: const Color(0xFF54408C),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDarkMode ? const Color(0xFF121212) : Colors.white,
                    width: 1.5,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
  
  Widget _buildSpecialOfferBanner(bool isDarkMode) {
    // Define multiple offers with proper typing
    final List<Map<String, dynamic>> offers = [
      {
        'title': 'Laravel Course',
        'subtitle': 'Discount 25%',
        'buttonText': 'Order Now',
        'image': 'assets/images/home/laravel-course.jpg',
        'imageAlt': 'Laravel Course',
        'color': const Color(0xFF54408C),
        'bgColor': const Color(0xFFEFEBFF),
      },
      {
        'title': 'Symfony Course',
        'subtitle': 'Discount 10%',
        'buttonText': 'Order Now',
        'image': 'assets/images/home/symfony-course.png',
        'imageAlt': 'Symfony Course',
        'color': const Color(0xFF1E88E5),
        'bgColor': const Color(0xFFE3F2FD),
      },
      {
        'title': 'Falcon Course',
        'subtitle': 'Discount 30%',
        'buttonText': 'Order Now',
        'image': 'assets/images/home/falcon-course.png',
        'imageAlt': 'Falcon Course',
        'color': const Color(0xFFE53935),
        'bgColor': const Color(0xFFFFEBEE),
      },
    ];
    
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: isDarkMode
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
      ),
      child: Stack(
        children: [
          // PageView for swiping offers
          PageView.builder(
            controller: _offerPageController,
            itemCount: offers.length,
            onPageChanged: (index) {
              setState(() {
                _currentOfferPage = index;
              });
            },
            itemBuilder: (context, index) {
              final offer = offers[index];
              return Container(
                decoration: BoxDecoration(
                  color: isDarkMode ? const Color(0xFF2A2A2A) : (offer['bgColor'] as Color),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      // Left side text and button
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: (offer['color'] as Color).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                offer['subtitle'] as String,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: offer['color'] as Color,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              offer['title'] as String,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: 44,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: offer['color'] as Color,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 24),
                                ),
                                child: Text(
                                  offer['buttonText'] as String,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      // Right side book image
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: (offer['color'] as Color).withOpacity(0.3),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              offer['image'] as String,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Center(
                                    child: Text(
                                      offer['imageAlt'] as String,
                                      style: TextStyle(
                                        color: isDarkMode ? Colors.white54 : Colors.black54,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          
          // Indicator dots
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                offers.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _currentOfferPage == index ? 20 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _currentOfferPage == index
                        ? (offers[_currentOfferPage]['color'] as Color)
                        : (isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300),
                  ),
                ),
              ),
            ),
          ),
          
          // Navigation arrows
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Previous button
                GestureDetector(
                  onTap: () {
                    if (_currentOfferPage > 0) {
                      _offerPageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.black.withOpacity(0.3) : Colors.white.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_rounded,
                      color: isDarkMode ? Colors.white : Colors.black,
                      size: 16,
                    ),
                  ),
                ),
                
                // Next button
                GestureDetector(
                  onTap: () {
                    if (_currentOfferPage < offers.length - 1) {
                      _offerPageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: isDarkMode ? Colors.black.withOpacity(0.3) : Colors.white.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: isDarkMode ? Colors.white : Colors.black,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCategoriesList(bool isDarkMode) {
    final List<Map<String, dynamic>> categories = [
      {
        'name': 'All',
        'icon': Icons.apps,
        'color': const Color(0xFF54408C),
      },
      {
        'name': 'Design',
        'icon': Icons.brush,
        'color': const Color(0xFF1E88E5),
      },
      {
        'name': 'Coding',
        'icon': Icons.code,
        'color': const Color(0xFFE53935),
      },
      {
        'name': 'Marketing',
        'icon': Icons.trending_up,
        'color': const Color(0xFF43A047),
      },
      {
        'name': 'Business',
        'icon': Icons.business,
        'color': const Color(0xFFFF9800),
      },
    ];
    
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = index == 0; // First item is selected by default
          
          return Container(
            width: 80,
            margin: EdgeInsets.only(right: index < categories.length - 1 ? 16 : 0),
            child: Column(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? (category['color'] as Color)
                        : (isDarkMode ? const Color(0xFF2A2A2A) : Colors.grey.shade100),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: isSelected && !isDarkMode
                        ? [
                            BoxShadow(
                              color: (category['color'] as Color).withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : [],
                  ),
                  child: Icon(
                    category['icon'] as IconData,
                    color: isSelected
                        ? Colors.white
                        : (isDarkMode ? Colors.white : Colors.black),
                    size: 28,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  category['name'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected
                        ? (category['color'] as Color)
                        : (isDarkMode ? Colors.white : Colors.black),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildSectionHeader(String title, {required VoidCallback onSeeAllPressed, required bool isDarkMode}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        TextButton(
          onPressed: onSeeAllPressed,
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF54408C),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: isDarkMode
                ? const Color(0xFF54408C).withOpacity(0.2)
                : const Color(0xFFEFEBFF),
          ),
          child: Row(
            children: [
              const Text(
                'See all',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.arrow_forward_ios,
                size: 12,
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildBooksList(bool isDarkMode) {
    final List<Map<String, dynamic>> books = [
      {
        'title': 'The Kite Runner',
        'author': 'Khaled Hosseini',
        'price': '\$14.99',
        'rating': 4.8,
        'image': 'assets/images/home/course1.jpeg',
        'color': const Color(0xFF54408C),
      },
      {
        'title': 'The Subtle Art of Not Giving a F*ck',
        'author': 'Mark Manson',
        'price': '\$20.99',
        'rating': 4.5,
        'image': 'assets/images/home/course2.jpeg',
        'color': const Color(0xFF1E88E5),
      },
      {
        'title': 'The Art of War',
        'author': 'Sun Tzu',
        'price': '\$14.99',
        'rating': 4.7,
        'image': 'assets/images/home/course3.jpg',
        'color': const Color(0xFFE53935),
      },
      {
        'title': 'The Art of War',
        'author': 'Sun Tzu',
        'price': '\$18.99',
        'rating': 4.6,
        'image': 'assets/images/home/course4.png',
        'color': const Color(0xFF43A047),
      },
    ];
    
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return Container(
            width: 160, // Reduced width to prevent overflow
            margin: EdgeInsets.only(right: index < books.length - 1 ? 16 : 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Book cover with animated container
                Stack(
                  children: [
                    Container(
                      height: 180, // Reduced height to prevent overflow
                      width: 160, // Fixed width
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: isDarkMode
                            ? []
                            : [
                                BoxShadow(
                                  color: (book['color'] as Color).withOpacity(0.2),
                                  blurRadius: 15,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          book['image'] as String,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              decoration: BoxDecoration(
                                color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    book['title'] as String,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isDarkMode ? Colors.white70 : Colors.black87,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    // Rating badge
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isDarkMode ? Colors.black.withOpacity(0.7) : Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min, // Ensure the row takes minimum space
                          children: [
                            const Icon(
                              Icons.star,
                              color: Color(0xFFFFD700),
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              book['rating'].toString(),
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Book title
                Text(
                  book['title'] as String,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                // Author
                Text(
                  book['author'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                // Price
                Text(
                  book['price'] as String,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: book['color'] as Color,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  
  // Update the _buildVendorsList method in HomeScreen
Widget _buildVendorsList(bool isDarkMode) {
  final List<Map<String, dynamic>> vendors = [
    {
      'name': 'HTML',
      'logo': 'assets/images/home/html.png',
      'color': const Color(0xFFE44D26),
      'bgColor': const Color(0xFFFFEBEE),
    },
    {
      'name': 'CSS',
      'logo': 'assets/images/home/css.png',
      'color': const Color(0xFF264DE4),
      'bgColor': const Color(0xFFE3F2FD),
    },
    {
      'name': 'JavaScript',
      'logo': 'assets/images/home/js.png',
      'color': const Color(0xFFF7DF1E),
      'bgColor': const Color(0xFFFFFDE7),
    },
    {
      'name': 'PHP',
      'logo': 'assets/images/home/php.png',
      'color': const Color(0xFF777BB3),
      'bgColor': const Color(0xFFEDE7F6),
    },
    {
      'name': 'Python',
      'logo': 'assets/images/home/python.png',
      'color': const Color(0xFF3776AB),
      'bgColor': const Color(0xFFE1F5FE),
    },
  ];
  
  return SizedBox(
    height: 120,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: vendors.length,
      itemBuilder: (context, index) {
        final vendor = vendors[index];
        return GestureDetector(
          onTap: () {
            // Navigate to the training screen when a language card is clicked
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TrainingScreen(
                  language: vendor['name'] as String,
                  languageColor: vendor['color'] as Color,
                  languageBgColor: vendor['bgColor'] as Color,
                ),
              ),
            );
          },
          child: Container(
            width: 100,
            margin: EdgeInsets.only(right: index < vendors.length - 1 ? 16 : 0),
            decoration: BoxDecoration(
              color: isDarkMode ? const Color(0xFF2A2A2A) : (vendor['bgColor'] as Color),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDarkMode ? Colors.grey.shade800 : Colors.transparent,
              ),
              boxShadow: isDarkMode
                  ? []
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  vendor['logo'] as String,
                  width: 60,
                  height: 60,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: vendor['color'] as Color,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          (vendor['name'] as String).substring(0, 1),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                Text(
                  vendor['name'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

  
 Widget _buildChallengesList(bool isDarkMode) {
  final List<Map<String, dynamic>> challenges = [
    {
      'name': 'Responsive Portfolio with HTML & CSS',
      'category': 'HTML',
      'difficulty': 'Beginner',
      'participants': 1245,
      'image': 'assets/images/home/challenge.png',
      'color': const Color(0xFFE44D26),
    },
    {
      'name': '30-Minute CSS Art Challenge',
      'category': 'CSS',
      'difficulty': 'Intermediate',
      'participants': 876,
      'image': 'assets/images/home/challenge.png',
      'color': const Color(0xFF264DE4),
    },
    {
      'name': 'Build a To-Do App in JavaScript',
      'category': 'JavaScript',
      'difficulty': 'Intermediate',
      'participants': 2134,
      'image': 'assets/images/home/challenge.png',
      'color': const Color(0xFFF7DF1E),
    },
    {
      'name': 'API Fetch & Display with React',
      'category': 'React',
      'difficulty': 'Advanced',
      'participants': 1567,
      'image': 'assets/images/home/challenge.png',
      'color': const Color(0xFF61DAFB),
    },
    {
      'name': 'Create a Calculator in Flutter',
      'category': 'Flutter',
      'difficulty': 'Intermediate',
      'participants': 987,
      'image': 'assets/images/home/challenge.png',
      'color': const Color(0xFF54C5F8),
    },
  ];
  
  return SizedBox(
    height: 130,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: challenges.length,
      itemBuilder: (context, index) {
        final challenge = challenges[index];
        return Container(
          width: 240, // Reduced width to prevent overflow
          margin: EdgeInsets.only(right: index < challenges.length - 1 ? 16 : 0),
          decoration: BoxDecoration(
            color: isDarkMode ? const Color(0xFF2A2A2A) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: isDarkMode
                ? []
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
            border: Border.all(
              color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12), // Reduced padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top section with icon and title
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 40, // Reduced size
                      height: 40, // Reduced size
                      decoration: BoxDecoration(
                        color: (challenge['color'] as Color).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Image.asset(
                          challenge['image'] as String,
                          width: 24, // Reduced size
                          height: 24, // Reduced size
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.code,
                              color: challenge['color'] as Color,
                              size: 20, // Reduced size
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 8), // Reduced spacing
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            challenge['name'] as String,
                            style: TextStyle(
                              fontSize: 14, // Reduced font size
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Wrap(
                            spacing: 4, // Reduced spacing
                            runSpacing: 4, // Added run spacing for wrapping
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), // Reduced padding
                                decoration: BoxDecoration(
                                  color: (challenge['color'] as Color).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8), // Reduced radius
                                ),
                                child: Text(
                                  challenge['category'] as String,
                                  style: TextStyle(
                                    fontSize: 10, // Reduced font size
                                    fontWeight: FontWeight.bold,
                                    color: challenge['color'] as Color,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), // Reduced padding
                                decoration: BoxDecoration(
                                  color: _getDifficultyColor(challenge['difficulty'] as String).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8), // Reduced radius
                                ),
                                child: Text(
                                  challenge['difficulty'] as String,
                                  style: TextStyle(
                                    fontSize: 10, // Reduced font size
                                    fontWeight: FontWeight.bold,
                                    color: _getDifficultyColor(challenge['difficulty'] as String),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                // Removed Spacer and added fixed SizedBox height
                const SizedBox(height: 12), // Reduced space above button
                
                // Bottom section with participants and button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Participants count
                    Flexible(
                      child: Row(
                        mainAxisSize: MainAxisSize.min, // Take minimum space
                        children: [
                          Icon(
                            Icons.people,
                            size: 14, // Reduced size
                            color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                          ),
                          const SizedBox(width: 2), // Reduced spacing
                          Text(
                            '${challenge['participants']}',
                            style: TextStyle(
                              fontSize: 10, // Reduced font size
                              color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    // Join Challenge button
                    SizedBox(
                      height: 30, // Fixed height
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF54408C),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // Reduced radius
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0), // Reduced padding
                        ),
                        child: const Text(
                          'Join Challenge',
                          style: TextStyle(
                            fontSize: 10, // Reduced font size
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
  
  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Beginner':
        return const Color(0xFF43A047);
      case 'Intermediate':
        return const Color(0xFFFFA000);
      case 'Advanced':
        return const Color(0xFFE53935);
      default:
        return const Color(0xFF54408C);
    }
  }
}