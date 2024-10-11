import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:olo/models/mockRestaurants.dart';
import 'package:olo/models/review.dart';

class ReviewsTab extends StatelessWidget {
  final String restaurantId;

  ReviewsTab({required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Review>>(
      future: MockDataService.getReviews(restaurantId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // showToast(context, 'Error', 'Failed to fetch reviews', ToastificationType.error);
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No reviews yet'));
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final review = snapshot.data![index];
              return ReviewWidget(review: review);
            },
          );
        }
      },
    );
  }
}

class ReviewWidget extends StatelessWidget {
  final Review review;

  ReviewWidget({required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'User ${review.userId}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < review.rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                    );
                  }),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(review.comment),
            SizedBox(height: 8),
            Text(
              'Posted on ${review.createdAt.toString().split(' ')[0]}',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}