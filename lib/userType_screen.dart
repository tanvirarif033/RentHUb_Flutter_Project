import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rent_hub_flutter_project/giveRent_screen.dart';
import 'package:rent_hub_flutter_project/splash_screen.dart';
import 'package:rent_hub_flutter_project/takeRent_screen.dart';

class userType_screen extends StatelessWidget{

  ButtonStyle buttonStyle=ElevatedButton.styleFrom(
      padding: EdgeInsets.all(16),
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
      )
  );
  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/page.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 80,
                width: 80,
                child: Image.network('https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTP6YL3O9uOYs33pLbypoVEnfypwja6nchmp60aEVZfa6NZEasp')
            ),
            Gap(20),
            Text('Choose What Services ',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),
            Gap(5),
            Text('You Want ',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),
            Gap(10),
            Container(

              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [


                    ElevatedButton(onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context)=> takeRent_screen(),
                          ));
                    }, child: Text('Take Rent',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.white),),style: buttonStyle,),
                    Gap(30),
                    ElevatedButton(onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context)=> giveRent_screen(),
                          ));
                    }, child: Text('Give Rent',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.white),),style: buttonStyle,),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}