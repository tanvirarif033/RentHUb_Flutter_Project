import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/property_model.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/see_review.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/write_review.dart';
import 'package:gap/gap.dart';

import 'customer_info.dart';

class PropertyDetailsScreen extends StatefulWidget {
  final Property property;

  const PropertyDetailsScreen({Key? key, required this.property})
      : super(key: key);

  @override
  _PropertyDetailsScreenState createState() => _PropertyDetailsScreenState();
}

class _PropertyDetailsScreenState extends State<PropertyDetailsScreen> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _fetchFavoriteStatus();
  }

  void _fetchFavoriteStatus() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Favourites')
          .where('propertyType', isEqualTo: widget.property.propertyType)
          .where('price', isEqualTo: widget.property.price)
          .where('bedrooms', isEqualTo: widget.property.bedrooms)
          .where('bathrooms', isEqualTo: widget.property.bathrooms)
          .where('district', isEqualTo: widget.property.district)
          .where('area', isEqualTo: widget.property.area)
          .where('phone', isEqualTo: widget.property.phone)
          .where('facilities', isEqualTo: widget.property.facilities)
          .where('imageUrl', isEqualTo: widget.property.imageUrl)
          .where('availableDate', isEqualTo: widget.property.availableDate)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // If the property exists in the favorites collection, set isFavorite to true
        setState(() {
          isFavorite = true;
        });
      }
    } catch (e) {
      print('Error fetching favorite status: $e');
      // Handle error fetching favorite status
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Property Details',
            style: TextStyle(fontSize: 25),
          ),
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
                    image: widget.property.imageUrl != null &&
                        widget.property.imageUrl.isNotEmpty
                        ? NetworkImage(widget.property.imageUrl!)
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
                    Row(
                      children: [
                        Text(widget.property.propertyType,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: _toggleFavorite,
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : null,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.0),
                    Text('Location: ${widget.property.district}',
                        style: TextStyle(fontSize: 20)),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Icon(Icons.king_bed, size: 40),
                        SizedBox(width: 8.0),
                        Text('Bedrooms: ${widget.property.bedrooms}',
                            style: TextStyle(fontSize: 15)),
                        SizedBox(width: 50.0),
                        Icon(Icons.bathtub, size: 40),
                        SizedBox(width: 8.0),
                        Text('Bathrooms: ${widget.property.bathrooms}',
                            style: TextStyle(fontSize: 15)),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    _buildSection('Price Info',
                        'Price(Monthly): ${widget.property.price}', 18),
                    _buildSection('Location',
                        'District: ${widget.property.district}\nArea: ${widget
                            .property.area} ', 20),
                    _buildSection('Facilities',
                        'Facilities: ${widget.property.facilities}', 20),
                    _buildSection(
                        'Contact', 'Phone: ${widget.property.phone}', 20),
                    _buildSection('Available From',
                        'Available From: ${widget.property.availableDate}', 20),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Add your button click logic here
                            // For example, you can navigate to another screen or perform an action
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WriteReview(),
                              ),
                            );
                          },
                          child: Text('Give Review'),
                        ),
                        Gap(10),
                        ElevatedButton(
                          onPressed: () {
                            // Add your button click logic here
                            // For example, you can navigate to another screen or perform an action
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SeeReviewScreen(),
                              ),
                            );
                          },
                          child: Text('See Review'),
                        ),
                        Gap(10),
                        ElevatedButton(
                          onPressed: () {
                            // Add your button click logic here
                            // For example, you can navigate to another screen or perform an action
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CustomerInfoScreen(),
                              ),
                            );
                          },
                          child: const Text('Advance Payment'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    // Favorite Button
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

  void _toggleFavorite() {
    setState(() {
      // Toggle the favorite status
      isFavorite = !isFavorite;
      // Update the property's isFavorite status
      widget.property.isFavorite = isFavorite;
      // Update the favorite status in Firebase or your preferred storage mechanism
      // Here, you can call a function to update the property's favorite status in your database

      // Show SnackBar
      final snackBar = SnackBar(
        content: Text(
            isFavorite ? 'Added to favorites' : 'Removed from favorites'),
        duration: Duration(seconds: 1), // Adjust duration as needed
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);

      // Save or remove property information to/from Firebase based on favorite status
      if (isFavorite) {
        _saveToFavourites();
      } else {
        _removeFromFavourites();
      }
    });
  }

  void _removeFromFavourites() async {
    try {
      // Find and delete the document with the property information from "Favourites" collection
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Favourites')
          .where('propertyType', isEqualTo: widget.property.propertyType)
          .where('price', isEqualTo: widget.property.price)
          .where('bedrooms', isEqualTo: widget.property.bedrooms)
          .where('bathrooms', isEqualTo: widget.property.bathrooms)
          .where('district', isEqualTo: widget.property.district)
          .where('area', isEqualTo: widget.property.area)
          .where('phone', isEqualTo: widget.property.phone)
          .where('facilities', isEqualTo: widget.property.facilities)
          .where('imageUrl', isEqualTo: widget.property.imageUrl)
          .where('availableDate', isEqualTo: widget.property.availableDate)
          .get();

      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    } catch (e) {
      print('Error removing from favourites: $e');
      // Handle error removing from favourites
    }
  }


  void _saveToFavourites() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Favourites')
          .where('propertyType', isEqualTo: widget.property.propertyType)
          .where('price', isEqualTo: widget.property.price)
          .where('bedrooms', isEqualTo: widget.property.bedrooms)
          .where('bathrooms', isEqualTo: widget.property.bathrooms)
          .where('district', isEqualTo: widget.property.district)
          .where('area', isEqualTo: widget.property.area)
          .where('phone', isEqualTo: widget.property.phone)
          .where('facilities', isEqualTo: widget.property.facilities)
          .where('imageUrl', isEqualTo: widget.property.imageUrl)
          .where('availableDate', isEqualTo: widget.property.availableDate)
          .get();

      if (querySnapshot.docs.isEmpty) {
        await FirebaseFirestore.instance.collection('Favourites').add({
          'propertyType': widget.property.propertyType,
          'price': widget.property.price,
          'bedrooms': widget.property.bedrooms,
          'bathrooms': widget.property.bathrooms,
          'district': widget.property.district,
          'area': widget.property.area,
          'phone': widget.property.phone,
          'facilities': widget.property.facilities,
          'imageUrl': widget.property.imageUrl,
          'availableDate': widget.property.availableDate,
        });
      } else {
        print('Property already exists in favorites');
      }
    } catch (e) {
      print('Error saving to favourites: $e');
    }
  }
}
