import 'package:flutter/material.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/property_model.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/see_review.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/write_review.dart';
import 'package:gap/gap.dart';

import 'customer_info.dart';
class PropertyDetailsScreen extends StatelessWidget {
  final Property property;

  const PropertyDetailsScreen({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Property Details',style: TextStyle(fontSize: 25),),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 300.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: property.imageUrl != null && property.imageUrl.isNotEmpty
                        ? NetworkImage(property.imageUrl!) // Explicitly cast to String
                        : AssetImage('assets/logo/renthub.png') as ImageProvider<Object>,
                    fit: BoxFit.cover,
                  ),
                ),
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
                    Text('Location: ${property.district}', style: TextStyle(fontSize: 20)),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Icon(Icons.king_bed, size: 40),
                        SizedBox(width: 8.0),
                        Text('Bedrooms: ${property.bedrooms}', style: TextStyle(fontSize: 15)),
                        SizedBox(width: 50.0),
                        Icon(Icons.bathtub, size: 40),
                        SizedBox(width: 8.0),
                        Text('Bathrooms: ${property.bathrooms}', style: TextStyle(fontSize: 15)),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    _buildSection('Price Info', 'Price(Monthly): ${property.price}', 18),
                    _buildSection('Location', 'District: ${property.district}\nArea: ${property.area} ', 20),
                    _buildSection('Facilities', 'Facilities: ${property.facilities}', 20),
                    _buildSection('Contact', 'Phone: ${property.phone}', 20),
                    _buildSection('Available From', 'Available From: ${property.availableDate}', 20),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Add your button click logic here
                            // For example, you can navigate to another screen or perform an action
                            Navigator.push(context,

                              MaterialPageRoute(builder: (context)=>  WriteReview(),),

                            );
                          },
                          child: Text('Give Review'),
                        ),
                        Gap(10),

                        ElevatedButton(
                          onPressed: () {
                            // Add your button click logic here
                            // For example, you can navigate to another screen or perform an action
                            Navigator.push(context,

                              MaterialPageRoute(builder: (context)=>  SeeReviewScreen(),),

                            );
                          },
                          child: Text('See Review'),
                        ),
                        Gap(10),

                        ElevatedButton(
                          onPressed: () {
                            // Add your button click logic here
                            // For example, you can navigate to another screen or perform an action
                            Navigator.push(context,

                              MaterialPageRoute(builder: (context)=>  CustomerInfoScreen(),),

                            );
                          },
                          child: Text('Advance Payment'),
                        ),

                      ],
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content, double fontSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Text(
          content,
          style: TextStyle(fontSize: fontSize),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}
