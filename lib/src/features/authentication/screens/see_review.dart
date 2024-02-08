import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../constants/images_strings.dart';

class SeeReviewScreen extends StatelessWidget {
  const SeeReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('See Review', style: TextStyle(color: Colors.white)),
      ),
      body:
      Column(

        children: [
          Center(
            child: SizedBox(
              width: 300,
              height: 300,
              child: Image(image: AssetImage(tReview)),
            ),
          ),
          Expanded(
            child: _buildReviewsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('reviews').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No reviews available.'));
        }

        return ListView(
          padding: EdgeInsets.all(16.0),
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            String username = data['username'];
            String comment = data['comment'];
            double rating = data['rating'];

            return Card(
              elevation: 3.0,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    SizedBox(height: 8.0),

                    SizedBox(height: 8.0),
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
                      onRatingUpdate: (double value) {  },
                    ),
                    SizedBox(height: 8.0),
                    Text('Rating: $rating',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20)),
                    SizedBox(height: 8.0,),
                    Text('Name: $username',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20)),
                    SizedBox(height: 8.0),
                    Text('Comment: $comment',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20)),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}


