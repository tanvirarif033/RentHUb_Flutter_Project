import 'package:flutter/material.dart';

class giveRent_screen extends StatelessWidget{
  const giveRent_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/page.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        appBar:AppBar (
          backgroundColor: const Color(0xff9ad0d3),
          title: const Center(child: Text('Rent Post',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),)),
        ),
      ),
    );
  }

}