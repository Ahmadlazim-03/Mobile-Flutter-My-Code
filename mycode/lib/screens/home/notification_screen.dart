// lib/screens/home/notification_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _showOnlyUnread = false;
  
  final List<NotificationItem> _notifications = [
    NotificationItem(
      type: NotificationType.promotion,
      title: 'Today 50% discount on all Books in Novel category with online orders worldwide.',
      date: DateTime(2021, 10, 21, 8, 0),
      isRead: false,
    ),
    NotificationItem(
      type: NotificationType.promotion,
      title: 'Buy 2 get 1 free for since books from 08 - 10 October 2021.',
      date: DateTime(2021, 10, 8, 20, 30),
      isRead: true,
    ),
    NotificationItem(
      type: NotificationType.information,
      title: 'There is a new book now are available',
      date: DateTime(2021, 9, 16, 11, 0),
      isRead: true,
    ),
    NotificationItem(
      type: NotificationType.update,
      title: 'Your order #12345 has been shipped and will arrive in 2-3 business days.',
      date: DateTime(2021, 9, 10, 14, 15),
      isRead: false,
    ),
    NotificationItem(
      type: NotificationType.information,
      title: 'Check out our new reading challenge for September!',
      date: DateTime(2021, 9, 5, 9, 30),
      isRead: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Map<String, List<NotificationItem>> _groupNotificationsByMonth() {
    final Map<String, List<NotificationItem>> grouped = {};
    
    // Filter notifications if showing only unread
    final notificationsToShow = _showOnlyUnread 
        ? _notifications.where((n) => !n.isRead).toList()
        : _notifications;
    
    for (var notification in notificationsToShow) {
      final monthYear = DateFormat('MMMM yyyy').format(notification.date);
      if (!grouped.containsKey(monthYear)) {
        grouped[monthYear] = [];
      }
      grouped[monthYear]!.add(notification);
    }
    
    return grouped;
  }

  int get _unreadCount => _notifications.where((n) => !n.isRead).length;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    final groupedNotifications = _groupNotificationsByMonth();
    
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        elevation: 0,
        title: Column(
          children: [
            Text(
              'Notification',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            if (_unreadCount > 0)
              Text(
                '$_unreadCount unread',
                style: TextStyle(
                  fontSize: 14,
                  color: const Color(0xFF54408C),
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.arrow_back,
              color: isDarkMode ? Colors.white : Colors.black,
              size: 20,
            ),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isDarkMode ? Colors.grey.shade900 : Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.more_vert,
                  color: isDarkMode ? Colors.white : Colors.black,
                  size: 20,
                ),
              ),
              onPressed: () {
                // Show options menu (mark all as read, clear all, etc.)
                showModalBottomSheet(
                  context: context,
                  backgroundColor: isDarkMode ? Colors.grey.shade900 : Colors.white,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  builder: (context) => Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_unreadCount > 0)
                          ListTile(
                            leading: Icon(
                              Icons.done_all,
                              color: const Color(0xFF54408C),
                            ),
                            title: Text(
                              'Mark all as read',
                              style: TextStyle(
                                color: isDarkMode ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              // Mark all notifications as read
                              setState(() {
                                for (var notification in _notifications) {
                                  notification.isRead = true;
                                }
                              });
                            },
                          ),
                        ListTile(
                          leading: Icon(
                            _showOnlyUnread ? Icons.visibility : Icons.visibility_off,
                            color: const Color(0xFF54408C),
                          ),
                          title: Text(
                            _showOnlyUnread ? 'Show all notifications' : 'Show only unread',
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            setState(() {
                              _showOnlyUnread = !_showOnlyUnread;
                            });
                          },
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.delete_outline,
                            color: Colors.red.shade400,
                          ),
                          title: Text(
                            'Clear all notifications',
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                            // Show confirmation dialog
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Clear all notifications?'),
                                content: const Text('This action cannot be undone.'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      setState(() {
                                        _notifications.clear();
                                      });
                                    },
                                    child: Text(
                                      'Clear',
                                      style: TextStyle(color: Colors.red.shade400),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter toggle
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              children: [
                Icon(
                  Icons.filter_list,
                  size: 20,
                  color: const Color(0xFF54408C),
                ),
                const SizedBox(width: 8),
                Text(
                  'Filter:',
                  style: TextStyle(
                    fontSize: 14,
                    color: isDarkMode ? Colors.white70 : Colors.black87,
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showOnlyUnread = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: !_showOnlyUnread
                          ? const Color(0xFF54408C)
                          : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'All',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: !_showOnlyUnread
                            ? Colors.white
                            : (isDarkMode ? Colors.white70 : Colors.black54),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _showOnlyUnread = true;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _showOnlyUnread
                          ? const Color(0xFF54408C)
                          : (isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Unread',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: _showOnlyUnread
                                ? Colors.white
                                : (isDarkMode ? Colors.white70 : Colors.black54),
                          ),
                        ),
                        if (_unreadCount > 0)
                          Container(
                            margin: const EdgeInsets.only(left: 6),
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: _showOnlyUnread
                                  ? Colors.white
                                  : const Color(0xFF54408C),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '$_unreadCount',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: _showOnlyUnread
                                    ? const Color(0xFF54408C)
                                    : Colors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Notifications list
          Expanded(
            child: groupedNotifications.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _showOnlyUnread
                              ? Icons.mark_email_read
                              : Icons.notifications_off_outlined,
                          size: 80,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _showOnlyUnread
                              ? 'No unread notifications'
                              : 'No notifications yet',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _showOnlyUnread
                              ? 'You\'re all caught up!'
                              : 'We\'ll notify you when something arrives',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        if (_showOnlyUnread && _notifications.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 24),
                            child: TextButton.icon(
                              onPressed: () {
                                setState(() {
                                  _showOnlyUnread = false;
                                });
                              },
                              icon: const Icon(Icons.visibility),
                              label: const Text('Show all notifications'),
                              style: TextButton.styleFrom(
                                foregroundColor: const Color(0xFF54408C),
                              ),
                            ),
                          ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: groupedNotifications.length,
                    itemBuilder: (context, index) {
                      final monthYear = groupedNotifications.keys.elementAt(index);
                      final notifications = groupedNotifications[monthYear]!;
                      
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Row(
                              children: [
                                Text(
                                  monthYear,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: isDarkMode ? Colors.white : Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF54408C).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    '${notifications.length}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF54408C),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                // Count of unread in this month
                                if (!_showOnlyUnread) 
                                  _buildUnreadBadge(notifications),
                              ],
                            ),
                          ),
                          ...notifications.asMap().entries.map((entry) {
                            final i = entry.key;
                            final notification = entry.value;
                            
                            return AnimatedBuilder(
                              animation: _animationController,
                              builder: (context, child) {
                                final delay = i * 0.2;
                                final slideAnimation = Tween<Offset>(
                                  begin: const Offset(1, 0),
                                  end: Offset.zero,
                                ).animate(
                                  CurvedAnimation(
                                    parent: _animationController,
                                    curve: Interval(
                                      delay.clamp(0, 0.8),
                                      (delay + 0.2).clamp(0, 1),
                                      curve: Curves.easeOutCubic,
                                    ),
                                  ),
                                );
                                
                                return SlideTransition(
                                  position: slideAnimation,
                                  child: child,
                                );
                              },
                              child: GestureDetector(
                                onTap: () {
                                  // Show notification details
                                  _showNotificationDetail(context, notification, isDarkMode);
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  decoration: BoxDecoration(
                                    color: notification.isRead
                                        ? (isDarkMode ? Colors.grey.shade900 : Colors.white)
                                        : (isDarkMode 
                                            ? const Color(0xFF54408C).withOpacity(0.2) 
                                            : const Color(0xFFEFEBFF)),
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: isDarkMode
                                        ? []
                                        : [
                                            BoxShadow(
                                              color: notification.isRead
                                                  ? Colors.black.withOpacity(0.05)
                                                  : const Color(0xFF54408C).withOpacity(0.1),
                                              blurRadius: notification.isRead ? 8 : 12,
                                              offset: const Offset(0, 4),
                                            ),
                                          ],
                                    border: notification.isRead
                                        ? Border.all(color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200)
                                        : Border.all(color: const Color(0xFF54408C), width: 1.5),
                                  ),
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            _buildNotificationTypeIcon(notification.type),
                                            const SizedBox(width: 16),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        _getNotificationTypeText(notification.type),
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: notification.isRead ? FontWeight.w600 : FontWeight.bold,
                                                          color: _getNotificationTypeColor(notification.type),
                                                        ),
                                                      ),
                                                      Text(
                                                        DateFormat('MMM d • HH:mm').format(notification.date),
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: notification.isRead ? FontWeight.normal : FontWeight.w500,
                                                          color: notification.isRead ? Colors.grey : const Color(0xFF54408C),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    notification.title,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: isDarkMode ? Colors.white : Colors.black,
                                                      fontWeight: notification.isRead ? FontWeight.normal : FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (!notification.isRead)
                                        Positioned(
                                          top: 0,
                                          left: 0,
                                          child: Container(
                                            width: 24,
                                            height: 24,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF54408C),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(16),
                                                bottomRight: Radius.circular(16),
                                              ),
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.circle,
                                                color: Colors.white,
                                                size: 10,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          if (index < groupedNotifications.length - 1)
                            const SizedBox(height: 12),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
      // FAB to mark all as read if there are unread notifications
      floatingActionButton: _unreadCount > 0 && !_showOnlyUnread
          ? FloatingActionButton.extended(
              onPressed: () {
                setState(() {
                  for (var notification in _notifications) {
                    notification.isRead = true;
                  }
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('All notifications marked as read'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              backgroundColor: const Color(0xFF54408C),
              icon: const Icon(Icons.done_all),
              label: const Text('Mark all as read'),
            )
          : null,
    );
  }
  
  // Update the _showNotificationDetail method in the NotificationScreen class
void _showNotificationDetail(BuildContext context, NotificationItem notification, bool isDarkMode) {
  showModalBottomSheet(
    context: context,
    backgroundColor: isDarkMode ? Colors.grey.shade900 : Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              _buildNotificationTypeIcon(notification.type, size: 40),
              const SizedBox(width: 12),
              Text(
                _getNotificationTypeText(notification.type),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _getNotificationTypeColor(notification.type),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            notification.title,
            style: TextStyle(
              fontSize: 16,
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            DateFormat('MMMM d, yyyy • h:mm a').format(notification.date),
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 24),
          
          // Fixed buttons layout
          Row(
            children: [
              // Mark as read button - only show if notification is unread
              if (!notification.isRead)
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          notification.isRead = true;
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Notification marked as read'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF54408C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Mark as read',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              else
                Expanded(
                  child: SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade400,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        disabledBackgroundColor: Colors.grey.shade400,
                        disabledForegroundColor: Colors.white,
                      ),
                      child: const Text(
                        'Already read',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              
              const SizedBox(width: 12),
              
              // Close button
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Close',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
  
  Widget _buildUnreadBadge(List<NotificationItem> notifications) {
    final unreadCount = notifications.where((n) => !n.isRead).length;
    if (unreadCount == 0) return const SizedBox.shrink();
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF54408C),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.circle,
            size: 8,
            color: Colors.white,
          ),
          const SizedBox(width: 4),
          Text(
            '$unreadCount unread',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildNotificationTypeIcon(NotificationType type, {double size = 36}) {
    IconData iconData;
    Color backgroundColor;
    Color iconColor;
    
    switch (type) {
      case NotificationType.promotion:
        iconData = Icons.local_offer;
        backgroundColor = Colors.purple.shade100;
        iconColor = Colors.purple;
        break;
      case NotificationType.information:
        iconData = Icons.info;
        backgroundColor = Colors.blue.shade100;
        iconColor = Colors.blue;
        break;
      case NotificationType.update:
        iconData = Icons.update;
        backgroundColor = Colors.orange.shade100;
        iconColor = Colors.orange;
        break;
    }
    
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        iconData,
        color: iconColor,
        size: size * 0.6,
      ),
    );
  }
  
  String _getNotificationTypeText(NotificationType type) {
    switch (type) {
      case NotificationType.promotion:
        return 'Promotion';
      case NotificationType.information:
        return 'Information';
      case NotificationType.update:
        return 'Update';
    }
  }
  
  Color _getNotificationTypeColor(NotificationType type) {
    switch (type) {
      case NotificationType.promotion:
        return Colors.purple;
      case NotificationType.information:
        return Colors.blue;
      case NotificationType.update:
        return Colors.orange;
    }
  }
}

enum NotificationType {
  promotion,
  information,
  update,
}

class NotificationItem {
  final NotificationType type;
  final String title;
  final DateTime date;
  bool isRead;
  
  NotificationItem({
    required this.type,
    required this.title,
    required this.date,
    this.isRead = false,
  });
}