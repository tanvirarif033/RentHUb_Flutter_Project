import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:gap/gap.dart';

import '../../../constants/images_strings.dart';

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
            Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: Image(image: AssetImage(wReview)),
              ),
            ),


            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
            Center(child: Text('Rating: $rating',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),)),
            SizedBox(height: 16.0),

            Card(
              //color: Colors.lightBlueAccent,
              shadowColor: Colors.black54,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        //fontSize: 18.0, // Set font size
                        //fontWeight: FontWeight.bold, // Set font weight
                      ),
                    ),
                    SizedBox(height: 16.0),
                    TextField(
                      controller: commentController,
                      decoration: InputDecoration(
                        labelText: ' Write a comment',
                        //fontSize: 18.0, // Set font size
                        //fontWeight: FontWeight.bold, // Set font weight
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 25.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (rating == 0.0 || usernameController.text.isEmpty || commentController.text.isEmpty) {
                    _showErrorDialog("Please fill the required fields");
                  } else {
                    _submitReview();
                    _saveReviewToFirebase();
                  }
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitReview() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text("Submitting review..."),
            ],
          ),
        );
      },
    );

    // Simulate an API call or any asynchronous operation
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context); // Close the AlertDialog

      // Show success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 50),
                SizedBox(height: 16),
                Text("Review submitted successfully"),


              ],

            ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the AlertDialog
                  },
                  child: Text("OK"),
                ),
              ]
          );
        },
      );

      // Clear input fields after submission
      usernameController.clear();
      commentController.clear();
      setState(() {
        rating = 0.0;
      });
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error, color: Colors.red, size: 50),
              SizedBox(height: 16),
              Text(message),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the AlertDialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
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

