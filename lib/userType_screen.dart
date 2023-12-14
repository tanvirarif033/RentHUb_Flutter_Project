import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rent_hub_flutter_project/giveRent_screen.dart';
import 'package:rent_hub_flutter_project/takeRent_screen.dart';

class userType_screen extends StatelessWidget{

  ButtonStyle buttonStyle=ElevatedButton.styleFrom(
      padding: const EdgeInsets.all(16),
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
      )
  );

  userType_screen({super.key});
  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/page.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body:
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 80,
                width: 80,
                child: Image.network('https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTP6YL3O9uOYs33pLbypoVEnfypwja6nchmp60aEVZfa6NZEasp')
            ),
            const Gap(20),
            const Text('Choose What Services ',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),
            const Gap(5),
            const Text('You Want ',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500,),textAlign: TextAlign.center,),
            const Gap(10),
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
                            builder: (context)=> const takeRent_screen(),
                          ));
                    },style: buttonStyle, child: const Text('Take Rent',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.white),),),
                    const Gap(30),
                    ElevatedButton(onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context)=> const giveRent_screen(),
                          ));
                    },style: buttonStyle, child: const Text('Give Rent',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.white),),),
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