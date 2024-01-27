import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/property_model.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/property_tile.dart';

import 'about_us_screen.dart';

class PropertyListScreen extends StatefulWidget {
   PropertyListScreen({Key? key}) : super(key: key);



  @override
  _PropertyListScreenState createState() => _PropertyListScreenState();
}

class _PropertyListScreenState extends State<PropertyListScreen> {
  final CollectionReference _propertyCollection =
  FirebaseFirestore.instance.collection('properties');

  List<String> catNames = ['Family', 'Bachelor', 'Office', 'Sublet', 'Hostel', 'More..'];
  List<Color> catColors = [
    Colors.blue, Colors.green, Colors.orange, Colors.red, Colors.purple, Colors.yellow,
  ];
  List<Icon> catIcons = [
    Icon(Icons.people),
    Icon(Icons.person),
    Icon(Icons.work),
    Icon(Icons.apartment),
    Icon(Icons.hotel),
    Icon(Icons.more),
  ];

  void _handleTap(String category) {
    // You can replace this with your actual navigation logic
    print('Pressed: $category');
    switch (category) {
      case 'Family':
        Navigator.push(context, MaterialPageRoute(builder: (context) => about_us_screen()));
        break;
      case 'Bachelor':
        Navigator.push(context, MaterialPageRoute(builder: (context) => about_us_screen()));
        break;
      case 'Office':
        Navigator.push(context, MaterialPageRoute(builder: (context) => about_us_screen()));
        break;
      case 'Sublet':
        Navigator.push(context, MaterialPageRoute(builder: (context) => about_us_screen()));
        break;
      case 'Hostel':
        Navigator.push(context, MaterialPageRoute(builder: (context) => about_us_screen()));
        break;
      case 'More..':
        Navigator.push(context, MaterialPageRoute(builder: (context) => about_us_screen()));
        break;
    }
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
                    child: Text('Categories', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),),
                  ),
                  const SizedBox(height: 20),

                  GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.3,
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
                                shape: BoxShape.circle,
                              ),
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


                ],
              ),
            ),
            const SizedBox(height: 10,),
            const Align(
              alignment: Alignment.topLeft,
              child: Text('Recent Posts', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),),
            ),
            const SizedBox(height: 15,),
            StreamBuilder<QuerySnapshot>(
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
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    Property property = properties[index];
                    return PropertyTile(property: property);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
