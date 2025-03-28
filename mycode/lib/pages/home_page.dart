import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyCode',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainScreen(),
    );
  }
}

// Widget utama yang menangani navigasi antar halaman
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const Placeholder(), // Ganti dengan halaman CoursePage()
    const Placeholder(), // Ganti dengan halaman ExercisePage()
    const Placeholder(), // Ganti dengan halaman ForumPage()
    const Placeholder(), // Ganti dengan halaman ProfilePage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Course'),
          BottomNavigationBarItem(icon: Icon(Icons.fitness_center), label: 'Exercise'),
          BottomNavigationBarItem(icon: Icon(Icons.forum), label: 'Forum'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// Halaman Home
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4255FF),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildProfile(),
            _buildProgressCourses(),
            _buildCourseRecommendations(),
          ],
        ),
      ),
    );
  }

  // Header (Logo + Notifikasi)
  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset('assets/mycodelogo.png', width: 80),
          const Text(
            'MYCODE',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const Icon(Icons.notifications, color: Colors.white),
        ],
      ),
    );
  }

  // Profil User
  Widget _buildProfile() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.blue[800],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/user.png'),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('ahmadlazim', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text('ahmadlazim@gmail.com', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Progress Courses
  Widget _buildProgressCourses() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Progress Courses',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildProgressCard("Web Development", 0.2),
              _buildProgressCard("App Development", 0.45),
              _buildProgressCard("Cyber Security", 0.7),
            ],
          ),
        ],
      ),
    );
  }

  // Progress Card
  Widget _buildProgressCard(String title, double progress) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 40.0,
          lineWidth: 8.0,
          percent: progress,
          center: Text("${(progress * 100).toInt()}%"),
          progressColor: Colors.white,
          backgroundColor: Colors.white38,
        ),
        const SizedBox(height: 5),
        Text(title, style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 5),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
          onPressed: () {},
          child: const Text("Continue", style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }

  // Rekomendasi Course
  Widget _buildCourseRecommendations() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Course Recommendations',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 10),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildCourseCard("Web Development", ["assets/app_dev.png"]),
            _buildCourseCard("App Development", ["assets/cyber_security.png"]),
            _buildCourseCard("Game Development", ["assets/data_science.png"]),
            _buildCourseCard("Data Science", ["assets/data_science.png"]),
          ],
        ),
      ],
    ),
  );
}

Widget _buildCourseCard(String title, List<String> icons) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: icons.map((icon) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Image.asset(
                  icon,
                  width: 100,  // Perbesar ukuran gambar
                  height: 100, // Sesuaikan agar proporsional
                  fit: BoxFit.contain,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ),
  );
}

}
