// lib/splash_screen.dart (with fine-tuning)
import 'dart:math';
import 'package:flutter/material.dart';
import 'form/login_page.dart'; // Import LoginPage

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Define the scale animation for the white circle
    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutCubic), // Smoother scaling
      ),
    );

    // Define the fade animation for the logo (delayed)
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 0.8, curve: Curves.easeIn),
      ),
    );

    // Start the animation
    _controller.forward();

    // Navigate to LoginPage after the animation completes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen dimensions
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;

    // Calculate the diagonal of the screen and make it slightly larger
    final screenDiagonal = sqrt(screenWidth * screenWidth + screenHeight * screenHeight) * 1.2;

    return Scaffold(
      backgroundColor: const Color(0xFF4285F4), // Blue background
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // White circle that scales up to cover the entire screen
            ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: screenDiagonal,
                height: screenDiagonal,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // MyCode logo (fades in after the circle scales)
            FadeTransition(
              opacity: _fadeAnimation,
              child: Image.asset(
                'assets/mycodelogo.png',
                width: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}