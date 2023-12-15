import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:rent_hub_flutter_project/src/constants/images_strings.dart';
import 'package:rent_hub_flutter_project/src/constants/sizes.dart';
import 'package:rent_hub_flutter_project/src/constants/text_strings.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/login_screen.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/signUp_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var height =MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(tDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
             Image(
              image: AssetImage(tWelcomeScreenImage),height: height * 0.6,
            ),
             Column(
              children: [
                Text(tWelcomeTitle,style: Theme.of(context).textTheme.displaySmall,),
                Text(
                  tWelcomeSubTitle,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: OutlinedButton(onPressed: () {}, child:  Text(tLogin.toUpperCase()))),
                const SizedBox(width: 10.0,),
                Expanded(child: ElevatedButton(onPressed: () {}, child:  Text(tSignup.toUpperCase()))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
