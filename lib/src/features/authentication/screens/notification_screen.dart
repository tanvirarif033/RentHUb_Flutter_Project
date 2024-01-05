import 'package:flutter/material.dart';

class notification_screen extends StatelessWidget{
  const notification_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Notification',style: TextStyle(color:Colors.white),),
      ),

    );
  }

}