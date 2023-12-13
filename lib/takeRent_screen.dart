import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class takeRent_screen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/page.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff9ad0d3),
          title: Center(child: Text('Search House',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),)),
        ),
      ),
    );

  }

}