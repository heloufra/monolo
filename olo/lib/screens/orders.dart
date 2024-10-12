import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Orders', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildOrderItem(
            context,
            'French Riviera Bistro',
            '19 October 2023 at 12:46',
            'In Preparation',
            Colors.green[100]!,
            Colors.teal,
          ),
          SizedBox(height: 16),
          _buildOrderItem(
            context,
            'Farm to Table Kitchen',
            '25 October 2023 at 14:21',
            'Delivered',
            Colors.grey[200]!,
            Colors.blue,
          ),
          SizedBox(height: 16),
          _buildOrderItem(
            context,
            'The Green Leaf Grill',
            '27 October 2023 at 13:34',
            'Canceled',
            Colors.grey[200]!,
            Colors.purple,
          ),
          SizedBox(height: 16),
          _buildOrderItem(
            context,
            'Mediterranean Delights',
            '27 October 2023 at 12:55',
            'Picked up',
            Colors.grey[200]!,
            Colors.indigo,
          ),
          SizedBox(height: 16),
          _buildOrderItem(
            context,
            'Farm to Table Kitchen',
            '21 October 2023 at 15:13',
            'Delivered',
            Colors.grey[200]!,
            Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(BuildContext context, String restaurantName, String date, String status, Color statusColor, Color logoColor) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: logoColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            restaurantName[0],
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      title: Text(restaurantName, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4),
          Text(date, style: TextStyle(color: Colors.grey)),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(status, style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
      // trailing: Icon(Icons.arrow_forward_ios, size: 16),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade200, width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
      onTap: () {
       context.go('/orders/details');
      },
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }
}

class OrderDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Order Details', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text('F', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Fish Magic Burritos', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('29 October 2023 at 19:58', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
            OrderStatusTimeline(),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  OrderItem(quantity: 1, name: 'Burrito Pulled Chicken Tinga', description: 'With chili flakes, With guacamole'),
                  OrderItem(quantity: 1, name: 'Burrito Pulled Chicken Tinga', description: 'With chili flakes, With guacamole'),
                  OrderItem(quantity: 2, name: 'Burrito Pulled Chicken Tinga', description: 'With guacamole'),
                  SizedBox(height: 16),
                  Divider(),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
                      Text('79.00 Dhs', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
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

class OrderStatusTimeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          StatusItem(status: 'Confirmed', time: '12:25', description: 'Your order is confirmed.', isCompleted: true),
          StatusItem(status: 'In Preparation', time: '12:25', description: 'Your order is in preparation.', isCompleted: true, isCurrent: true),
          StatusItem(status: 'On Delivery', time: '12:35', description: 'Your order is being delivered.', isCompleted: false),
          StatusItem(status: 'Delivered', time: '12:45', description: 'Your order is delivered.', isCompleted: false, isLast: true),
        ],
      ),
    );
  }
}

class StatusItem extends StatelessWidget {
  final String status;
  final String time;
  final String description;
  final bool isCompleted;
  final bool isCurrent;
  final bool isLast;

  const StatusItem({
    required this.status,
    required this.time,
    required this.description,
    this.isCompleted = false,
    this.isCurrent = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted ? Colors.blue : (isCurrent ? Colors.white : Colors.grey[300]),
                border: Border.all(color: isCurrent ? Colors.blue : Colors.transparent, width: 2),
              ),
              child: isCompleted ? Icon(Icons.check, size: 12, color: Colors.white) : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 30,
                color: Colors.grey[300],
              ),
          ],
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(status, style: TextStyle(fontWeight: FontWeight.bold)),
              Text('$time - $description', style: TextStyle(color: Colors.grey)),
              SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }
}

class OrderItem extends StatelessWidget {
  final int quantity;
  final String name;
  final String description;

  const OrderItem({
    required this.quantity,
    required this.name,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$quantity', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(description, style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}