import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';

class WriteReview extends StatefulWidget {
  const WriteReview({Key? key}) : super(key: key);

  @override
  _WriteReviewState createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  double rating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Write Review', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: commentController,
              decoration: InputDecoration(labelText: 'Comment'),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text('Rating:'),
                SizedBox(width: 8.0),
                RatingBar.builder(
                  initialRating: rating,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 30.0,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (newRating) {
                    setState(() {
                      rating = newRating;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Save data to Firebase
                _saveReviewToFirebase();

                // Clear input fields after submission
                usernameController.clear();
                commentController.clear();
                setState(() {
                  rating = 0.0;
                });
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveReviewToFirebase() {
    // Get a Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Add a new document with user input to a collection named 'reviews'
    firestore.collection('reviews').add({
      'username': usernameController.text,
      'comment': commentController.text,
      'rating': rating,
      'timestamp': FieldValue.serverTimestamp(),
    }).then((value) {
      print('Review added to Firebase with ID: ${value.id}');
    }).catchError((error) {
      print('Error adding review to Firebase: $error');
    });
  }
}
