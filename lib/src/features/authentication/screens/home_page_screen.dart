import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';


import 'package:rent_hub_flutter_project/src/features/authentication/screens/navigation_drawer_screen.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/rent_property_screen.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/search_screen.dart';

import 'favourite_screen.dart';
import 'home_screen.dart';
import 'messages_screen.dart';
import 'notification_screen.dart';
class Home extends StatefulWidget {
  const Home({super.key});

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





        backgroundColor: Colors.white,
        appBar: AppBar(

          automaticallyImplyLeading: false,
          //title: const Text('Curved Navigation Bar',style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.black,
          titleSpacing: 0,
          // centerTitle: true,
          toolbarHeight: 80,

          toolbarOpacity: 1,
          elevation: 0,
          shadowColor: Colors.grey.shade800,
          //shape:RoundedRectangleBorder(
           // borderRadius: BorderRadius.all(Radius.circular(20)),
         // ) ,

          leading: SafeArea(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(6),
                    Container(
                      margin:const EdgeInsets.symmetric(horizontal: 15),
                      child: SizedBox(

                        height: 45,
                        width: 40,

                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Image.network('https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTP6YL3O9uOYs33pLbypoVEnfypwja6nchmp60aEVZfa6NZEasp'),
                        ),
                      ),
                    ),
                    //Gap(7),
                    const Row(
                      children: [
                        Gap(10),
                        Text('RENTHUB',style: TextStyle(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w800),),
                      ],
                    )
                  ],

                ),



              ],
            ),
          ),
          leadingWidth: 100,
          // backgroundColor: Colors.green,
          actions: [

            const Text(' TANVIR ARIF',style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w800),),
            const Gap(10),
            const CircleAvatar(
              maxRadius: 20,
              backgroundImage: NetworkImage('https://tse1.mm.bing.net/th?id=OIP.wEsBe2udHBieFeZVmus8qAHaHk&pid=Api&rs=1&c=1&qlt=95&w=119&h=121'),
            ),
            IconButton(onPressed: (){(
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)=> const notification_screen(),
                    ))
            );}, icon:const Icon(Icons.notifications_none_outlined) ,color: Colors.white,focusColor: Colors.grey.shade800,),
    Builder(builder: (context){
    return IconButton(onPressed: (){
    Scaffold.of(context).openDrawer();
    },
    icon:const Icon(Icons.dehaze_outlined,color: Colors.white,),
    );
    }),


  ],
    ),









      drawer: const NavigationDrawerWidget(),
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
        widget =  const home_screen();
        break;
      case 1:
        widget = const favourite_screen();
        break;
      case 2:
        widget=const rent_property_screen();
        break;
      case 3:
        widget=const messages_screen();
        break;
      case 4:
        widget=const search_screen();
        break;
      default:
        widget = const home_screen();
        break;
    }
    return widget;
  }
}