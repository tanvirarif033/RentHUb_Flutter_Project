import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:rent_hub_flutter_project/main.dart';
import 'package:rent_hub_01/welcome_screen.dart';

class splash_screen extends StatefulWidget{
  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {

  @override
  void initState() {

    super.initState();
    Timer(Duration(seconds: 2),(){
      Navigator.pushReplacement(
          context, MaterialPageRoute(
        builder: (context)=>welcome_screen(),));

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container

                (
                  height: 60,
                  width: 60,
                  child: Image.network('https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTP6YL3O9uOYs33pLbypoVEnfypwja6nchmp60aEVZfa6NZEasp')),
              Text('Rent Hub',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,fontStyle: FontStyle.italic),),
              Text('Rent Smarter, Live Better',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500,fontStyle: FontStyle.italic),),


            ],
          ),
        ),
      ),
    );
  }
}
