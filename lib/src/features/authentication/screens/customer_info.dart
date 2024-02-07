import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
            TextField(
              controller: fullNameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Permanent Address'),
            ),
            TextField(
              controller: nidNumberController,
              decoration: InputDecoration(labelText: 'NID Number'),
            ),
            TextField(
              controller: relationshipStatusController,
              decoration: InputDecoration(labelText: 'Relationship Status'),
            ),
            TextField(
              controller: workplaceNameController,
              decoration: InputDecoration(labelText: 'Workplace Name/Ins '),
            ),
            TextField(
              controller: emailAddressController,
              decoration: InputDecoration(labelText: 'Email Address'),
            ),
            TextField(
              controller: phoneNumberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                _submitDataToFirebase();
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitDataToFirebase() {
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
      _navigateToSuccessPage(); // Navigate to the success page
    }).catchError((error) {
      print('Error adding data to Firebase: $error');
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

  void _navigateToSuccessPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentMethod1 (), // Create a SuccessPage widget
      ),
    );
  }
}

