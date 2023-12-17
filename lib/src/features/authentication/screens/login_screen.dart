import 'package:flutter/material.dart';
import 'package:rent_hub_flutter_project/src/constants/images_strings.dart';
import 'package:rent_hub_flutter_project/src/constants/sizes.dart';
import 'package:rent_hub_flutter_project/src/constants/text_strings.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/forget_password_mail.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/forget_password_phn_no.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/signUp_screen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image(
                image: const AssetImage(tWelcomeScreenImage),
                height: size.height * 0.2,
              ),
              Text(
                tLoginTitle,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Text(
                tLoginSubTitle,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Form(
                  child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: tFormHeight - 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(13),
                        prefixIcon: Icon(Icons.person_outline_outlined),
                        labelText: tEmail,
                        hintText: tEmail,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: tFormHeight - 20,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(13),
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
                    const SizedBox(height: tFormHeight - 20),
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {
                              showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                context: context,
                                builder: (context) => Container(
                                  padding: const EdgeInsets.all(tDefaultSize),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        tForgetPasswordTitle,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                      ),
                                      Text(
                                        tForgetPasswordSubTitle,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                      const SizedBox(height: 30.0),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(context,
                                          MaterialPageRoute(builder: (context)=>const ForgetPasswordMailScreen(),),
                                        );
                                          },
                                        child: Container(
                                          padding: const EdgeInsets.all(20.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: Theme.of(context).cardColor,
                                          ),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.mail_outline_rounded,
                                                size: 60.0,
                                              ),
                                              const SizedBox(
                                                width: 10.0,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    tEmail,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge,
                                                  ),
                                                  Text(
                                                    tResetViaEMail,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20.0,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context)=>const ForgetPasswordPhoneNoScreen(),),
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(20.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            color: Theme.of(context).cardColor,
                                          ),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.mobile_friendly_rounded,
                                                size: 60.0,
                                              ),
                                              const SizedBox(
                                                width: 10.0,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    tPhoneNo,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleLarge,
                                                  ),
                                                  Text(
                                                    tResetViaPhone,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            child: const Text(tForgetPassword))),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          tLogin.toUpperCase(),
                          //style: const TextStyle(color: Colors.white),
                        ),
                      ),
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
                      icon: const Image(
                        image: AssetImage(tGoogleLogoImage),
                        width: 20.0,
                      ),
                      onPressed: () {},
                      label: const Text(tSignInWithGoogle),
                    ),
                  ),
                  const SizedBox(
                    height: tFormHeight - 20,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>const SignUpPage(),),
                      );
                    },
                    child: Text.rich(
                      TextSpan(
                        text: tDontHaveAnAccount,
                        style: Theme.of(context).textTheme.bodyLarge,
                        children: const [
                          TextSpan(
                            style: TextStyle(color: Colors.blue),
                            text: tSignup,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
