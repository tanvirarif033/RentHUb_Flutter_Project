import 'package:flutter/material.dart';
import 'package:rent_hub_flutter_project/src/constants/images_strings.dart';
import 'package:rent_hub_flutter_project/src/constants/sizes.dart';
import 'package:rent_hub_flutter_project/src/constants/text_strings.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/home_page_screen.dart';

class UserType_screen extends StatelessWidget {
  const UserType_screen ({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(tDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: const AssetImage(tUserSelection),
              height: height * 0.3,

            ),
            Column(
              children: [
                Text(
                  tuserTitle,
                  style: Theme.of(context).textTheme.displayLarge,

                ),
                Text(
                  tuserSubTitle,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),


              ],
            ),
            Column(
              children: [
                const SizedBox(
                  height: 80,
                  width: 80,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                        child: OutlinedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context)=> const Home(),
                                  ));
                            }, child: Text(tTakeRent.toUpperCase()))),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context)=>  const Home(),
                                  ));
                            }, child: Text(tGiveRent.toUpperCase()))),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
