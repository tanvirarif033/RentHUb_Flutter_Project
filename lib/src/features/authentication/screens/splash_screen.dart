import 'package:flutter/material.dart';
import 'package:rent_hub_flutter_project/src/constants/colors.dart';
import 'package:rent_hub_flutter_project/src/constants/images_strings.dart';
import 'package:rent_hub_flutter_project/src/constants/sizes.dart';
import 'package:rent_hub_flutter_project/src/constants/text_strings.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/onboarding_screen.dart';
import 'dart:async';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/welcome_screen.dart';
import 'package:rent_hub_flutter_project/main.dart';

class splash_screen extends StatefulWidget{
  final Widget? child ;
  const splash_screen({super.key,this.child}) ;

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  bool animate=false;
  @override
  void initState() {
    startAnimation();

    super.initState();
    controller =AnimationController(vsync: this,duration: Duration(seconds: 3));
    animation=CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.repeat();
    Timer(Duration(seconds: 5),(){
      Navigator.pushReplacement(
          context, MaterialPageRoute(
          builder: (context)=> OnBoarding_screen()));

    });
  }

  void dispose(){
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final size =MediaQuery.of(context).size;

    return Scaffold(
        body:SafeArea(
          child: Stack(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedPositioned(
                duration: const Duration(milliseconds: 1600),
                top: animate ? 0: -100,
                right: animate ? 0: -0,
                bottom: animate ? 0: -100,
                // left: animate ? 0: -0,
                left: animate ? 0: -100,


                child: AnimatedOpacity(
                  duration: const Duration(milliseconds: 1600),
                  opacity: animate ? 1 :0,
                  child: Center(
                    child: Container(
                      margin:  EdgeInsets.only(bottom: 240.0),
                      //padding:  EdgeInsets.all(8.0),


                      height: 140,
                      width: 140,
                      child: Image(image: AssetImage(tWelcomeScreenImage),height: size.height * 0.3,),

                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
                width: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child:RotationTransition(
                      turns:animation ,
                      child: SizedBox(
                        height: 53,
                        width: 60,
                        child:Image(image: AssetImage(tLogo),height: size.height * 0.09,),

                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                    width: 20,
                  ),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 1600),
                    top: animate ? 0: -100,
                    right: animate ? 0: -100,
                    bottom: animate ? 0: -100,
                    left: animate ? 0: -0,
                    //left: animate ? 0: -100,

                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 1600),
                      opacity: animate ? 1 :0,

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(tAppName,style:Theme.of(context).textTheme.displayLarge,textAlign: TextAlign.start,),
                          Text('Rent Smarter, Live Better',  style: Theme.of(context).textTheme.bodyLarge,textAlign: TextAlign.start,),
                        ],
                      ),
                    ),
                  )
                ],
              ),

            ],
          ),
        )


    );
  }
  Future startAnimation() async{
    await Future.delayed(Duration(milliseconds: 500));
    setState(() => animate=true );
    await Future.delayed(Duration(milliseconds:500 ));

  }
}
