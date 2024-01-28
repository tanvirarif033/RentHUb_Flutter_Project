import 'package:flutter/material.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/property_model.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/property_tile.dart';

class CategoryPropertiesScreen extends StatelessWidget {
  final String categoryName;
  final List<Property> properties;

  CategoryPropertiesScreen({required this.categoryName, required this.properties});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName),
      ),
      body: GridView.builder(
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
      ),
    );
  }
}
