import 'package:flutter/material.dart';
import 'home_page.dart'; // Import halaman Home
import 'course_page.dart'; // Import halaman Course
import 'exercise_page.dart'; // Import halaman Exercise
import 'forum_page.dart'; // Import halaman Forum
import 'profile_page.dart'; // Import halaman Profile

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomeContent> {
  int _selectedIndex = 0;

  // Daftar halaman yang akan ditampilkan
  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const CoursePage(),
    const ExercisePage(),
    const ForumPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book), // Ikon untuk Course
            label: 'Course',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center), // Ikon untuk Exercise
            label: 'Exercise',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum), // Ikon untuk Forum
            label: 'Forum',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}