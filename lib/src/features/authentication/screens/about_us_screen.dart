import 'package:flutter/material.dart';

class about_us_screen extends StatelessWidget{
  const about_us_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('About Us',style: TextStyle(color: Colors.white),),
      ),
    );
  }

}