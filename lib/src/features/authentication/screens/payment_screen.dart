import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';

import 'addAcoount_screen.dart';
import 'home_page_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'otp_screen.dart';

class PaymentMethod1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Method'),
        titleSpacing: 0,
        toolbarHeight: 60,
        toolbarOpacity: 1,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text('Choose a Pyement method',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
                SizedBox(
                  height: 20,
                ),
                Row(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PaymentMethodImage(
                      imageUrl:
                      'https://tse2.mm.bing.net/th?id=OIP.BlTniSn8Q0s07PC_t2LnDAHaE7&pid=Api&P=0&h=220',
                    ),
                    PaymentMethodImage(
                      imageUrl:
                      'https://tse4.mm.bing.net/th?id=OIP.m7rqv0zESeic7Gnfss7glgHaFS&pid=Api&P=0&h=220',
                    ),
                    PaymentMethodImage(
                      imageUrl:
                      'https://tse4.mm.bing.net/th?id=OIP.XRllqUOl74yL-bCUqiwWkAHaE9&pid=Api&P=0&h=220',
                    ),


                  ],


                ),
                Row(
                  children: [
                    PaymentMethodImage(
                      imageUrl:
                      'https://tse2.mm.bing.net/th?id=OIP.cSqCVRE_EP7ZcSx-9Iv8xAHaFj&pid=Api&P=0&h=220',
                    ),
                    PaymentMethodImage(
                      imageUrl:
                      'https://tse4.mm.bing.net/th?id=OIP._6_1SBDkYzK8wbGnnp4n2gHaEK&pid=Api&P=0&h=220',
                    ),

                  ],
                )

              ],
            ),

          ),
        ),
      ),
    );
  }
}

class PaymentMethodImage extends StatelessWidget {
  final String imageUrl;

  const PaymentMethodImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentDetailsScreen(imageUrl: imageUrl),
          ),
        );
      },
      child: Container(
        height: 100,
        width: 100,
        child: Image.network(imageUrl),
      ),
    );
  }
}

class PaymentDetailsScreen extends StatelessWidget {
  final String imageUrl;
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  PaymentDetailsScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Details'),
      ),
      body: Center(
        child: Card(
          elevation: 5, // Add elevation for a shadow effect
          margin: EdgeInsets.all(20), // Add margin for some spacing
          child: Padding(
            padding: EdgeInsets.all(20), // Add padding for content spacing
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  child: Image.network(imageUrl),
                ),
                SizedBox(height: 20), // Add some spacing
                Text(
                  'Payment',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                ),
                TextFormField(
                  controller: mobileController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Enter Mobile Number',
                    prefixIcon: Icon(Icons.phone_android),
                  ),
                ),
                TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Enter Amount',
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Implement logic to handle phone number confirmation
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PaymentMethod1()),
                        );
                      },
                      child: Text('Close'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // Check if mobile number and amount are not empty
                        if (mobileController.text.isEmpty ||
                            amountController.text.isEmpty) {
                          // Show error alert dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Error'),
                                content: Text(
                                    'Please fill up the required fields.'),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(
                                          context); // Close the dialog
                                    },
                                    child: Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          // Show loading dialog
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(height: 10),
                                    Text('Saving data...'),
                                  ],
                                ),
                              );
                            },
                          );

                          // Save data to Firebase
                           await saveDataToFirebase().then((_) {
                            // Close the loading dialog
                            Navigator.pop(context);
                            // Clear the text fields
                            mobileController.clear();
                            amountController.clear();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentSuccessScreen()),
                            );
                          });
                        }
                      },
                      child: Text('Confirm'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> saveDataToFirebase() async {
    await Firebase.initializeApp();

    CollectionReference paymentCollection =
    FirebaseFirestore.instance.collection('payments');

    await paymentCollection.add({
      'mobileNumber': mobileController.text,
      'amount': amountController.text,
      'timestamp': FieldValue.serverTimestamp(),
      'paymentSuccessful': false, // Initially set as false
    });
  }

}






class PaymentSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Simulate a delay to display the CircularProgressIndicator
    Future.delayed(Duration(seconds: 2), () {
      // Navigate back to the home page after the delay
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Successful'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 50,
            ),
            Text('Payment Successful'),
          ],
        ),
      ),
    );
  }
}

class PaymentHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment History'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('payments').get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<PaymentHistoryItem> paymentHistory = snapshot.data!.docs
                .map((DocumentSnapshot document) =>
                PaymentHistoryItem.fromDocument(document))
                .toList();

            return ListView(
              children: paymentHistory,
            );
          }
        },
      ),
    );
  }
}

class PaymentHistoryItem extends StatelessWidget {
  final String mobileNumber;
  final String amount;
  final bool paymentSuccessful;

  PaymentHistoryItem({
    required this.mobileNumber,
    required this.amount,
    required this.paymentSuccessful,
  });

  factory PaymentHistoryItem.fromDocument(DocumentSnapshot document) {
    Map<String, dynamic> data =
        document.data() as Map<String, dynamic>? ?? Map<String, dynamic>();

    return PaymentHistoryItem(
      mobileNumber: data['mobileNumber'] ?? '',
      amount: data['amount'] ?? '',
      paymentSuccessful: data['paymentSuccessful'] ?? false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Row(
            children: [
              Text("Congratulation Payment Successful",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),

            ],
          ),
          Row(
            children: [
              Text('Mobile Number: $mobileNumber',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),


            ],

          ),
          Row(
            children: [
              Text('Amount: $amount',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
            ],
          )
          ],


        /*
         leading: Icon(
          paymentSuccessful ? Icons.check_circle : Icons.error,
          color: paymentSuccessful ? Colors.red : Colors.green,
        ),

         */

      ),
    );
  }
}
