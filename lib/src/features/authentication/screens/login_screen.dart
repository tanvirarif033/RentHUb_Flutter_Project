import 'package:flutter/material.dart';
import 'package:rent_hub_flutter_project/src/constants/images_strings.dart';
import 'package:rent_hub_flutter_project/src/constants/sizes.dart';
import 'package:rent_hub_flutter_project/src/constants/text_strings.dart';
import 'package:rent_hub_flutter_project/userType_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../../../firebase_options.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size =MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(tDefaultSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(image: AssetImage(tWelcomeScreenImage),height: size.height *0.2,),
                  Text(tLoginTitle,style: Theme.of(context).textTheme.headline1,),
                  Text(tLoginSubTitle,style: Theme.of(context).textTheme.bodyText1,),

                  Form(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical:tFormHeight- 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.person_outline_outlined),
                                labelText: tEmail,
                                hintText: tEmail,
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: tFormHeight-20,),
                            TextFormField(
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.key_outlined),
                                labelText: tPassword,
                                hintText: tPassword,
                                border: OutlineInputBorder(),
                                suffixIcon: IconButton(
                                    onPressed: null,
                                    icon: Icon(Icons.remove_red_eye_sharp),
                                ),
                              ),
                            ),
                            const SizedBox(height: tFormHeight-20),
                            Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(onPressed: (){}, child: const Text(tForgetPassword))
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: (){},
                                  child: Text(tLogin.toUpperCase())),
                            ),
                          ],
                        ),
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("OR"),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                            icon: Image(image: AssetImage(tGoogleLogoImage), width: 20.0,),
                            onPressed: (){},
                            label: Text(tSignInWithGoogle),
                        ),
                      ),
                      const SizedBox(height: tFormHeight-20,),
                      TextButton(
                          onPressed: (){},
                          child: Text(tAlreadyHaveAnAccount),),
                    ],
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}

/*class login_screen extends  StatelessWidget{
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

}*/
