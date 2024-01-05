import 'package:flutter/cupertino.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';


import 'package:google_fonts/google_fonts.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final items = const [
    Icon(Icons.home_outlined, size: 30,color: Colors.white,),
    Icon(Icons.favorite_border, size: 30,color: Colors.white),
    Icon(Icons.add_circle_outline_sharp, size: 30,color: Colors.white),
    Icon(Icons.chat_bubble_outline_outlined, size: 30,color: Colors.white),
    Icon(Icons.search_outlined, size: 30,color: Colors.white)
  ];
  int index = 0;





  @override
  Widget build(BuildContext context) {
    return Scaffold(


     // drawer: NavigationDrawerWidget(),


        backgroundColor: Colors.white,











      bottomNavigationBar: CurvedNavigationBar(
        items: items,
        index: index,

        onTap: (selctedIndex){
          setState(() {
            index = selctedIndex;
          });
        },
        height: 70,

        color: Colors.black,
        backgroundColor: Colors.white,
        animationDuration: const Duration(milliseconds: 300),
        // animationCurve: ,
      ),

      body: Container(
         // color: Colors.yellow,
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
        margin: const EdgeInsets.all(5),
          child: getSelectedWidget(index: index),
      ),




    );

  }

  Widget getSelectedWidget({required int index}){
    Widget widget;
    switch(index){
      case 0:
        widget =  home_screen();
        break;
      case 1:
        widget = favourite_screen();
        break;
      case 2:
        widget=rent_property_screen();
        break;
      case 3:
        widget=messages_screen();
        break;
      case 4:
        widget=profile_screen();
        break;
      default:
        widget = home_screen();
        break;
    }
    return widget;
  }
}