// Sample Review Screen (create_review_screen.dart)

// Import necessary packages

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/property_model.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/review_model.dart';

class CreateReviewScreen extends StatefulWidget {
  final Property property;

  const CreateReviewScreen({Key? key, required this.property}) : super(key: key);

  @override
  _CreateReviewScreenState createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  String userName = '';
  String comment = '';
  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Write a Review'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) => userName = value,
              decoration: InputDecoration(labelText: 'Your Name'),
            ),
            TextField(
              onChanged: (value) => comment = value,
              decoration: InputDecoration(labelText: 'Your Comment'),
            ),
            Slider(
              value: rating,
              onChanged: (value) => setState(() => rating = value),
              min: 0,
              max: 5,
              divisions: 5,
              label: rating.toString(),
            ),
            ElevatedButton(
              onPressed: () {
                // Save the review to the database
                Review newReview = Review(userName: userName, comment: comment, rating: rating);
                // Add logic to save the review to the property in the database
                // You may use a provider or other state management solution
                // Consider using a service to handle database operations
                Navigator.pop(context); // Close the review screen after saving
              },
              child: Text('Submit Review'),
            ),
          ],
        ),
      ),
    );
  }
}
