// lib/screens/home/course_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({Key? key}) : super(key: key);

  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  
  // Define all courses with their categories
  final List<Map<String, dynamic>> _allCourses = [
    {
      'title': 'Complete Web Development Bootcamp',
      'instructor': 'Dr. Angela Yu',
      'image': 'assets/images/home/course1.jpeg',
      'price': '\$14.99',
      'rating': 4.8,
      'students': '125,000+',
      'color': Colors.blue.shade700,
      'categories': ['Web Development', 'Programming'],
      'description': 'Become a full-stack web developer with just one course. HTML, CSS, Javascript, Node, React, MongoDB and more!',
    },
    {
      'title': 'The Complete 2023 Flutter Development Bootcamp',
      'instructor': 'Dr. Angela Yu',
      'image': 'assets/images/home/course2.jpeg',
      'price': '\$20.99',
      'rating': 4.7,
      'students': '85,000+',
      'color': Colors.blue.shade400,
      'categories': ['Mobile Development', 'Programming'],
      'description': 'Learn Flutter and Dart from scratch and build iOS and Android apps with one codebase.',
    },
    {
      'title': 'Machine Learning A-Z: Hands-On Python & R',
      'instructor': 'Kirill Eremenko',
      'image': 'assets/images/home/course3.jpg',
      'price': '\$19.99',
      'rating': 4.6,
      'students': '750,000+',
      'color': Colors.green.shade600,
      'categories': ['Data Science', 'Programming'],
      'description': 'Learn to create Machine Learning Algorithms in Python and R from two Data Science experts.',
    },
    {
      'title': 'The Complete Digital Marketing Course',
      'instructor': 'Rob Percival',
      'image': 'assets/images/home/course4.png',
      'price': '\$18.99',
      'rating': 4.5,
      'students': '200,000+',
      'color': Colors.orange.shade700,
      'categories': ['Marketing', 'Business'],
      'description': '12 courses in 1! Master digital marketing strategy, social media marketing, SEO, YouTube, email, Facebook marketing, analytics & more!',
    },
    {
      'title': 'The Complete Financial Analyst Course',
      'instructor': 'Andrei Neagoie',
      'image': 'assets/images/home/challenge.png',
      'price': '\$16.99',
      'rating': 4.6,
      'students': '65,000+',
      'color': Colors.green.shade800,
      'categories': ['Finance', 'Business'],
      'description': 'Excel, Accounting, Financial Statement Analysis, Business Analysis, Financial Math, PowerPoint: Everything is Included!',
    },
    {
      'title': 'Graphic Design Masterclass',
      'instructor': 'Lindsay Marsh',
      'image': 'assets/images/home/challenge.png',
      'price': '\$15.99',
      'rating': 4.7,
      'students': '110,000+',
      'color': Colors.purple.shade600,
      'categories': ['Design', 'Art'],
      'description': 'Learn graphic design in Photoshop, Illustrator, and InDesign. Create stunning designs and layouts for print and web.',
    },
    {
      'title': 'The Complete JavaScript Course 2023',
      'instructor': 'Jonas Schmedtmann',
      'image': 'assets/images/home/challenge.png',
      'price': '\$17.99',
      'rating': 4.8,
      'students': '175,000+',
      'color': Colors.yellow.shade800,
      'categories': ['Web Development', 'Programming'],
      'description': 'Master JavaScript with the most complete course on the market. Projects, challenges, quizzes, JavaScript ES6+, OOP, AJAX, Webpack.',
    },
    {
      'title': 'iOS App Development Bootcamp',
      'instructor': 'Dr. Angela Yu',
      'image': 'assets/images/home/challenge.png',
      'price': '\$19.99',
      'rating': 4.8,
      'students': '95,000+',
      'color': Colors.grey.shade800,
      'categories': ['Mobile Development', 'Programming'],
      'description': 'Learn iOS app development from scratch. Build 25+ apps using Swift and Xcode. Includes SwiftUI and ARKit.',
    },
    {
      'title': 'Photography Masterclass',
      'instructor': 'Phil Ebiner',
      'image': 'assets/images/home/challenge.png',
      'price': '\$13.99',
      'rating': 4.6,
      'students': '220,000+',
      'color': Colors.red.shade700,
      'categories': ['Photography', 'Art'],
      'description': 'The complete guide to photography. Learn how to take amazing photos in easy step-by-step lessons.',
    },
    {
      'title': 'The Complete SQL Bootcamp',
      'instructor': 'Jose Portilla',
      'image': 'assets/images/home/challenge.png',
      'price': '\$12.99',
      'rating': 4.7,
      'students': '150,000+',
      'color': Colors.blue.shade900,
      'categories': ['Database', 'Programming'],
      'description': 'Learn SQL with PostgreSQL. Master SQL for data science, analytics, and business intelligence.',
    },
    {
      'title': 'Modern React with Redux',
      'instructor': 'Stephen Grider',
      'image': 'assets/images/home/challenge.png',
      'price': '\$15.99',
      'rating': 4.8,
      'students': '130,000+',
      'color': Colors.blue.shade500,
      'categories': ['Web Development', 'Programming'],
      'description': 'Master React v18 and Redux with React Router, Webpack, and Create-React-App. Includes Hooks!',
    },
    {
      'title': 'The Complete Cyber Security Course',
      'instructor': 'Nathan House',
      'image': 'assets/images/home/challenge.png',
      'price': '\$21.99',
      'rating': 4.5,
      'students': '85,000+',
      'color': Colors.teal.shade700,
      'categories': ['IT & Software', 'Security'],
      'description': 'Learn how to stop hackers, prevent hacking, learn about cyber security, penetration testing, and more.',
    },
  ];
  
  // Get filtered courses based on selected category and search query
  List<Map<String, dynamic>> get _filteredCourses {
    return _allCourses.where((course) {
      // Filter by category
      final categoryMatch = _selectedCategory == 'All' || 
          (course['categories'] as List<String>).contains(_selectedCategory);
      
      // Filter by search query
      final titleMatch = course['title'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      final instructorMatch = course['instructor'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
      
      return categoryMatch && (titleMatch || instructorMatch);
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
          'Top Courses',
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
                      hintText: 'Search courses or instructors',
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
                  '${_filteredCourses.length} Results',
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
          
          // Courses list
          Expanded(
            child: _filteredCourses.isEmpty
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
                          'No courses found',
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
                : _buildCoursesList(isDarkMode),
          ),
        ],
      ),
    );
  }
  
  Widget _buildCategoryTabs(bool isDarkMode) {
    // Define all available categories
    final categories = ['All', 'Programming', 'Web Development', 'Mobile Development', 'Data Science', 'Business', 'Design', 'Marketing'];
    
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
  
  Widget _buildCoursesList(bool isDarkMode) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      itemCount: _filteredCourses.length,
      itemBuilder: (context, index) {
        final course = _filteredCourses[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          color: isDarkMode ? Colors.grey.shade900 : Colors.white,
          child: InkWell(
            onTap: () {
              // Show course details in a dialog
              _showCourseDetailsDialog(course, isDarkMode);
            },
            borderRadius: BorderRadius.circular(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Course image
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.network(
                    course['image'] as String,
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 150,
                        color: course['color'] as Color,
                        child: Center(
                          child: Icon(
                            Icons.book,
                            size: 50,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Course title
                      Text(
                        course['title'] as String,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      
                      // Instructor name
                      Text(
                        'Instructor: ${course['instructor']}',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      
                      // Rating and students
                      Row(
                        children: [
                          // Rating stars
                          ...List.generate(
                            5,
                            (i) => Icon(
                              i < (course['rating'] as double).floor()
                                  ? Icons.star
                                  : i < (course['rating'] as double)
                                      ? Icons.star_half
                                      : Icons.star_border,
                              color: const Color(0xFFF5BE00),
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            (course['rating'] as double).toString(),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Icon(
                            Icons.people,
                            size: 16,
                            color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            course['students'] as String,
                            style: TextStyle(
                              fontSize: 14,
                              color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      
                      // Bottom row with price and categories
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Price
                          Text(
                            course['price'] as String,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF54408C),
                            ),
                          ),
                          
                          // Categories
                          Row(
                            children: [
                              for (int i = 0; i < (course['categories'] as List<String>).length && i < 2; i++)
                                Container(
                                  margin: const EdgeInsets.only(left: 4),
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: (course['color'] as Color).withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    (course['categories'] as List<String>)[i],
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: course['color'] as Color,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  
  void _showCourseDetailsDialog(Map<String, dynamic> course, bool isDarkMode) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: isDarkMode ? Colors.grey.shade900 : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Course image
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(
                  course['image'] as String,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 200,
                      color: course['color'] as Color,
                      child: Center(
                        child: Icon(
                          Icons.book,
                          size: 64,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Course title
                    Text(
                      course['title'] as String,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // Instructor name
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: course['color'] as Color,
                          radius: 16,
                          child: Text(
                            (course['instructor'] as String)[0],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Instructor: ${course['instructor']}',
                          style: TextStyle(
                            fontSize: 16,
                            color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // Description
                    Text(
                      'Description:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      course['description'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade800,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Rating and students
                    Row(
                      children: [
                        Text(
                          'Rating: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        ...List.generate(
                          5,
                          (i) => Icon(
                            i < (course['rating'] as double).floor()
                                ? Icons.star
                                : i < (course['rating'] as double)
                                    ? Icons.star_half
                                    : Icons.star_border,
                            color: const Color(0xFFF5BE00),
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          (course['rating'] as double).toString(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    
                    // Students
                    Row(
                      children: [
                        Text(
                          'Students: ',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        Icon(
                          Icons.people,
                          size: 20,
                          color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade800,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          course['students'] as String,
                          style: TextStyle(
                            fontSize: 16,
                            color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // Categories
                    Text(
                      'Categories:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: (course['categories'] as List<String>).map((category) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: (course['color'] as Color).withOpacity(0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            category,
                            style: TextStyle(
                              color: course['color'] as Color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    
                    // Price and enroll button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Price:',
                              style: TextStyle(
                                fontSize: 14,
                                color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade800,
                              ),
                            ),
                            Text(
                              course['price'] as String,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF54408C),
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // Show a snackbar when the user clicks "Enroll Now"
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Enrolled in ${course['title']}'),
                                backgroundColor: course['color'] as Color,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF54408C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          child: const Text(
                            'Enroll Now',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
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
        ),
      ),
    );
  }
}