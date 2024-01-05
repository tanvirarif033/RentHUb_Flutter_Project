import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class setting_screen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Settings',style: TextStyle(color: Colors.white),),
      ),
    );
  }

}