// lib/screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
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
          
          // Notification icon
          Stack(
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
          _buildSectionHeader('Top of Week', onSeeAllPressed: () {}, isDarkMode: isDarkMode),
          const SizedBox(height: 16),
          _buildBooksList(isDarkMode),
          
          const SizedBox(height: 24),
          
          // Best Vendors section
          _buildSectionHeader('Best Vendors', onSeeAllPressed: () {}, isDarkMode: isDarkMode),
          const SizedBox(height: 16),
          _buildVendorsList(isDarkMode),
          
          const SizedBox(height: 24),
          
          // Authors section
          _buildSectionHeader('Authors', onSeeAllPressed: () {}, isDarkMode: isDarkMode),
          const SizedBox(height: 16),
          _buildAuthorsList(isDarkMode),
          
          // Add extra padding at the bottom
          const SizedBox(height: 24),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(isDarkMode),
    );
  }
  
  Widget _buildSpecialOfferBanner(bool isDarkMode) {
    // Define multiple offers
    final offers = [
      {
        'title': 'Special Offer',
        'subtitle': 'Discount 25%',
        'buttonText': 'Order Now',
        'image': 'https://m.media-amazon.com/images/I/51JRoZRrNhL._SY445_SX342_.jpg',
        'imageAlt': 'The Trials of Apollo',
        'color': const Color(0xFF54408C),
      },
      {
        'title': 'New Release',
        'subtitle': 'Best Seller Books',
        'buttonText': 'Get Now',
        'image': 'https://m.media-amazon.com/images/I/71-++hbbERL._AC_UF1000,1000_QL80_.jpg',
        'imageAlt': 'Harry Potter',
        'color': const Color(0xFF1E88E5),
      },
      {
        'title': 'Flash Sale',
        'subtitle': 'Up to 50% Off',
        'buttonText': 'Shop Now',
        'image': 'https://m.media-amazon.com/images/I/81yfsIOijJL._AC_UF1000,1000_QL80_.jpg',
        'imageAlt': 'Lord of the Rings',
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
        'image': 'https://m.media-amazon.com/images/I/81IzbD2IiIL._AC_UF1000,1000_QL80_.jpg',
      },
      {
        'title': 'The Subtle Art of Not Giving a F*ck',
        'price': '\$20.99',
        'image': 'https://m.media-amazon.com/images/I/71QKQ9mwV7L._AC_UF1000,1000_QL80_.jpg',
      },
      {
        'title': 'The Art of War',
        'price': '\$14.99',
        'image': 'https://m.media-amazon.com/images/I/71dNsRuYL7L._AC_UF1000,1000_QL80_.jpg',
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
        'name': 'Warehouse Stationery',
        'logo': 'https://www.warehousestationery.co.nz/on/demandware.static/Sites-wsl-Site/-/default/dw4c147e98/images/ws-logo.svg',
      },
      {
        'name': 'Kuromi',
        'logo': 'https://i.pinimg.com/originals/60/35/25/603525cd1d9709d6ab9d499b6c2f8047.png',
      },
      {
        'name': 'GooDay',
        'logo': 'https://gooday.co.jp/wp-content/themes/gooday/assets/images/common/logo.svg',
      },
      {
        'name': 'Crane & Co.',
        'logo': 'https://www.crane.com/media/logo/stores/1/crane_logo.png',
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
        'name': 'John Freeman',
        'role': 'Writer',
        'image': 'https://randomuser.me/api/portraits/men/32.jpg',
      },
      {
        'name': 'Tess Gunty',
        'role': 'Novelist',
        'image': 'https://randomuser.me/api/portraits/women/44.jpg',
      },
      {
        'name': 'Richard Per',
        'role': 'Writer',
        'image': 'https://randomuser.me/api/portraits/men/46.jpg',
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
                const SizedBox(height: 8),
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
  
  Widget _buildBottomNavigationBar(bool isDarkMode) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
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
          label: 'Category',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart_outlined),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
    );
  }
}