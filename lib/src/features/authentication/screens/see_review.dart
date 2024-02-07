import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SeeReviewScreen extends StatelessWidget {
  const SeeReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('See Review', style: TextStyle(color: Colors.white)),
      ),
      body: _buildReviewsList(),
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
                    Text('Username: $username'),
                    SizedBox(height: 8.0),
                    Text('Comment: $comment'),
                    SizedBox(height: 8.0),
                    Text('Rating: $rating'),
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
