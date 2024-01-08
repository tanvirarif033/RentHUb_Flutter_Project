import 'package:flutter/material.dart';

class addAccount_screen extends StatelessWidget{
  const addAccount_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Add Account',style: TextStyle(color: Colors.white),),
      ),
    );
  }

}