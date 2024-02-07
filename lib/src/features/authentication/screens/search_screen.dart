
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rent_hub_flutter_project/src/constants/text_strings.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key}) : super(key: key);

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final TextEditingController _propertyTypeController = TextEditingController();
  final TextEditingController _bedroomsController = TextEditingController();
  final TextEditingController _bathroomsController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _facilityController = TextEditingController();
  final TextEditingController _availableDateController = TextEditingController();
  final CollectionReference _propertyCollection =
  FirebaseFirestore.instance.collection('properties');

  final List<String> suggestions = ["Family", "Bachelor", "Sublet", "Office","Hostel","Others"];
  final List<String> suggestions2 = ["1","2","3","4","5"];
  final List<String> suggestions3 = ["1","2","3","4","5"];
  final List<String> suggestions1 = [
    "Dhaka",
    "Faridpur",
    "Gazipur",
    "Gopalganj",
    "Jamalpur",
    "Kishoreganj",
    "Madaripur",
    "Manikganj",
    "Munshiganj",
    "Mymensingh",
    "Narayanganj",
    "Narsingdi",
    "Netrokona",
    "Rajbari",
    "Shariatpur",
    "Sherpur",
    "Tangail",
    "Bogra",
    "Joypurhat",
    "Naogaon",
    "Natore",
    "Nawabganj",
    "Pabna",
    "Rajshahi",
    "Sirajgonj",
    "Dinajpur",
    "Gaibandha",
    "Kurigram",
    "Lalmonirhat",
    "Nilphamari",
    "Panchagarh",
    "Rangpur"
        "Thakurgaon",
    "Barguna",
    "Barisal",
    "Bhola",
    "Jhalokati",
    "Patuakhali",
    "Pirojpur",
    "Bandarban",
    "Brahmanbaria",
    "Chandpur",
    "Chittagong",
    "Comilla",
    "Cox's Bazar",
    "Feni",
    "Khagrachari",
    "Lakshmipur",
    "Noakhali",
    "Rangamati",
    "Habiganj",
    "Maulvibazar",
    "Sunamganj",
    "Sylhet",
    "Bagerhat",
    "Chuadanga",
    "Jessore",
    "Jhenaidah",
    "Khulna",
    "Kushtia",
    "Magura",
    "Meherpur",
    "Narail",
    "Satkhira",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TypeAheadField(
              hideOnEmpty: true,
              debounceDuration: Duration(milliseconds: 300),

              suggestionsCallback: (pattern) async {
                return suggestions
                    .where((item) =>
                    item.toLowerCase().contains(pattern.toLowerCase()))
                    .toList();
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion),

                );
              },
              onSuggestionSelected: (suggestion) {
                _propertyTypeController.text = suggestion;
              },
              textFieldConfiguration: TextFieldConfiguration(
                controller: _propertyTypeController,
                decoration: InputDecoration(
                  labelText: 'Property Type',
                  labelStyle:
                  TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  prefixIcon:Icon(Icons.location_city_rounded),
                ),
              ),
            ),
            TypeAheadField(
              hideOnEmpty: true,
              debounceDuration: Duration(milliseconds: 300),

              suggestionsCallback: (pattern) async {
                return suggestions2
                    .where((item) =>
                    item.toLowerCase().contains(pattern.toLowerCase()))
                    .toList();
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion),

                );
              },
              onSuggestionSelected: (suggestion) {
                _bedroomsController.text = suggestion;
              },
              textFieldConfiguration: TextFieldConfiguration(
                controller: _bedroomsController,
                decoration: InputDecoration(
                  labelText: 'Bedrooms',
                  labelStyle:
                  TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  prefixIcon:Icon(Icons.king_bed),
                ),
              ),
            ),
            TypeAheadField(
              hideOnEmpty: true,
              debounceDuration: Duration(milliseconds: 300),

              suggestionsCallback: (pattern) async {
                return suggestions3
                    .where((item) =>
                    item.toLowerCase().contains(pattern.toLowerCase()))
                    .toList();
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion),

                );
              },
              onSuggestionSelected: (suggestion) {
                _bathroomsController.text = suggestion;
              },
              textFieldConfiguration: TextFieldConfiguration(
                controller: _bathroomsController,
                decoration: InputDecoration(
                  labelText: 'Bathrooms',
                  labelStyle:
                  TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  prefixIcon:Icon(Icons.bathtub_rounded),
                ),
              ),
            ),

            TypeAheadField(
              hideOnEmpty: true,
              debounceDuration: Duration(milliseconds: 300),

              suggestionsCallback: (pattern) async {
                return suggestions1
                    .where((item) =>
                    item.toLowerCase().contains(pattern.toLowerCase()))
                    .toList();
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion),

                );
              },
              onSuggestionSelected: (suggestion) {
                _districtController.text = suggestion;
              },
              textFieldConfiguration: TextFieldConfiguration(
                controller: _districtController,
                decoration: InputDecoration(
                  labelText: 'District',
                  labelStyle:
                  TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  prefixIcon:Icon(Icons.location_searching_rounded),
                ),
              ),
            ),
            TextFormField(
              controller: _areaController,
              decoration: InputDecoration(labelText: 'Area',
                prefixIcon: Icon(Icons.location_on),),
            ),


            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _searchProperties();
                },
                child: Text('Search'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _searchProperties() async {
    String propertyType = _propertyTypeController.text;
    String bedrooms = _bedroomsController.text;
    String bathrooms = _bathroomsController.text;
    String district = _districtController.text;
    String area = _areaController.text;

    // Perform a query based on user input
    QuerySnapshot querySnapshot = await _propertyCollection
        .where('propertyType', isEqualTo: propertyType)
        .where('bedrooms', isEqualTo: bedrooms)
        .where('bathrooms', isEqualTo: bathrooms)
        .where('district', isEqualTo: district)
        .where('area', isEqualTo: area)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Display the result
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ResultsDialog(querySnapshot: querySnapshot);
        },
      );
    } else {
      // No matching properties found
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('No Results'),
            content: Text('No properties match the search criteria.'),
          );
        },
      );
    }
  }
}

