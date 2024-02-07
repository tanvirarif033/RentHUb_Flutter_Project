import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/property_model.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/property_tile.dart';

class FavoritePropertiesPage extends StatefulWidget {
  @override
  _FavoritePropertiesPageState createState() => _FavoritePropertiesPageState();
}

class _FavoritePropertiesPageState extends State<FavoritePropertiesPage> {
  List<Property> favoriteProperties = [];

  @override
  void initState() {
    super.initState();

    FirebaseFirestore.instance
        .collection('Favourites')
        .snapshots()
        .listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        List<Property> fetchedProperties = snapshot.docs
            .map((doc) => Property.fromDocument(doc.data()))
            .toList();

        setState(() {
          favoriteProperties = fetchedProperties;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: favoriteProperties.length,
        itemBuilder: (context, index) {
          return PropertyTile(property: favoriteProperties[index]);
        },
      ),
    );
  }
}
