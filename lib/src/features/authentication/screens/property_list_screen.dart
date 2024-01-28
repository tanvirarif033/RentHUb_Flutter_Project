import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/property_model.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/property_tile.dart';

import 'about_us_screen.dart';
import 'category_screen.dart';

class PropertyListScreen extends StatefulWidget {
  PropertyListScreen({Key? key}) : super(key: key);

  @override
  _PropertyListScreenState createState() => _PropertyListScreenState();
}

class _PropertyListScreenState extends State<PropertyListScreen> {
  final CollectionReference _propertyCollection =
  FirebaseFirestore.instance.collection('properties');

  List<String> catNames = [
    'Family',
    'Bachelor',
    'Office',
    'Sublet',
    'Hostel',
    'More..'
  ];
  List<Color> catColors = [
    Colors.black87,
    Colors.black87,
    Colors.black87,
    Colors.black87,
    Colors.black87,
    Colors.black87,
  ];
  List<Icon> catIcons = [
    Icon(Icons.people, color: Colors.white, size: 30),
    Icon(Icons.person, color: Colors.white, size: 30),
    Icon(Icons.work, color: Colors.white, size: 30),
    Icon(Icons.apartment, color: Colors.white, size: 30),
    Icon(Icons.hotel, color: Colors.white, size: 30),
    Icon(Icons.more_horiz_outlined, color: Colors.white, size: 30),
  ];

  List<Property> allProperties = [];
  List<Property> filteredProperties = [];
  TextEditingController _areaController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _propertyCollection.snapshots().listen((snapshot) {
      if (snapshot.docs.isNotEmpty) {
        allProperties = snapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return Property.fromDocument(data);
        }).toList();

        _updateProperties(allProperties);
      }
    });
  }

  // Method to update the list of filtered properties
  void _updateProperties(List<Property> properties) {
    setState(() {
      filteredProperties = properties;
    });
  }

  void _filterPropertiesByCategory(String category) {
    List<Property> filteredProperties = allProperties
        .where((property) => property.propertyType == category)
        .toList();
    _updateProperties(filteredProperties);
  }

  void _filterPropertiesByArea(String area) {
    List<Property> filteredProperties = allProperties
        .where((property) => property.area.toLowerCase() == area.toLowerCase())
        .toList();
    _updateProperties(filteredProperties);
  }

  void _handleTap(String category) {
    print('Pressed: $category');
    List<Property> categoryProperties = allProperties
        .where((property) => property.propertyType == category)
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryPropertiesScreen(
          categoryName: category,
          properties: categoryProperties,
        ),
      ),
    );
  }

  // Function to show the search dialog
  void _showSearchByAreaDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Search by Area"),
          content: TextField(
            controller: _areaController,
            decoration: InputDecoration(
              hintText: "Enter Area Name",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _filterPropertiesByArea(_areaController.text);
                Navigator.pop(context); // Close the dialog
              },
              child: Text("Search"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Categories',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.4,
                    ),
                    itemCount: catNames.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _handleTap(catNames[index]);
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  color: catColors[index],
                                  shape: BoxShape.rectangle),
                              child: Center(
                                child: catIcons[index],
                              ),
                            ),
                            Text(
                              catNames[index],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10,),
                  ElevatedButton(
                    onPressed: () {
                      _showSearchByAreaDialog(context);
                    },
                    child: Text("Search by Area"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10,),

            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Recent Posts',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),
              ),
            ),
            const SizedBox(height: 15,),

            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: filteredProperties.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                Property property = filteredProperties[index];
                return PropertyTile(property: property);
              },
            ),
          ],
        ),
      ),
    );
  }
}
