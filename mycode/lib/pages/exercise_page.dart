import 'package:flutter/material.dart';

class ExercisePage extends StatelessWidget {
  const ExercisePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4255FF), // Background utama tetap biru
      body: SafeArea(
        child: Column(
          children: [
            // Title dengan background putih
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              color: Colors.white,
              child: const Text(
                'Exercise',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),

            // Bagian dengan background biru
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              color: Color(0xFF4255FF), // Background biru
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.orange,
                        child: Text(
                          'W',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'WhiteCube',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '1100 pts',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Tab kategori
                  Row(
                    children: [
                      _buildCategoryButton("Web Development", Colors.red),
                      _buildCategoryButton("App Development", Colors.blue),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // Daftar latihan
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: List.generate(5, (index) {
                  return _buildExerciseCard(
                    level: index + 1,
                    points: (index + 1) * 10,
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk tombol kategori
  Widget _buildCategoryButton(String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {},
        child: Text(text, style: TextStyle(color: Colors.white)),
      ),
    );
  }

  // Widget untuk kartu latihan
  Widget _buildExerciseCard({required int level, required int points}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(Icons.code, color: Colors.grey),
        title: Text("Level $level"),
        subtitle: Row(
          children: [
            Icon(Icons.star, color: Colors.yellow, size: 16),
            const SizedBox(width: 4),
            Text("$points pts"),
          ],
        ),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF4255FF), // Warna tombol Start
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: () {},
          child: const Text("Start", style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
