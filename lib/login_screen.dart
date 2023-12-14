import 'package:flutter/material.dart';
import 'package:rent_hub_flutter_project/userType_screen.dart';

class login_screen extends  StatelessWidget{
  ButtonStyle buttonStyle=ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(16),
      backgroundColor: const Color(0xff9ad0d3),
      foregroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
      )
  );

  login_screen({super.key});
  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/page.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          child:  Center(
            child: ElevatedButton(onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context)=> userType_screen(),
                  ));
            },style: buttonStyle, child: const Text('log in',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),),
          ),
        ),
      ),
    );

  }

}