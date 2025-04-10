// lib/screens/home/programming_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';

class ProgrammingScreen extends StatefulWidget {
  const ProgrammingScreen({Key? key}) : super(key: key);

  @override
  _ProgrammingScreenState createState() => _ProgrammingScreenState();
}

class _ProgrammingScreenState extends State<ProgrammingScreen> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  
  // Define all programming languages with their categories
  final List<Map<String, dynamic>> _allLanguages = [
    {
      'name': 'HTML',
      'logo': 'assets/images/home/html.png',
      'description': 'Markup language for web pages',
      'popularity': 4.8,
      'color': Colors.orange,
      'categories': ['Web'],
    },
    {
      'name': 'CSS',
      'logo': 'assets/images/home/css.png',
      'description': 'Style sheet language for web design',
      'popularity': 4.7,
      'color': Colors.blue,
      'categories': ['Web'],
    },
    {
      'name': 'JavaScript',
      'logo': 'assets/images/home/js.png',
      'description': 'Programming language for web development',
      'popularity': 4.9,
      'color': Colors.yellow.shade700,
      'categories': ['Web', 'Backend'],
    },
    {
      'name': 'PHP',
      'logo': 'assets/images/home/php.png',
      'description': 'Server-side scripting language for web development',
      'popularity': 4.5,
      'color': Colors.indigo,
      'categories': ['Web', 'Backend'],
    },
    {
      'name': 'Python',
      'logo': 'assets/images/home/python.png',
      'description': 'General-purpose programming language',
      'popularity': 4.9,
      'color': Colors.blue.shade800,
      'categories': ['Backend', 'Data Science', 'Game Dev'],
    },
    {
      'name': 'Java',
      'logo': 'assets/images/home/challenge.png',
      'description': 'Object-oriented programming language',
      'popularity': 4.6,
      'color': Colors.red,
      'categories': ['Backend', 'Mobile'],
    },
    {
      'name': 'C++',
      'logo': 'assets/images/home/challenge.png',
      'description': 'General-purpose programming language',
      'popularity': 4.5,
      'color': Colors.blue.shade900,
      'categories': ['Game Dev', 'Backend'],
    },
    {
      'name': 'Swift',
      'logo': 'assets/images/home/challenge.png',
      'description': 'Programming language for Apple platforms',
      'popularity': 4.7,
      'color': Colors.orange.shade700,
      'categories': ['Mobile'],
    },
    {
      'name': 'Kotlin',
      'logo': 'assets/images/home/challenge.png',
      'description': 'Programming language for Android development',
      'popularity': 4.8,
      'color': Colors.purple,
      'categories': ['Mobile'],
    },
    {
      'name': 'Ruby',
      'logo': 'assets/images/home/challenge.png',
      'description': 'Dynamic programming language for web applications',
      'popularity': 4.4,
      'color': Colors.red.shade700,
      'categories': ['Web', 'Backend'],
    },
    {
      'name': 'Go',
      'logo': 'assets/images/home/challenge.png',
      'description': 'Statically typed language by Google',
      'popularity': 4.6,
      'color': Colors.teal,
      'categories': ['Backend'],
    },
    {
      'name': 'Rust',
      'logo': 'assets/images/home/challenge.png',
      'description': 'Systems programming language',
      'popularity': 4.7,
      'color': Colors.brown,
      'categories': ['Backend', 'Game Dev'],
    },
    {
      'name': 'R',
      'logo': 'assets/images/home/challenge.png',
      'description': 'Language for statistical computing and graphics',
      'popularity': 4.3,
      'color': Colors.blue.shade300,
      'categories': ['Data Science'],
    },
    {
      'name': 'TypeScript',
      'logo': 'assets/images/home/challenge.png',
      'description': 'Typed superset of JavaScript',
      'popularity': 4.8,
      'color': Colors.blue.shade600,
      'categories': ['Web', 'Backend'],
    },
    {
      'name': 'C#',
      'logo': 'assets/images/home/challenge.png',
      'description': 'Object-oriented language by Microsoft',
      'popularity': 4.7,
      'color': Colors.purple.shade800,
      'categories': ['Game Dev', 'Backend'],
    },
    {
      'name': 'Dart',
      'logo': 'assets/images/home/challenge.png',
      'description': 'Client-optimized language for fast apps',
      'popularity': 4.5,
      'color': Colors.blue.shade400,
      'categories': ['Mobile', 'Web'],
    },
    {
      'name': 'SQL',
      'logo': 'assets/images/home/challenge.png',
      'description': 'Language for managing data in databases',
      'popularity': 4.6,
      'color': Colors.orange.shade800,
      'categories': ['Backend', 'Data Science'],
    },
    {
      'name': 'Scala',
      'logo': 'assets/images/home/challenge.png',
      'description': 'Combines object-oriented and functional programming',
      'popularity': 4.2,
      'color': Colors.red.shade400,
      'categories': ['Backend', 'Data Science'],
    },
  ];
  
  // Get filtered languages based on selected category and search query
  List<Map<String, dynamic>> get _filteredLanguages {
    return _allLanguages.where((language) {
      // Filter by category
      final categoryMatch = _selectedCategory == 'All' || 
          (language['categories'] as List<String>).contains(_selectedCategory);
      
      // Filter by search query
      final nameMatch = language['name'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      
      return categoryMatch && nameMatch;
    }).toList();
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
          'Programming Languages',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
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
              margin: const EdgeInsets.only(right: 16),
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
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Search bar
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search programming languages',
                      hintStyle: TextStyle(
                        color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Tabs for categories
                _buildCategoryTabs(isDarkMode),
              ],
            ),
          ),
          
          // Results count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_filteredLanguages.length} Results',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.sort,
                      size: 20,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Sort by: Popularity',
                      style: TextStyle(
                        fontSize: 14,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Programming languages grid
          Expanded(
            child: _filteredLanguages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: isDarkMode ? Colors.grey.shade700 : Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No languages found',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Try changing your search or category',
                          style: TextStyle(
                            fontSize: 14,
                            color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  )
                : _buildProgrammingLanguagesGrid(isDarkMode),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCategoryTabs(bool isDarkMode) {
    // Define all available categories
    final categories = ['All', 'Web', 'Mobile', 'Backend', 'Data Science', 'Game Dev'];
    
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = _selectedCategory == category;
          
          return Container(
            margin: const EdgeInsets.only(right: 12),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _selectedCategory = category;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isSelected 
                    ? const Color(0xFF54408C) 
                    : (isDarkMode ? Colors.grey.shade900 : Colors.grey.shade100),
                foregroundColor: isSelected 
                    ? Colors.white 
                    : (isDarkMode ? Colors.white : Colors.black),
                elevation: isSelected ? 2 : 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              child: Text(category),
            ),
          );
        },
      ),
    );
  }
  
  Widget _buildProgrammingLanguagesGrid(bool isDarkMode) {
    // Calculate screen width to determine appropriate sizing
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = (screenWidth - 48) / 2; // 48 = padding (16*2) + spacing (16)
    final itemHeight = itemWidth * 0.9; // Adjust aspect ratio
    
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: itemWidth / itemHeight,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: _filteredLanguages.length,
      itemBuilder: (context, index) {
        final language = _filteredLanguages[index];
        return Card(
          elevation: 2,
          margin: EdgeInsets.zero, // Remove default card margin
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: isDarkMode ? Colors.grey.shade900 : Colors.white,
          child: InkWell(
            onTap: () {
              // Show language details in a dialog
              _showLanguageDetailsDialog(language, isDarkMode);
            },
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(10.0), // Reduced padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 36, // Slightly smaller icon
                        height: 36,
                        decoration: BoxDecoration(
                          color: language['color'] as Color,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            language['logo'] as String,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Text(
                                  language['name']!.toString().substring(0, 1),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          language['name'] as String,
                          style: TextStyle(
                            fontSize: 14, // Smaller font
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6), // Reduced spacing
                  Text(
                    language['description'] as String,
                    style: TextStyle(
                      fontSize: 11, // Smaller font
                      color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6), // Reduced spacing
                  Row(
                    children: [
                      ...List.generate(
                        5,
                        (i) => Icon(
                          i < (language['popularity'] as double).floor()
                              ? Icons.star
                              : i < (language['popularity'] as double)
                                  ? Icons.star_half
                                  : Icons.star_border,
                          color: const Color(0xFFF5BE00),
                          size: 14, // Smaller icons
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        (language['popularity'] as double).toString(),
                        style: TextStyle(
                          fontSize: 11, // Smaller font
                          color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Show first category as a chip
                  if ((language['categories'] as List<String>).isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), // Smaller padding
                      decoration: BoxDecoration(
                        color: (language['color'] as Color).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        (language['categories'] as List<String>)[0],
                        style: TextStyle(
                          fontSize: 9, // Smaller font
                          color: language['color'] as Color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  
  void _showLanguageDetailsDialog(Map<String, dynamic> language, bool isDarkMode) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDarkMode ? Colors.grey.shade900 : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: language['color'] as Color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  language['name']!.toString().substring(0, 1),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                language['name'] as String,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                language['description'] as String,
                style: TextStyle(
                  color: isDarkMode ? Colors.white70 : Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Categories:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: (language['categories'] as List<String>).map((category) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: (language['color'] as Color).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      category,
                      style: TextStyle(
                        color: language['color'] as Color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Popularity: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                  ...List.generate(
                    5,
                    (i) => Icon(
                      i < (language['popularity'] as double).floor()
                          ? Icons.star
                          : i < (language['popularity'] as double)
                              ? Icons.star_half
                              : Icons.star_border,
                      color: const Color(0xFFF5BE00),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    (language['popularity'] as double).toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Show a snackbar when the user clicks "Learn More"
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Learning about ${language['name']}'),
                  backgroundColor: language['color'] as Color,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: language['color'] as Color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Learn More'),
          ),
        ],
      ),
    );
  }
}