import 'package:flutter/material.dart';

class setting_screen extends StatelessWidget{
  const setting_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Settings',style: TextStyle(color: Colors.white),),
      ),
    );
  }

}