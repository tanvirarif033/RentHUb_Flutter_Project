import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rent_hub_flutter_project/src/constants/colors.dart';
import 'package:rent_hub_flutter_project/src/constants/images_strings.dart';
import 'package:rent_hub_flutter_project/src/constants/sizes.dart';
import 'package:rent_hub_flutter_project/src/constants/text_strings.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/welcome_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class OnBoarding_screen extends StatefulWidget {
   OnBoarding_screen({super.key});

  @override
  State<OnBoarding_screen> createState() => _OnBoarding_screenState();
}

class _OnBoarding_screenState extends State<OnBoarding_screen> {
  final controller= LiquidController();

  int currentPage=0;

  @override
  Widget build(BuildContext context) {
    final size =MediaQuery.of(context).size;


    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          LiquidSwipe(
              pages:[
                Container(
                  padding: const EdgeInsets.all(tDefaultSize),
                   // color:tOnBoardingPage1Color ,
                      color: Theme.of(context).cardColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                       Image(image:AssetImage(tOnBoardingImage1),height: size.height * 0.4 ,),
                      Column(
                        children: [
                          Text(tOnBoardingTitle1,style: Theme.of(context).textTheme.headline3,textAlign: TextAlign.center,),

                          Gap(10),
                         const  Text(tOnBoardingSubTitle1,textAlign: TextAlign.center,),
                        ],
                      ),
                      Text(tOnBoardingCounter1,style: Theme.of(context).textTheme.titleLarge,),
                      SizedBox(height: 60.0),
                    ],
                  ),

                ),
                Container(
                  padding: const EdgeInsets.all(tDefaultSize),
                  color:tOnBoardingPage2Color ,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(image:AssetImage(tOnBoardingImage2),height: size.height * 0.4 ,),
                      Column(
                        children: [
                          Text(tOnBoardingTitle2,style: Theme.of(context).textTheme.headline3,textAlign: TextAlign.center),
                          Gap(10),
                          const Text(tOnBoardingSubTitle2,textAlign: TextAlign.center,),
                        ],
                      ),
                      Text(tOnBoardingCounter2,style: Theme.of(context).textTheme.headline6,),
                      SizedBox(height: 60.0),
                    ],
                  ),

                ),
                Container(
                  padding: const EdgeInsets.all(tDefaultSize),
                  color:tOnBoardingPage3Color ,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(image:AssetImage(tReview),height: size.height * 0.4 ,),
                      Column(
                        children: [
                          Text(tOnBoardingTitle3,style: Theme.of(context).textTheme.headline3,textAlign: TextAlign.center),
                          Gap(10),
                          const Text(tOnBoardingSubTitle3,textAlign: TextAlign.center,),
                        ],
                      ),
                      Text(tOnBoardingCounter3,style: Theme.of(context).textTheme.headline6,),
                      SizedBox(height: 60.0),

                    ],
                  ),

                )

        ],
            slideIconWidget: const Icon(Icons.arrow_back_ios),
            enableSideReveal: true,
            liquidController: controller,
            onPageChangeCallback: onPageChangedCallback,
          ),
          Positioned(
            bottom: 60.0,
            child: OutlinedButton(
              onPressed: (){
                int nextPage= controller.currentPage +1;
                controller.animateToPage(page: nextPage);
              },
              style: ElevatedButton.styleFrom(
                side: const BorderSide(color: Colors.black26),
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20.0),
                onPrimary: Colors.white,

              ),
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                  color: tDarkColor,shape: BoxShape.circle
                ),
                child: const Icon(Icons.arrow_forward_ios),

              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context)=> const WelcomeScreen(),
                    ));
              },
              child: const Text('Skip',style: TextStyle(color:Colors.grey)),
            ),
          ),
          Positioned(
            bottom: 10,
              child:AnimatedSmoothIndicator(
                count: 3,
            activeIndex: controller.currentPage,

                effect: const WormEffect(
                  activeDotColor: Color(0xff272727),
                  dotHeight: 5.0,
                  dotColor: Color(0xfff84f46),
                ),
              )
          )
        ],
      ),

    );

  }

   onPageChangedCallback(int activePageIndex){
    setState(() {
      currentPage=activePageIndex;
    });

   }
}