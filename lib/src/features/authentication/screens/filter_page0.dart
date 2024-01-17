import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gap/gap.dart';
import 'package:rent_hub_flutter_project/src/constants/text_strings.dart';
import 'package:toggle_switch/toggle_switch.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final TextEditingController _propertyTypeController = TextEditingController();
  final TextEditingController _bedroomsController = TextEditingController();
  final TextEditingController _bathroomsController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  // Firestore reference
  final CollectionReference _propertyCollection =
  FirebaseFirestore.instance.collection('properties');

  List<QueryDocumentSnapshot> _filteredProperties = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter Properties'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _propertyTypeController,
              decoration: InputDecoration(labelText: 'Property Type'),
            ),
            TextFormField(
              controller: _bedroomsController,
              decoration: InputDecoration(labelText: 'Bedrooms'),
            ),
            TextFormField(
              controller: _bathroomsController,
              decoration: InputDecoration(labelText: 'Bathrooms'),
            ),
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            Gap(20),
            ElevatedButton(
              onPressed: () {
                _searchProperties();
              },
              child: Text('Search'),
            ),
            Gap(20),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredProperties.length,
                itemBuilder: (context, index) {
                  return Card(
                    // Customize the card UI based on your data
                    child: ListTile(
                      title: Text(
                        _filteredProperties[index]['propertyType'],
                        // Access other fields similarly
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _searchProperties() async {
    // Get the values from controllers
    String propertyType = _propertyTypeController.text;
    String bedrooms = _bedroomsController.text;
    String bathrooms = _bathroomsController.text;
    String location = _locationController.text;

    // Perform a query to get matching properties
    QuerySnapshot querySnapshot = await _propertyCollection
        .where('propertyType', isEqualTo: propertyType)
        .where('bedrooms', isEqualTo: bedrooms)
        .where('bathrooms', isEqualTo: bathrooms)
        .where('location', isEqualTo: location)
        .get();

    setState(() {
      _filteredProperties = querySnapshot.docs;
    });
  }
}
