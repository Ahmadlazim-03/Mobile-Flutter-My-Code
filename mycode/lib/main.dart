// lib/main.dart
import 'package:flutter/material.dart';
import 'package:mycode/splash_screen.dart';
// Import SplashScreen
import './pages/index.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyCode',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Arial',
      ),
      home: const SplashScreen(), // Set SplashScreen as the initial page
    );
  }
}