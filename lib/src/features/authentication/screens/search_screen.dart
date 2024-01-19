import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rent_hub_flutter_project/src/constants/text_strings.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final TextEditingController _propertyTypeController = TextEditingController();
  final TextEditingController _bedroomsController = TextEditingController();
  final TextEditingController _bathroomsController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();

  final CollectionReference _propertyCollection =
  FirebaseFirestore.instance.collection('properties');

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
            TextField(
              controller: _propertyTypeController,
              decoration: InputDecoration(labelText: 'Property Type'),
            ),
            TextField(
              controller: _bedroomsController,
              decoration: InputDecoration(labelText: 'Bedrooms'),
            ),
            TextField(
              controller: _bathroomsController,
              decoration: InputDecoration(labelText: 'Bathrooms'),
            ),
            TextField(
              controller: _districtController,
              decoration: InputDecoration(labelText: 'District'),
            ),
            TextField(
              controller: _areaController,
              decoration: InputDecoration(labelText: 'Area'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _searchProperties();
              },
              child: Text('Search'),
            ),
          ],
        ),
      ),
    );
  }

  void _searchProperties() async {
    String propertyType = _propertyTypeController.text;
    String bedrooms = _bedroomsController.text;
    String bathrooms = _bathroomsController.text;
    String district = _districtController.text;
    String area = _areaController.text;

    // Perform a query based on user input
    QuerySnapshot querySnapshot = await _propertyCollection
        .where('propertyType', isEqualTo: propertyType)
        .where('bedrooms', isEqualTo: bedrooms)
        .where('bathrooms', isEqualTo: bathrooms)
        .where('district', isEqualTo: district)
        .where('area', isEqualTo: area)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Display the result
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ResultsDialog(querySnapshot: querySnapshot);
        },
      );
    } else {
      // No matching properties found
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('No Results'),
            content: Text('No properties match the search criteria.'),
          );
        },
      );
    }
  }
}

class ResultsDialog extends StatelessWidget {
  final QuerySnapshot querySnapshot;

  const ResultsDialog({Key? key, required this.querySnapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Search Result'),
      content: Column(
        children: querySnapshot.docs
            .map((DocumentSnapshot document) => _buildPropertyCard(document))
            .toList(),
      ),
    );
  }

  Widget _buildPropertyCard(DocumentSnapshot document) {
    // Customize this based on your database structure
    // For example, assuming each document has fields like 'propertyType', 'bedrooms', 'bathrooms', 'district', 'area', 'phone', 'image'
    String propertyType = document['propertyType'];
    String bedrooms = document['bedrooms'];
    String bathrooms = document['bathrooms'];
    String district = document['district'];
    String area = document['area'];
    String price = document['price'];
    String phone = document['phone'];
    // String imageUrl = document['image'];

    return Card(
      child: Column(
        children: [
          // Image.network(imageUrl), // Assuming the image is stored as a URL in the database
          ListTile(
            title: Text('Property Type: $propertyType'),
            subtitle: Text('Bedrooms: $bedrooms, Bathrooms: $bathrooms, District: $district, Area: $area,Price: $price'),
          ),
          ListTile(

            title: Text('Phone: $phone'),
          ),
        ],
      ),
    );
  }
}
