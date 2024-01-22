import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../constants/sizes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _value = 1;
  @override
  void initState() {
    super.initState();
    _value = 1; // Set an initial value
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PropertyList(),




    );
  }
}
class PropertyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('properties').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text("Loading..."),
              ],
            ),
          );
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var property = snapshot.data!.docs[index];
            return PropertyCard(property: property);
          },
        );
      },
    );
  }
}
class PropertyCard extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> property;

  PropertyCard({required this.property});

  @override
  Widget build(BuildContext context) {
    // Cast property.data() to Map<String, dynamic>?
    final Map<String, dynamic>? data = property.data() as Map<String, dynamic>?;

    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text('Property Type: ${property['propertyType']}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bedrooms: ${property['bedrooms']}'),
            Text('Bathrooms: ${property['bathrooms']}'),
            // Check if 'price' field exists before accessing its value
            if (data?.containsKey('price') ?? false) Text('Price: ${property['price']}'),
            // Check if 'district' field exists before accessing its value
            if (data?.containsKey('district') ?? false) Text('District: ${property['district']}'),

            if (data?.containsKey('area') ?? false) Text('Area: ${property['area']}'),

            if (data?.containsKey('availableDate') ?? false) Text('availableDate: ${property['availableDate']}'),

            if (data?.containsKey('phone') ?? false) Text('Phone: ${property['phone']}'),
            if (data?.containsKey('facilities') ?? false) Text('facilities: ${property['facilities']}'),

          ],
        ),
      ),
    );
  }
}


