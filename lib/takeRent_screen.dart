import 'package:flutter/material.dart';

class takeRent_screen extends StatelessWidget{
  const takeRent_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/page.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff9ad0d3),
          title: const Center(child: Text('Search House',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600),)),
        ),
      ),
    );

  }

}