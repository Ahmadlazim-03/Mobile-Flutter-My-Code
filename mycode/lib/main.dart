// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'screens/splash/splash_screen.dart';
import 'providers/theme_provider.dart';
import 'package:mycode/screens/home/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the current theme state from the provider
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return MaterialApp(
      title: 'MyCode',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF54408C),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF54408C),
          primary: const Color(0xFF54408C),
          brightness: themeProvider.isDarkMode ? Brightness.dark : Brightness.light,
        ),
        scaffoldBackgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
        fontFamily: 'Roboto',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF54408C),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF54408C),
          primary: const Color(0xFF54408C),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'Roboto',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const HomeScreen(),
    );
  }
}