class ResultsDialog extends StatelessWidget {
  final QuerySnapshot querySnapshot;

  const ResultsDialog({Key? key, required this.querySnapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Search Result'),
      content: Column(
        children: querySnapshot.docs
            .map((DocumentSnapshot document) => _buildPropertyCard(document))
            .toList(),
      ),
    );
  }


  Widget _buildPropertyCard(DocumentSnapshot document) {
    // Customize this based on your database structure
    // For example, assuming each document has fields like 'propertyType', 'bedrooms', 'bathrooms', 'district', 'area', 'phone', 'image'
    String propertyType = document['propertyType'];
    String bedrooms = document['bedrooms'];
    String bathrooms = document['bathrooms'];
    String district = document['district'];
    String area = document['area'];
    String price = document['price'];
    String phone = document['phone'];
    String facilities = document['facilities'];
    String availableDate =document['availableDate'];
    // String imageUrl = document['image'];
    return Card(
      elevation: 5, // Add some elevation for a shadow effect
      margin: EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        children: [
          // Image.network(imageUrl), // Assuming the image is stored as a URL in the database
          ListTile(
            contentPadding: EdgeInsets.all(16.0),
            title: Text(
              'Property Type: $propertyType',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              'Bedrooms: $bedrooms, Bathrooms: $bathrooms, District: $district, Area: $area, Price: $price',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Divider(height: 0, thickness: 1, color: Colors.grey[300]), // Add a divider for separation
          ListTile(
            contentPadding: EdgeInsets.all(16.0),
            title: Text(
              'Available Date: $availableDate',
              style: TextStyle(fontSize: 14),
            ),
            subtitle: Text(
              'Facilities: $facilities, Phone: $phone',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
      color: Colors.white, // Set a background color
    );

  }
}