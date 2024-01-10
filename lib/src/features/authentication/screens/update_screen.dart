import 'package:flutter/material.dart';

class update_screen extends StatelessWidget{
  const update_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Updates',style: TextStyle(color: Colors.white),),
      ),
    );
  }

}