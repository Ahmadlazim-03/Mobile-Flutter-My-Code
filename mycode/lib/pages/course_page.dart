import 'package:flutter/material.dart';

class CoursePage extends StatelessWidget {
  const CoursePage({super.key});

  // Model data untuk kursus (hanya menyimpan 'image')
  final List<Map<String, String>> courses = const [
    {'image': 'assets/web_dev.png'},
    {'image': 'assets/app_dev.png'},
    {'image': 'assets/game_dev.png'},
    {'image': 'assets/data_science.png'},
    {'image': 'assets/cyber_security.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4255FF), // Warna latar belakang utama
      body: Column(
        children: [
          // Bagian atas dengan background putih
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'ALL COURSES',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.filter_list,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Filter clicked!')),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16), // Jarak antara header dan daftar kursus
          // Daftar kursus
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: CourseCard(
                    imagePath: course['image']!,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Widget untuk kartu kursus
class CourseCard extends StatelessWidget {
  final String imagePath;

  const CourseCard({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.2), // Overlay ringan
            BlendMode.darken, // Membantu mempertajam gambar
          ),
        ),
      ),
      child: Stack(
        children: [
          // Tombol "Start" di pojok kanan bawah
          Positioned(
            right: 12,
            bottom: 12,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Starting course')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Start',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
