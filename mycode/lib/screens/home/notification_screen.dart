// lib/screens/home/notification_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        elevation: 0,
        title: Text(
          'Notification',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: isDarkMode ? Colors.white : Colors.black,
            size: 28,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // October 2021 section
          _buildMonthHeader('October 2021', isDarkMode),
          const SizedBox(height: 16),
          
          // First notification
          _buildNotification(
            type: 'Promotion',
            typeColor: Colors.purple,
            date: 'Oct 21',
            time: '08.00',
            content: 'Today 50% discount on all Books in Novel category with online orders worldwide.',
            isDarkMode: isDarkMode,
          ),
          
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 16),
          
          // Second notification
          _buildNotification(
            type: 'Promotion',
            typeColor: Colors.purple,
            date: 'Oct 08',
            time: '20.30',
            content: 'Buy 2 get 1 free for since books from 08 - 10 October 2021.',
            isDarkMode: isDarkMode,
          ),
          
          const SizedBox(height: 32),
          
          // September 2021 section
          _buildMonthHeader('September 2021', isDarkMode),
          const SizedBox(height: 16),
          
          // Third notification
          _buildNotification(
            type: 'Information',
            typeColor: Colors.blue,
            date: 'Sept 16',
            time: '11.00',
            content: 'There is a new book now are available',
            isDarkMode: isDarkMode,
          ),
        ],
      ),
    );
  }
  
  Widget _buildMonthHeader(String month, bool isDarkMode) {
    return Text(
      month,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: isDarkMode ? Colors.white : Colors.black,
      ),
    );
  }
  
  Widget _buildNotification({
    required String type,
    required Color typeColor,
    required String date,
    required String time,
    required String content,
    required bool isDarkMode,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              type,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: typeColor,
              ),
            ),
            Text(
              '$date • $time',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(
            fontSize: 16,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ],
    );
  }
}