import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'addAcoount_screen.dart';
import 'home_page_screen.dart';

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
            child: Row(
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
                PaymentMethodImage(
                  imageUrl:
                  'https://tse2.mm.bing.net/th?id=OIP.cSqCVRE_EP7ZcSx-9Iv8xAHaFj&pid=Api&P=0&h=220',
                ),
                PaymentMethodImage(
                  imageUrl:
                  'https://tse4.mm.bing.net/th?id=OIP._6_1SBDkYzK8wbGnnp4n2gHaEK&pid=Api&P=0&h=220',
                ),
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
        height: 90,
        width: 90,
        child: Image.network(imageUrl),
      ),
    );
  }
}

class PaymentDetailsScreen extends StatelessWidget {
  final String imageUrl;

  const PaymentDetailsScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 150,
            width: 150,
            child: Image.network(imageUrl),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(labelText: 'Enter Phone Number'),
          ),
          SizedBox(height: 15),
          TextField(
            decoration: InputDecoration(labelText: 'Enter Amount'),
          ),
          SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              // Implement logic to handle phone number confirmation
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OTPScreen(),
                ),
              );
            },
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }
}

class OTPScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter OTP'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Enter OTP'),
          ),
          ElevatedButton(
            onPressed: () {
              // Implement logic to handle OTP verification and payment success
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentSuccessScreen(),
                ),
              );
            },
            child: Text('Verify OTP'),
          ),
        ],
      ),
    );
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
            Text('Payment Successful'),
          ],
        ),
      ),
    );
  }
}

