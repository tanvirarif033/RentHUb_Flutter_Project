import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ThemeModeProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: FavoriteList(),
    );
  }
}

class FavoriteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('favorites').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var favoriteItem = snapshot.data!.docs[index];

            // Get property details from the favorite item
            var propertyId = favoriteItem.id;
            var timestamp = favoriteItem['timestamp'];

            // Additional property details from Firestore
            var bedrooms = favoriteItem['bedrooms'];
            var bathrooms = favoriteItem['bathrooms'];
            var price = favoriteItem['price'];
            var district = favoriteItem['district'];
            var area = favoriteItem['area'];
            var phone = favoriteItem['phone'];
            var facilities = favoriteItem['facilities'];
            var propertyType = favoriteItem['propertyType'];

            // Check if all required fields are present in the document
            if (bedrooms == null ||
                bathrooms == null ||
                price == null ||
                district == null ||
                area == null ||
                phone == null ||
                facilities == null ||
                propertyType == null) {
              return ListTile(
                title: Text('Favorite Property ID: $propertyId'),
                subtitle: Text('Incomplete or missing data'),
              );
            }

            return Card(
              margin: EdgeInsets.all(8.0),
              child: ListTile(
                title: Text('Favorite Property ID: $propertyId'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Timestamp: $timestamp'),
                    Text('Bedrooms: $bedrooms'),
                    Text('Bathrooms: $bathrooms'),
                    Text('Price: $price'),
                    Text('District: $district'),
                    Text('Area: $area'),
                    Text('Phone: $phone'),
                    Text('Facilities: $facilities'),
                    Text('Property Type: $propertyType'),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _removeFromFavorites(propertyId);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _removeFromFavorites(String propertyId) {
    // Implement logic to remove from favorites in the database
    // You can use the propertyId to identify the document to remove
    FirebaseFirestore.instance.collection('favorites').doc(propertyId).delete();
  }
}



