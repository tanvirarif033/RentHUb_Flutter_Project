import 'package:flutter/material.dart';

class logout_screen extends StatelessWidget{
  const logout_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Log Out',style: TextStyle(color: Colors.white),),
      ),
    );
  }

}