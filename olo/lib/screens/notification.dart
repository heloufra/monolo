import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  final List<NotificationModel> notifications = [
    NotificationModel(title: 'New message from John', description: 'Hey, check this out!', time: '1h ago', read: false),
    NotificationModel(title: 'Your order has been shipped', description: 'Your package is on its way.', time: '2h ago', read: true),
    NotificationModel(title: 'New comment on your post', description: 'Great post! Loved it!', time: '3h ago', read: false),
    NotificationModel(title: 'Reminder: Meeting at 5 PM', description: 'Don\'t forget the team meeting.', time: '4h ago', read: true),
    NotificationModel(title: 'Update available', description: 'A new update is available for your app.', time: '5h ago', read: false),
  ];

  NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Notifications',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white, // Keep the app bar white
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: ListView.separated(
        itemCount: notifications.length,
        separatorBuilder: (context, index) => Divider(color: Colors.grey[300], height: 1),
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return NotificationItem(
            title: notification.title,
            description: notification.description,
            time: notification.time,
            isRead: notification.read,
          );
        },
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final bool isRead;

  const NotificationItem({
    Key? key,
    required this.title,
    required this.description,
    required this.time,
    required this.isRead,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isRead ? Colors.grey[100] : Color.fromRGBO(23, 20, 39, 0.1), // Lightened version of the chosen color for unread
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Circular icon indicating unread status
            if (!isRead)
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(23, 20, 39, 1), // RGB color for the unread dot
                ),
                margin: EdgeInsets.only(top: 6),
              ),
            if (isRead)
              Icon(Icons.check_circle, color: Colors.greenAccent, size: 18), // Check icon for read notifications
            SizedBox(width: 16),
            // Notification content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isRead ? FontWeight.w400 : FontWeight.bold,
                      color: Color.fromRGBO(23, 20, 39, 1), // Main RGB color for the text
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationModel {
  final String title;
  final String description;
  final String time;
  final bool read;

  NotificationModel({
    required this.title,
    required this.description,
    required this.time,
    this.read = false,
  });
}
