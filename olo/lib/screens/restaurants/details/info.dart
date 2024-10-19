
import 'package:flutter/material.dart';
import 'package:olo/models/restaurant.dart';

class RestaurantInfoWidget extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantInfoWidget({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(restaurant.pictures?.first ?? 'https://via.placeholder.com/60?text=Logo'),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(restaurant.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildInfoChip('Free Delivery', Colors.green[50]!, Colors.green[700]!),
                    _buildInfoChip('20-35 min', Colors.grey[200]!, Colors.black),
                    _buildInfoChip('246 meters', Colors.grey[200]!, Colors.black),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label, Color backgroundColor, Color textColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
