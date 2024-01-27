import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/property_details_screen.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/property_model.dart';

class PropertyListScreen extends StatefulWidget {
  const PropertyListScreen({Key? key}) : super(key: key);

  @override
  _PropertyListScreenState createState() => _PropertyListScreenState();
}

class _PropertyListScreenState extends State<PropertyListScreen> {
  final CollectionReference _propertyCollection =
  FirebaseFirestore.instance.collection('properties');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: _propertyCollection.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            List<Property> properties = snapshot.data!.docs.map((doc) {
              Map<String, dynamic> data =
              doc.data() as Map<String, dynamic>;
              return Property.fromDocument(data);
            }).toList();

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: properties.length,
              itemBuilder: (context, index) {
                Property property = properties[index];
                return PropertyTile(property: property);
              },
            );
          },
        ),
      ),
    );
  }
}

class PropertyTile extends StatelessWidget {
  final Property property;

  const PropertyTile({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PropertyDetailsScreen(property: property),
          ),
        );
      },
      child: Card(
        color: Colors.black87,
        elevation: 3.0,
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              height: 120.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: property.imageUrl != null && property.imageUrl.isNotEmpty
                      ? Image.network(property.imageUrl).image
                      : const AssetImage('assets/logo/renthub.png',),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property.propertyType,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
                  ),
                  const SizedBox(height: 2.0),
                  Text('Location: ${property.district} , ${property.area}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white),),
                  Text('Price : BDT ${property.price}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}