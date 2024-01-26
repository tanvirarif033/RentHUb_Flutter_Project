import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Property {
  final String propertyType;
  final String price;
  final String bedrooms;
  final String bathrooms;
  final String district;
  final String area;
  final String phone;
  final String facilities;
  final String imageUrl;
  final String availableDate;

  Property({
    required this.propertyType,
    required this.price,
    required this.bedrooms,
    required this.bathrooms,
    required this.district,
    required this.area,
    required this.phone,
    required this.facilities,
    required this.imageUrl,
    required this.availableDate,
  });

  // Factory method to create Property from Firestore document data
  factory Property.fromDocument(Map<String, dynamic> data) {
    return Property(
      propertyType: data['propertyType'] ?? '',
      price: data['price'] ?? '',
      bedrooms: data['bedrooms'] ?? '',
      bathrooms: data['bathrooms'] ?? '',
      district: data['district'] ?? '',
      area: data['area'] ?? '',
      phone: data['phone'] ?? '',
      facilities: data['facilities'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      availableDate: data['availableDate'] ?? '',
    );
  }
}

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

      body: StreamBuilder<QuerySnapshot>(
        stream: _propertyCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          List<Property> properties = snapshot.data!.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return Property.fromDocument(data);
          }).toList();

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
    );
  }
}

class PropertyTile extends StatelessWidget {
  final Property property;

  const PropertyTile({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: 120.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: property.imageUrl != null
                    ? NetworkImage(property.imageUrl) as ImageProvider<Object>
                    : AssetImage('assets/images/welcome.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  property.propertyType,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4.0),
                Text('Location: ${property.district}'),
                Text('Price: ${property.price}'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
