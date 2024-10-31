import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  List<NotificationModel> allNotifications = [
    NotificationModel(
      id: '1',
      emoji: '🍔',
      title: 'Order Confirmed',
      description: 'Your burger is being prepared',
      time: '2 min ago',
      isRead: false,
      type: NotificationType.order,
    ),
    NotificationModel(
      id: '2',
      emoji: '🚚',
      title: 'On the Way',
      description: 'Your order will arrive in 15 minutes',
      time: '10 min ago',
      isRead: true,
      type: NotificationType.delivery,
    ),
    NotificationModel(
      id: '3',
      emoji: '💰',
      title: 'Special Offer',
      description: '20% off on your next pizza order',
      time: '1h ago',
      isRead: false,
      type: NotificationType.promo,
    ),
    NotificationModel(
      id: '4',
      emoji: '⭐',
      title: 'Rate Your Order',
      description: 'How was your recent sushi?',
      time: '2h ago',
      isRead: false,
      type: NotificationType.feedback,
    ),
    NotificationModel(
      id: '5',
      emoji: '🎉',
      title: 'New Restaurant',
      description: 'Try our latest Italian partner',
      time: '1d ago',
      isRead: true,
      type: NotificationType.promo,
    ),
  ];

  List<NotificationModel> filteredNotifications = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    filteredNotifications = allNotifications;
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _filterNotifications(String query) {
    setState(() {
      filteredNotifications = allNotifications
          .where((notification) =>
              notification.title.toLowerCase().contains(query.toLowerCase()) ||
              notification.description
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _buildNotificationList()),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationList() {
    return ListView.builder(
      itemCount: filteredNotifications.length,
      itemBuilder: (context, index) {
        final notification = filteredNotifications[index];
        return NotificationItem(
          notification: notification,
          onTap: () => _openNotificationDetails(notification),
        );
      },
    );
  }

  void _openNotificationDetails(NotificationModel notification) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            NotificationDetailsPage(notification: notification),
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  final VoidCallback onTap;

  const NotificationItem({
    Key? key,
    required this.notification,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildEmojiContainer(),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitle(),
                    SizedBox(height: 4),
                    Text(
                      notification.description,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 8),
                    _buildFooter(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmojiContainer() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Center(
        child: Text(notification.emoji, style: TextStyle(fontSize: 24)),
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      children: [
        Expanded(
          child: Text(
            notification.title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        if (!notification.isRead)
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
      ],
    );
  }

  Widget _buildFooter() {
    return Row(
      children: [
        Icon(Icons.access_time, size: 14, color: Colors.grey),
        SizedBox(width: 4),
        Text(
          notification.time,
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        Spacer(),
        _buildTypeChip(),
      ],
    );
  }

  Widget _buildTypeChip() {
    Color chipColor;
    String label;

    switch (notification.type) {
      case NotificationType.order:
        chipColor = Colors.green;
        label = 'Order';
        break;
      case NotificationType.delivery:
        chipColor = Colors.orange;
        label = 'Delivery';
        break;
      case NotificationType.promo:
        chipColor = Colors.purple;
        label = 'Promo';
        break;
      case NotificationType.feedback:
        chipColor = Colors.blue;
        label = 'Feedback';
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
            fontSize: 10, color: chipColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class NotificationDetailsPage extends StatelessWidget {
  final NotificationModel notification;

  const NotificationDetailsPage({Key? key, required this.notification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Notification Details'),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child:
                      Text(notification.emoji, style: TextStyle(fontSize: 40)),
                ),
              ),
            ),
            SizedBox(height: 24),
            Text(
              notification.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              notification.description,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Received: ${notification.time}',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 24),
            _buildActionButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    String buttonText;
    VoidCallback onPressed;

    switch (notification.type) {
      case NotificationType.order:
        buttonText = 'View Order';
        onPressed = () {
          // Navigate to order details
        };
        break;
      case NotificationType.delivery:
        buttonText = 'Track Delivery';
        onPressed = () {
          // Open delivery tracking
        };
        break;
      case NotificationType.promo:
        buttonText = 'Use Promo';
        onPressed = () {
          // Apply promo code
        };
        break;
      case NotificationType.feedback:
        buttonText = 'Leave Feedback';
        onPressed = () {
          // Open feedback form
        };
        break;
    }

    return SizedBox(
      width: double.infinity,

      child: ElevatedButton(
        child: Text(buttonText),
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}

class NotificationModel {
  final String id;
  final String emoji;
  final String title;
  final String description;
  final String time;
  final bool isRead;
  final NotificationType type;

  NotificationModel({
    required this.id,
    required this.emoji,
    required this.title,
    required this.description,
    required this.time,
    required this.isRead,
    required this.type,
  });
}

enum NotificationType {
  order,
  delivery,
  promo,
  feedback,
}
