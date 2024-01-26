import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
            Map<String, dynamic> data =
            doc.data() as Map<String, dynamic>;
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
    return InkWell(
      onTap: () {
        // Navigate to property details screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PropertyDetailsScreen(property: property),
          ),
        );
      },
      child: Card(
        elevation: 2.0,
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              height: 120.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: property.imageUrl != null
                      ? Image.network(property.imageUrl).image
                      : AssetImage('assets/default_image.jpg'),
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
      ),
    );
  }
}


class PropertyDetailsScreen extends StatelessWidget {
  final Property property;

  const PropertyDetailsScreen({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Property Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              property.imageUrl,
              height: 200.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property.propertyType,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.0),
                  Text('Location: ${property.district}',style: TextStyle(fontSize: 20),),
                  SizedBox(height: 8.0),
                  Row(
                    children: [
                      Icon(Icons.king_bed,size: 40,),
                      SizedBox(width: 8.0),
                      Text('Bedrooms: ${property.bedrooms}',style: TextStyle(fontSize: 15),),
                      SizedBox(width: 50.0),
                      Icon(Icons.bathtub,size: 40,),
                      SizedBox(width: 8.0),
                      Text('Bathrooms: ${property.bathrooms}',style: TextStyle(fontSize: 15),),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  _buildSectionHeader('Price Info',),
                  SizedBox(height: 8.0),
                  Text('Price(Monthly): ${property.price}',style: TextStyle(fontSize: 18),),
                  SizedBox(height: 16.0),
                  _buildSectionHeader('Location'),
                  SizedBox(height: 8.0),
                  Text('District: ${property.district}',style: TextStyle(fontSize: 20),),
                  Text('Area: ${property.area} sq. ft.',style: TextStyle(fontSize: 18),),
                  SizedBox(height: 16.0),
                  _buildSectionHeader('Facilities'),
                  SizedBox(height: 8.0),
                  Text('Facilities: ${property.facilities}',style: TextStyle(fontSize: 20),),
                  SizedBox(height: 16.0),
                  _buildSectionHeader('Contact'),
                  SizedBox(height: 5.0),
                  Text('Phone: ${property.phone}',style: TextStyle(fontSize: 20),),
                  SizedBox(height: 16.0),
                  _buildSectionHeader('Available From'),
                  SizedBox(height: 5.0),
                  Text('Available From: ${property.availableDate}',style: TextStyle(fontSize: 20),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
    );
  }
}


