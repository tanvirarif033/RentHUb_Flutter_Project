import 'package:flutter/material.dart';

class invite_friends_screen extends StatelessWidget{
  const invite_friends_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Invite Friends',style: TextStyle(color: Colors.white),),
      ),
    );
  }

}