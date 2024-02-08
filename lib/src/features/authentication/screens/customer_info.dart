import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/payment_screen.dart';

class CustomerInfoScreen extends StatefulWidget {
  const CustomerInfoScreen({Key? key}) : super(key: key);

  @override
  _CustomerInfoScreenState createState() => _CustomerInfoScreenState();
}

class _CustomerInfoScreenState extends State<CustomerInfoScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController nidNumberController = TextEditingController();
  final TextEditingController relationshipStatusController = TextEditingController();
  final TextEditingController workplaceNameController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  final List<String> suggestions = ["Married ","Unmarried"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Customer Information', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: fullNameController,
              decoration: InputDecoration(
                labelText: 'Full Name',
                prefixIcon: Icon(Icons.perm_identity_outlined),
              ),
            ),

            TextFormField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'Permanent Address',
                prefixIcon: Icon(Icons.location_on_outlined),
              ),
            ),

            TextFormField(
              controller: nidNumberController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: InputDecoration(
                labelText: 'Nid Number',
                prefixIcon: Icon(Icons.person_pin_outlined),
              ),
            ),
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
                relationshipStatusController.text = suggestion;
              },
              textFieldConfiguration: TextFieldConfiguration(
                controller: relationshipStatusController,
                decoration: InputDecoration(
                  labelText: 'Relationship Status',
                  labelStyle:
                  TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  prefixIcon: Icon(Icons.favorite_border),
                ),
              ),
            ),
            TextFormField(
              controller: workplaceNameController,
              decoration: InputDecoration(
                labelText: 'Work Place/Institution',
                prefixIcon: Icon(Icons.work_outline),
              ),
            ),
            TextFormField(
              controller: emailAddressController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: InputDecoration(
                labelText: 'Mobile Number.',
                prefixIcon: Icon(Icons.phone_android),
              ),
            ),
            SizedBox(height: 16.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _submitDataToFirebase();
                },
                child: Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _submitDataToFirebase() {
    // Check if any required field is empty
    if (fullNameController.text.isEmpty ||
        addressController.text.isEmpty ||
        nidNumberController.text.isEmpty ||
        relationshipStatusController.text.isEmpty ||
        workplaceNameController.text.isEmpty ||
        emailAddressController.text.isEmpty ||
        phoneNumberController.text.isEmpty) {
      _showAlertDialog('Please fill in all required fields.');
      return;
    }

    // If all required fields are filled, proceed with Firebase submission
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16.0),
              Text('Submitting data...'),
            ],
          ),
        );
      },
    );

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    firestore.collection('customer_info').add({
      'full_name': fullNameController.text,
      'address': addressController.text,
      'nid_number': nidNumberController.text,
      'relationship_status': relationshipStatusController.text,
      'workplace_name': workplaceNameController.text,
      'email_address': emailAddressController.text,
      'phone_number': phoneNumberController.text,
    }).then((value) {
      print('Data added to Firebase with ID: ${value.id}');
      _clearInputFields();
      Navigator.pop(context); // Close the AlertDialog
      _showLoadingDialog();
    }).catchError((error) {
      print('Error adding data to Firebase: $error');
      Navigator.pop(context); // Close the AlertDialog
      _showAlertDialog('Failed to submit data. Please try again.');
    });
  }

  void _clearInputFields() {
    fullNameController.clear();
    addressController.clear();
    nidNumberController.clear();
    relationshipStatusController.clear();
    workplaceNameController.clear();
    emailAddressController.clear();
    phoneNumberController.clear();
  }
  void _showLoadingDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16.0),
              Text('Submitting successful!'),
            ],
          ),
        );
      },
    );
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context); // Close the AlertDialog after 2 seconds
      _navigateToSuccessPage();
    });
  }
  void _showAlertDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }


  void _navigateToSuccessPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentMethod1 (), // Create a SuccessPage widget
      ),
    );
  }
}

class CustomerDetailsScreen extends StatefulWidget {
  const CustomerDetailsScreen({Key? key}) : super(key: key);

  @override
  _CustomerDetailsScreenState createState() => _CustomerDetailsScreenState();
}

class _CustomerDetailsScreenState extends State<CustomerDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer Details'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('customer_info').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<CustomerDetailsCard> customerDetails = snapshot.data!.docs
                .map((DocumentSnapshot document) =>
                CustomerDetailsCard.fromDocument(document))
                .toList();

            return ListView(
              children: customerDetails,
            );
          }
        },
      ),
    );
  }
}

class CustomerDetailsCard extends StatelessWidget {
  final String fullName;
  final String address;
  final String nidNumber;
  final String relationshipStatus;
  final String workplaceName;
  final String emailAddress;
  final String phoneNumber;

  CustomerDetailsCard({
    required this.fullName,
    required this.address,
    required this.nidNumber,
    required this.relationshipStatus,
    required this.workplaceName,
    required this.emailAddress,
    required this.phoneNumber,
  });

  factory CustomerDetailsCard.fromDocument(DocumentSnapshot document) {
    Map<String, dynamic> data =
        document.data() as Map<String, dynamic>? ?? Map<String, dynamic>();

    return CustomerDetailsCard(
      fullName: data['full_name'] ?? '',
      address: data['address'] ?? '',
      nidNumber: data['nid_number'] ?? '',
      relationshipStatus: data['relationship_status'] ?? '',
      workplaceName: data['workplace_name'] ?? '',
      emailAddress: data['email_address'] ?? '',
      phoneNumber: data['phone_number'] ?? '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(
        title: Text('Full Name: $fullName'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Address: $address'),
            Text('NID Number: $nidNumber'),
            Text('Relationship Status: $relationshipStatus'),
            Text('Workplace: $workplaceName'),
            Text('Email: $emailAddress'),
            Text('Phone Number: $phoneNumber'),
          ],
        ),
      ),
    );
  }
}
