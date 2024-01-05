import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class about_us_screen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('About Us',style: TextStyle(color: Colors.white),),
      ),
    );
  }

}