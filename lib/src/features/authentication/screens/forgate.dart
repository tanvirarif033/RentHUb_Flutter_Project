

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rent_hub_flutter_project/src/constants/text_strings.dart';

import '../../../constants/sizes.dart';
import 'login_screen.dart';
import 'signUp_screen.dart';
import '../../../constants/images_strings.dart';
import '../../../constants/text_strings.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email = "";
  TextEditingController mailcontroller = new TextEditingController();

  final _formkey= GlobalKey<FormState>();

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Password Reset Email has been sent !",
            style: TextStyle(fontSize: 18.0),
          )));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "No user found for that email.",
              style: TextStyle(fontSize: 18.0),
            )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery
        .of(context)
        .size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding:const  EdgeInsets.all(tDefaultSize),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  const SizedBox(
                    height: tDefaultSize * 4,
                  ),
                  Image(
                    image: const AssetImage(tForgetPasswordImage),
                    height: size.height * 0.3,
                  ),
                  Text(
                    tForgetPassword,
                    style: Theme
                        .of(context)
                        .textTheme
                        .displayLarge,
                  ),
                  Text(
                    tForgetMailSubTitle,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyLarge,
                  ),
                  Form(
                    child: Container(
                      padding:
                      const EdgeInsets.symmetric(vertical: tFormHeight - 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: mailcontroller,
                            validator: (value){
                              if(value==null || value.isEmpty){
                                return 'Please Enter Email';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.all(15),
                              prefixIcon: Icon(Icons.mail_outline_rounded),
                              labelText: tEmail,
                              hintText: tEmail,
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if(_formkey.currentState!.validate()){
                                  setState(() {
                                    email= mailcontroller.text;
                                  });
                                  resetPassword();
                                }
                              },
                              child: const Text(tSend),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LogIn(),
                                  ),
                                );
                              },
                              child: Text(tLogin.toUpperCase()),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


