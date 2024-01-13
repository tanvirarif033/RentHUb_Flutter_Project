import 'package:flutter/material.dart';

class privacy_screen extends StatelessWidget{
  const privacy_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Privacy',style: TextStyle(color: Colors.white),),
      ),
    );
  }

}