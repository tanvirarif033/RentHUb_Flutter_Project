import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _value = 1;

  @override
  void initState() {
    super.initState();
    _value = 1; // Set an initial value
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PropertyList(),
    );
  }
}

class PropertyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('properties').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text("Loading..."),
              ],
            ),
          );
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var property = snapshot.data!.docs[index];
            return PropertyCard(property: property);
          },
        );
      },
    );
  }
}

class PropertyCard extends StatefulWidget {
  final QueryDocumentSnapshot<Object?> property;

  PropertyCard({required this.property});

  @override
  _PropertyCardState createState() => _PropertyCardState();
}

class _PropertyCardState extends State<PropertyCard> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? data =
    widget.property.data() as Map<String, dynamic>?;

    return Card(


      elevation: 5,
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        title: Text(
          'Property Type: ${widget.property['propertyType']}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text('Bedrooms: ${widget.property['bedrooms']}'),
            Text('Bathrooms: ${widget.property['bathrooms']}'),
            if (data?.containsKey('price') ?? false)
              Text('Price: ${widget.property['price']}'),
            if (data?.containsKey('district') ?? false)
              Text('District: ${widget.property['district']}'),
            if (data?.containsKey('area') ?? false)
              Text('Area: ${widget.property['area']}'),
            if (data?.containsKey('availableDate') ?? false)
              Text('Available Date: ${widget.property['availableDate']}'),
            if (data?.containsKey('phone') ?? false)
              Text('Phone: ${widget.property['phone']}'),
            if (data?.containsKey('facilities') ?? false)
              Text('Facilities: ${widget.property['facilities']}'),
            SizedBox(height: 8),
          ],
        ),
        tileColor: Colors.blueGrey[50],
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : null,
              ),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                  if (isFavorite) {
                    // Add to favorite list
                    // You can use a provider or another state management solution
                    // to manage the list of favorites globally.
                    // For simplicity, I'm using a static list here.
                    favoriteList.add(widget.property);
                  } else {
                    // Remove from favorite list
                    favoriteList.remove(widget.property);
                  }
                });
              },
            ),
            IconButton(
              icon: Icon(Icons.photo),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewPhotosScreen(property: widget.property),
                  ),
                );
              },
            ),
          ],
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