import 'package:flutter/material.dart';
import 'dart:async';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/welcome_screen.dart';

class splash_screen extends StatefulWidget{
  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {

  @override
  void initState() {

    super.initState();
    Timer(const Duration(seconds: 2),(){
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
              SizedBox

                (
                  height: 60,
                  width: 60,
                  child: Image.network('https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTP6YL3O9uOYs33pLbypoVEnfypwja6nchmp60aEVZfa6NZEasp')),
              const Text('Rent Hub',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,fontStyle: FontStyle.italic),),
              const Text('Rent Smarter, Live Better',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w500,fontStyle: FontStyle.italic),),


            ],
          ),
        ),
      ),
    );
  }
}
