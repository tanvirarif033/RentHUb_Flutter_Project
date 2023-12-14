import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rent_hub_flutter_project/login_screen.dart';
import 'package:rent_hub_flutter_project/signUp_screen.dart';

class welcome_screen extends  StatelessWidget{
  ButtonStyle buttonStyle=ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(16),
      backgroundColor: const Color(0xff9ad0d3),
      foregroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
      )
  );

  welcome_screen({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/Welcome1.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body:Container(
          margin: const EdgeInsets.only(top: 580,left: 75),
          child: Row(

            children: [
              ElevatedButton(onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)=> login_screen(),
                    ));
              },style: buttonStyle, child: const Text('Log in',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),),
              const Gap(50),
              ElevatedButton(onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)=> signUp_screen(),
                    ));
              },style: buttonStyle, child: const Text('Sign up',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.black),),)

            ],
          ),
        ) ,
      ),



    );
  }

}