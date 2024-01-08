import 'package:flutter/cupertino.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/navigation_drawer_screen.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/rent_property_screen.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/search_screen.dart';

import 'favourite_screen.dart';
import 'home_screen.dart';
import 'messages_screen.dart';
import 'notification_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final items = const [
    Icon(Icons.home_outlined, size: 30, color: Colors.white),
    Icon(Icons.favorite_border, size: 30, color: Colors.white),
    Icon(Icons.add_circle_outline_sharp, size: 30, color: Colors.white),
    Icon(Icons.chat_bubble_outline_outlined, size: 30, color: Colors.white),
    Icon(Icons.search_outlined, size: 30, color: Colors.white)
  ];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        titleSpacing: 0,
        toolbarHeight: 80,
        elevation: 0,
        shadowColor: Colors.grey.shade800,
        leading: SafeArea(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(6),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: SizedBox(
                      height: 45,
                      width: 40,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Image.network(
                            'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTP6YL3O9uOYs33pLbypoVEnfypwja6nchmp60aEVZfa6NZEasp'),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Gap(10),
                      Text(
                        'RENTHUB',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        leadingWidth: 100,
        actions: [
          Text(
            ' TANVIR ARIF',
            style: TextStyle(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.w800),
          ),
          Gap(10),
          CircleAvatar(
            maxRadius: 20,
            backgroundImage: NetworkImage(
                'https://tse1.mm.bing.net/th?id=OIP.wEsBe2udHBieFeZVmus8qAHaHk&pid=Api&rs=1&c=1&qlt=95&w=119&h=121'),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => notification_screen(),
                ),
              );
            },
            icon: const Icon(Icons.notifications_none_outlined),
            color: Colors.white,
            focusColor: Colors.grey.shade800,
          ),
          Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.dehaze_outlined, color: Colors.white,),
            );
          }),
        ],
      ),
      drawer: NavigationDrawerWidget(),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(5),
              child: getSelectedWidget(index: index),
            ),
          ),
          CurvedNavigationBar(
            items: items,
            index: index,
            onTap: (selectedIndex) {
              setState(() {
                index = selectedIndex;
              });
            },
            height: 70,
            color: Colors.black,
            backgroundColor: Colors.white,
            animationDuration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }

  Widget getSelectedWidget({required int index}) {
    Widget widget;
    switch (index) {
      case 0:
        widget = home_screen();
        break;
      case 1:
        widget = favourite_screen();
        break;
      case 2:
        widget = rent_property_screen();
        break;
      case 3:
        widget = messages_screen();
        break;
      case 4:
        widget = search_screen();
        break;
      default:
        widget = home_screen();
        break;
    }
    return SingleChildScrollView(
      child: widget,
    );
  }
}
