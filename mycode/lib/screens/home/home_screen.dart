// lib/screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/custom_buttom_nav_bar.dart';
import 'programming_screen.dart';
import 'course_screen.dart';
import 'notification_screen.dart';

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
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        elevation: 0,
        title: Text(
          'Home',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.search, 
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          // Theme toggle button
          GestureDetector(
            onTap: () {
              themeProvider.toggleTheme();
            },
            child: Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                isDarkMode ? Icons.light_mode : Icons.dark_mode,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
          ),
          
          // Notification icon - Updated with navigation
          GestureDetector(
            onTap: () {
              // Navigate to the Notification Screen when the bell icon is clicked
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationScreen()),
              );
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.notifications_outlined, 
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                Positioned(
                  right: 22,
                  top: 12,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          const SizedBox(height: 16),
          
          // Special offer banner
          _buildSpecialOfferBanner(isDarkMode),
          
          const SizedBox(height: 24),
          
          // Top of Week section
          _buildSectionHeader('Top Courses This Week', onSeeAllPressed: () {
          // Navigate to the Course Screen when "See all" is clicked
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CourseScreen()),
            );
          }, isDarkMode: isDarkMode),
          const SizedBox(height: 16),
          _buildBooksList(isDarkMode),
          
          const SizedBox(height: 24),
          
          // Programming Languages section - Updated with navigation
          _buildSectionHeader('Programming Languages', onSeeAllPressed: () {
            // Navigate to the Programming Screen when "See all" is clicked
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProgrammingScreen()),
            );
          }, isDarkMode: isDarkMode),
          const SizedBox(height: 16),
          _buildVendorsList(isDarkMode),
          
          const SizedBox(height: 24),
          
          // Authors section
          _buildSectionHeader('Trending Challenges', onSeeAllPressed: () {}, isDarkMode: isDarkMode),
          const SizedBox(height: 16),
          _buildAuthorsList(isDarkMode),
          
          // Add extra padding at the bottom
          const SizedBox(height: 24),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: 0, // Home screen is index 0
        context: context,
        isDarkMode: isDarkMode,
      ),
    );
  }
  
  Widget _buildSpecialOfferBanner(bool isDarkMode) {
    // Define multiple offers
    final offers = [
      {
        'title': 'Laravel Course',
        'subtitle': 'Discount 25%',
        'buttonText': 'Order Now',
        'image': 'assets/images/home/laravel-course.jpg',
        'imageAlt': 'Laravel Course',
        'color': const Color(0xFF54408C),
      },
      {
        'title': 'Symfony Course',
        'subtitle': 'Discount 10%',
        'buttonText': 'Order Now',
        'image': 'assets/images/home/symfony-course.png',
        'imageAlt': 'Symfony Course',
        'color': const Color(0xFF1E88E5),
      },
      {
        'title': 'Falcon Course',
        'subtitle': 'Discount 30%',
        'buttonText': 'Order Now',
        'image': 'assets/images/home/falcon-course.png',
        'imageAlt': 'Falcon Course',
        'color': const Color(0xFFE53935),
      },
    ];
    
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
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
              return Padding(
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
                          Text(
                            offer['title']! as String,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            offer['subtitle']! as String,
                            style: TextStyle(
                              fontSize: 16,
                              color: isDarkMode ? Colors.white70 : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 44,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: offer['color'] as Color,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                              ),
                              child: Text(
                                offer['buttonText']! as String,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
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
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            offer['image']! as String,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                decoration: BoxDecoration(
                                  color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    offer['imageAlt']! as String,
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
                (index) => Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentOfferPage == index
                        ? (offers[_currentOfferPage]['color'] as Color)
                        : (isDarkMode ? Colors.grey.shade700 : Colors.grey.shade300),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSectionHeader(String title, {required VoidCallback onSeeAllPressed, required bool isDarkMode}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        TextButton(
          onPressed: onSeeAllPressed,
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF54408C),
            padding: EdgeInsets.zero,
            minimumSize: const Size(50, 30),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            'See all',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildBooksList(bool isDarkMode) {
    final books = [
      {
        'title': 'The Kite Runner',
        'price': '\$14.99',
        'image': 'assets/images/home/course1.jpeg',
      },
      {
        'title': 'The Subtle Art of Not Giving a F*ck',
        'price': '\$20.99',
        'image': 'assets/images/home/course2.jpeg',
      },
      {
        'title': 'The Art of War',
        'price': '\$14.99',
        'image': 'assets/images/home/course3.jpg',
      },
      {
        'title': 'The Art of War',
        'price': '\$18.99',
        'image': 'assets/images/home/course4.png',
      },
    ];
    
    return SizedBox(
      height: 240,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return Container(
            width: 140,
            margin: EdgeInsets.only(right: index < books.length - 1 ? 16 : 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Book cover
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      book['image']!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Text(
                              book['title']!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: isDarkMode ? Colors.white70 : Colors.black87,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Book title
                Text(
                  book['title']!,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                // Book price
                Text(
                  book['price']!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF54408C),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildVendorsList(bool isDarkMode) {
    final vendors = [
      {
        'name': 'HTML',
        'logo': 'assets/images/home/html.png',
      },
      {
        'name': 'CSS',
        'logo': 'assets/images/home/css.png',
      },
      {
        'name': 'Java Script',
        'logo': 'assets/images/home/js.png',
      },
      {
        'name': 'PHP',
        'logo': 'assets/images/home/php.png',
      },
      {
        'name': 'Python',
        'logo': 'assets/images/home/python.png',
      },
    ];
    
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: vendors.length,
        itemBuilder: (context, index) {
          final vendor = vendors[index];
          return Container(
            width: 80,
            margin: EdgeInsets.only(right: index < vendors.length - 1 ? 16 : 0),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey.shade900 : Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
            ),
            child: Center(
              child: Image.network(
                vendor['logo']!,
                width: 60,
                height: 60,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Text(
                      vendor['name']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDarkMode ? Colors.white70 : Colors.black87,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildAuthorsList(bool isDarkMode) {
    final authors = [
      {
        'name': 'Responsive Portfolio with HTML & CSS',
        'role': 'HTML',
        'image': 'assets/images/home/challenge.png',
      },
      {
        'name': '30-Minute CSS Art Challenge',
        'role': 'CSS',
        'image': 'assets/images/home/challenge.png',
      },
      {
        'name': 'Build a To-Do App in JavaScript',
        'role': 'Java Script',
        'image': 'assets/images/home/challenge.png',
      },
      {
        'name': 'API Fetch & Display with React',
        'role': 'PHP',
        'image': 'assets/images/home/challenge.png',
      },
      {
        'name': 'Create a Calculator in Flutter',
        'role': 'Python',
        'image': 'assets/images/home/challenge.png',
      },
    ];
    
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: authors.length,
        itemBuilder: (context, index) {
          final author = authors[index];
          return Container(
            width: 100,
            margin: EdgeInsets.only(right: index < authors.length - 1 ? 16 : 0),
            child: Column(
              children: [
                // Author image
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      author['image']!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade400,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                // Author name
                Text(
                  author['name']!,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                // Author role
                Text(
                  author['role']!,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}