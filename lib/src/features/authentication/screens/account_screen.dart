import 'package:flutter/material.dart';

class account_screen extends StatelessWidget{
  const account_screen({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.black,
       title: const Text('Account',style: TextStyle(color: Colors.white),),
     ),
   );
  }

}