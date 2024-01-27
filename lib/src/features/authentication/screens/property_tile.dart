import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/property_details_screen.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/property_model.dart';

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
                  image: property.imageUrl != null &&
                      property.imageUrl.isNotEmpty
                      ? Image.network(property.imageUrl).image
                      : const AssetImage('assets/logo/renthub.png'),
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
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    'Location: ${property.district} , ${property.area}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.white),
                  ),
                  Text(
                    'Price : BDT ${property.price}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}