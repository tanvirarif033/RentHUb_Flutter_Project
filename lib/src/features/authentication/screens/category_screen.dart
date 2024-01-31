import 'package:flutter/material.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/property_model.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/property_tile.dart';

class CategoryPropertiesScreen extends StatefulWidget {
  final String categoryName;
  final List<Property> properties;

  CategoryPropertiesScreen({
    required this.categoryName,
    required this.properties,
  });

  @override
  _CategoryPropertiesScreenState createState() =>
      _CategoryPropertiesScreenState();
}

class _CategoryPropertiesScreenState
    extends State<CategoryPropertiesScreen> {
  String _selectedSortOption = 'Price Low to High';
  late List<Property> sortedProperties; // Declare sortedProperties here

  @override
  Widget build(BuildContext context) {
    _sortProperties(); // Call _sortProperties here

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.categoryName,
          style: const TextStyle(fontSize: 25),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            child: InkWell(
              onTap: _showSortOptions,
              child: const Row(
                children: [
                  Icon(Icons.sort, color: Colors.white, size: 25),
                  Text(
                    ' Sort',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: sortedProperties.length,
              itemBuilder: (context, index) {
                Property property = sortedProperties[index];
                return PropertyTile(property: property);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showSortOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.black,
            border: Border(
              top: BorderSide(color: Colors.white, width: 2.0),
              /*left: BorderSide(color: Colors.white, width: 2.0),
              right: BorderSide(color: Colors.white, width: 2.0),*/
            ),
          ),
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Sort By",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildRadioButton('Price (Low to High)'),
              _buildRadioButton('Price (High to Low)'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRadioButton(String option) {
    return ListTile(
      title: Text(
        option,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      onTap: () {
        setState(() {
          _selectedSortOption = option;
          _sortProperties();
        });
        Navigator.pop(context);
      },
      leading: Radio(
        value: option,
        groupValue: _selectedSortOption,
        onChanged: (String? value) {
          setState(() {
            _selectedSortOption = value!;
            // Sort the properties here
            _sortProperties();
          });
          Navigator.pop(context);
        },
      ),
    );
  }

  void _sortProperties() {
    try {
      if (_selectedSortOption == 'Price (Low to High)') {
        setState(() {
          sortedProperties = List.from(widget.properties)
            ..sort((a, b) => _comparePrices(a.price, b.price));
        });
      } else {
        setState(() {
          sortedProperties = List.from(widget.properties)
            ..sort((a, b) => _comparePrices(b.price, a.price));
        });
      }
    } catch (e) {
      print('Error sorting properties: $e');
      setState(() {
        sortedProperties = List.from(widget.properties);
      });
    }
  }

  int _comparePrices(String? a, String? b) {
    try {
      if (a == null || b == null) {
        return 0;
      }
      return (int.tryParse(a) ?? 0).compareTo(int.tryParse(b) ?? 0);
    } catch (e) {
      return 0;
    }
  }
}
