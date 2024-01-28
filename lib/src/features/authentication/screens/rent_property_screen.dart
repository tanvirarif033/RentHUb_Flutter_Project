import 'dart:io';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/home_screen0.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class RentPropertyScreen extends StatefulWidget {
  const RentPropertyScreen({Key? key}) : super(key: key);

  @override
  _RentPropertyScreenState createState() => _RentPropertyScreenState();
}

class _RentPropertyScreenState extends State<RentPropertyScreen> {
  final TextEditingController _propertyTypeController = TextEditingController();
  final TextEditingController _priceRangeController = TextEditingController();
  final TextEditingController _bedroomsController = TextEditingController();
  final TextEditingController _bathroomsController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _facilityController = TextEditingController();
  final TextEditingController _availableDateController = TextEditingController();



  // Firestore reference
  final CollectionReference _propertyCollection =
  FirebaseFirestore.instance.collection('properties');
  final List<String> suggestions = ["Family", "Bachelor", "Sublet", "Others"];
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

  // Image picker
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
              TextFormField(
                controller: _priceRangeController,
                decoration: InputDecoration(
                  labelText: 'Price',
                  prefixIcon: Icon(Icons.attach_money), // Add an icon
                ),
              ),
              TextFormField(
                controller: _bedroomsController,
                decoration: InputDecoration(
                  labelText: 'Bedrooms',
                  prefixIcon: Icon(Icons.king_bed), // Add an icon
                ),
              ),
              TextFormField(
                controller: _bathroomsController,
                decoration: InputDecoration(labelText: 'Bathrooms',
                  prefixIcon: Icon(Icons.bathtub_rounded),

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
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone),
                ),
              ),
              TextFormField(
                controller: _facilityController,
                decoration: InputDecoration(labelText: 'Facilities',
                  prefixIcon: Icon(Icons.local_offer_rounded),
                ),
              ),
              TextFormField(
                controller: _availableDateController,
                decoration: InputDecoration(labelText: 'Available From',
                  prefixIcon: Icon(Icons.date_range_rounded),
                ),
                onTap: () {
                  _selectDate(context);
                },
              ),
              SizedBox(height: 16),
              // Image picker button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _pickImage();
                  },
                  child: Text('Select Image'),
                ),
              ),
              SizedBox(height: 16),
              // Upload image button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _uploadImageToFirebase();
                  },
                  child: const Text('Upload Image '),
                ),
              ),
              SizedBox(height: 16),
              
              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: () {
                    _savePropertyInformation();
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Future<void> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime.now();
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate,
      lastDate: currentDate.add(Duration(days: 365)), // Limit to one year from today
    );

    if (selectedDate != null && selectedDate != currentDate) {
      setState(() {
        _availableDateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  void _uploadImageToFirebase() async {
    if (_selectedImage != null) {
      String imageUrl = await _uploadImage();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image uploaded to Firebase: $imageUrl')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No image selected for upload')),
      );
    }
  }

  void _pickImage() async {
    final XFile? pickedImage =
    await _imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _selectedImage = pickedImage != null ? File(pickedImage.path) : null;
    });
  }

  void _savePropertyInformation() async {
    // Get the values from controllers
    String propertyType = _propertyTypeController.text;
    String price = _priceRangeController.text;
    String bedrooms = _bedroomsController.text;
    String bathrooms = _bathroomsController.text;
    String district = _districtController.text;
    String area = _areaController.text;
    String phone = _phoneController.text;
    String facilities = _facilityController.text;
    String availableDate = _availableDateController.text;
    // Upload image to Firebase Storage
    String imageUrl = await _uploadImage();

    // Create a document with the property information
    await _propertyCollection.add({
      'propertyType': propertyType,
      'price': price,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'district': district,
      'area': area,
      'phone': phone,
      'facilities':facilities,
      'imageUrl': imageUrl,
      'availableDate': availableDate,
    });

    // Clear the text controllers after submitting
    _propertyTypeController.clear();
    _priceRangeController.clear();
    _bedroomsController.clear();
    _bathroomsController.clear();
    _districtController.clear();
    _areaController.clear();
    _phoneController.clear();
    _facilityController.clear();
    _availableDateController.clear();


    // Show a success message or navigate to another screen if needed
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Property information saved')));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  Future<String> _uploadImage() async {
    if (_selectedImage == null) {
      return ''; // Return empty string if no image selected
    }

    Reference storageReference =
    FirebaseStorage.instance.ref().child(' ${DateTime.now()}');
    UploadTask uploadTask = storageReference.putFile(_selectedImage!);
    await uploadTask.whenComplete(() => null);

    // Get the URL of the uploaded image
    String imageUrl = await storageReference.getDownloadURL();
    return imageUrl;
  }
}
