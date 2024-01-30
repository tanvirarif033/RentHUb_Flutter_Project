import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:rent_hub_flutter_project/src/features/authentication/screens/about_us_screen.dart';
import 'property_list_screen.dart'; // Assuming you have a file named property_list_screen.dart


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _value = 1;

  @override
  void initState() {
    super.initState();
  }


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
        child: Padding(
          padding: const EdgeInsets.only(right: 15, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
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
                      // Handle tap action for the icon
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
                        // SizedBox(height: 10,), // Adjust spacing if needed
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
              SizedBox(height: 20), // Add space between Categories and Recent Posts
              const Text(
                'Recent Posts', // Add this header
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: PropertyListScreen(),
              ), // Add your Recent Posts content here
            ],
          ),

        ),
      ),
    );
  }
}

class FavoriteListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView.builder(
        itemCount: favoriteList.length,
        itemBuilder: (context, index) {
          var property = favoriteList[index];
          return FavoriteListItem(property: property);
        },
      ),
    );
  }
}

class FavoriteListItem extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> property;

  FavoriteListItem({required this.property});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        title: Text(
          'Property Type: ${property['propertyType']}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text('Bedrooms: ${property['bedrooms']}'),
            Text('Bathrooms: ${property['bathrooms']}'),
            Text('Price: ${property['price']}'),
            Text('District: ${property['district']}'),
            Text('Area: ${property['area']}'),
            Text('Phone: ${property['phone']}'),
            Text('Available Date: ${property['availableDate']}'),
            Text('Facilities: ${property['facilities']}'),


            SizedBox(height: 8),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            // Remove item from the favorite list
            favoriteList.remove(property);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Removed from favorites'),
                duration: Duration(seconds: 2),
              ),
            );
          },
        ),
      ),
    );
  }
}

List<QueryDocumentSnapshot<Object?>> favoriteList = [];

void main() {
  runApp(
    MaterialApp(
      home: HomeScreen(),
      routes: {
        '/favorites': (context) => FavoriteListScreen(),
      },
    ),
  );
}
class ViewPhotosScreen extends StatelessWidget {
  final QueryDocumentSnapshot<Object?> property;

  ViewPhotosScreen({required this.property});

  @override
  Widget build(BuildContext context) {
    final String? imageUrl = property['imageUrl'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Property Photo'),
      ),
      body: imageUrl != null
          ? Image.network(
        imageUrl,
        fit: BoxFit.cover,
      )
          : Center(
        child: Text('No photo available'),
      ),
    );
  }
}