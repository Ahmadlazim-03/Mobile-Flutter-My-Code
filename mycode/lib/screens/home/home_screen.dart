// lib/screens/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    // Set status bar to dark icons on white background
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                
                // Header with search, title, and notification
                _buildHeader(),
                
                const SizedBox(height: 24),
                
                // Special offer banner
                _buildSpecialOfferBanner(),
                
                const SizedBox(height: 32),
                
                // Top of Week section
                _buildSectionHeader('Top of Week', onSeeAllPressed: () {}),
                const SizedBox(height: 16),
                _buildBooksList(),
                
                const SizedBox(height: 32),
                
                // Best Vendors section
                _buildSectionHeader('Best Vendors', onSeeAllPressed: () {}),
                const SizedBox(height: 16),
                _buildVendorsList(),
                
                const SizedBox(height: 32),
                
                // Authors section
                _buildSectionHeader('Authors', onSeeAllPressed: () {}),
                const SizedBox(height: 16),
                _buildAuthorsList(),
                
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
  
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Search icon
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: const Icon(Icons.search, color: Colors.black),
        ),
        
        // Title
        const Text(
          'Home',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        
        // Notification icon
        Stack(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Icon(Icons.notifications_outlined, color: Colors.black),
            ),
            Positioned(
              right: 10,
              top: 10,
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
    );
  }
  
  Widget _buildSpecialOfferBanner() {
    final offers = [
      {
        'title': 'Special Offer',
        'subtitle': 'Discount 25%',
        'buttonText': 'Order Now',
        'image': 'https://m.media-amazon.com/images/I/91IM+7+b3xL._AC_UF1000,1000_QL80_.jpg',
      },
      {
        'title': 'New Arrival',
        'subtitle': 'Best Seller Books',
        'buttonText': 'See More',
        'image': 'https://m.media-amazon.com/images/I/71rpa1-kyvL._AC_UF1000,1000_QL80_.jpg',
      },
      {
        'title': 'Flash Sale',
        'subtitle': 'Up to 50% Off',
        'buttonText': 'Shop Now',
        'image': 'https://m.media-amazon.com/images/I/81FPzmB5fgL._AC_UF1000,1000_QL80_.jpg',
      },
    ];
    
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
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
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  children: [
                    // Left side text and button
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            offer['title']!,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            offer['subtitle']!,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: 44,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF54408C),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                              ),
                              child: Text(offer['buttonText']!),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Right side book image
                    Container(
                      width: 120,
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(offer['image']!),
                          fit: BoxFit.cover,
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
                        ? const Color(0xFF54408C)
                        : Colors.grey.shade300,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSectionHeader(String title, {required VoidCallback onSeeAllPressed}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
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
  
  Widget _buildBooksList() {
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
        itemCount: books.length,
        itemBuilder: (context, index) {
          final book = books[index];
          return Container(
            width: 160,
            margin: EdgeInsets.only(right: index < books.length - 1 ? 16 : 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Book cover
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(book['image']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Book title
                Text(
                  book['title']!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
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
  
  Widget _buildVendorsList() {
    final vendors = [
      {
        'name': 'Warehouse Stationery',
        'logo': 'https://upload.wikimedia.org/wikipedia/en/thumb/c/c0/Warehouse_Stationery_logo.svg/1200px-Warehouse_Stationery_logo.svg.png',
      },
      {
        'name': 'Kuromi by Sanrio',
        'logo': 'https://i.pinimg.com/originals/3e/53/54/3e5354a631f4a2e7959f0d40acf8d744.png',
      },
      {
        'name': 'GooDay',
        'logo': 'https://play-lh.googleusercontent.com/Jm6-HF5mBCsW-kDGGKUvgEQgE-XBVS9JkjmXl6Lf6SROHJwzEMNhYKxKLfmqbB2qMA',
      },
      {
        'name': 'Crane & Co.',
        'logo': 'https://cdn.logojoy.com/wp-content/uploads/2018/05/30161703/3510.png',
      },
    ];
    
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: vendors.length,
        itemBuilder: (context, index) {
          final vendor = vendors[index];
          return Container(
            width: 100,
            margin: EdgeInsets.only(right: index < vendors.length - 1 ? 16 : 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade200),
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
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
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
  
  Widget _buildAuthorsList() {
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
        itemCount: authors.length,
        itemBuilder: (context, index) {
          final author = authors[index];
          return Container(
            width: 120,
            margin: EdgeInsets.only(right: index < authors.length - 1 ? 16 : 0),
            child: Column(
              children: [
                // Author image
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(author['image']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Author name
                Text(
                  author['name']!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
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
                    color: Colors.grey.shade600,
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
  
  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF54408C),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
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
      ),
    );
  }
}