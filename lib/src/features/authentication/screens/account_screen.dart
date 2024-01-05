import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class account_screen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.black,
       title: Text('Account',style: TextStyle(color: Colors.white),),
     ),
   );
  }

}