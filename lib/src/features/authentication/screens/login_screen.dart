import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/home_page_screen.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/signUp_screen.dart';

import '../../../constants/images_strings.dart';
import '../../../constants/sizes.dart';
import '../../../constants/text_strings.dart';
import 'forgate.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool passwordVisible=false;

  @override
  void initState(){
    super.initState();
    passwordVisible=true;
  }

  String email = "", password = "";

  final _formkey= GlobalKey<FormState>();

  TextEditingController useremailcontroller = TextEditingController();
  TextEditingController userpasswordcontroller = TextEditingController();

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Navigator.push(context, MaterialPageRoute(builder: (context) =>  const Home()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "No User Found for that Email",
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            )));
      }
    }
  }

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
                      key: _formkey,
                      child: Container(
                        padding:
                        const EdgeInsets.symmetric(vertical: tFormHeight - 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller:  useremailcontroller,
                              validator: (value){
                                if(value==null|| value.isEmpty){
                                  return 'Please Enter E-Mail';
                                }
                                return null;
                              },

                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(13),
                                prefixIcon: Icon(Icons.person_outline_outlined),
                                labelText: tEmail,
                                hintText: tEmail,
                                border: OutlineInputBorder(),
                                filled: true,
                              ),
                            ),
                            const SizedBox(
                              height: tFormHeight - 20,
                            ),
                            TextFormField(
                              controller: userpasswordcontroller,
                              validator: (value){
                                if(value==null|| value.isEmpty){
                                  return 'Please Enter Password';

                                }
                                return null;
                              },
                              obscureText: passwordVisible,
                              decoration:  InputDecoration(
                                contentPadding: const EdgeInsets.all(13),
                                prefixIcon: const Icon(Icons.key_outlined),
                                labelText: tPassword,
                                hintText: tPassword,
                                helperText: "Password must contain special character",
                                helperStyle: const TextStyle(color: Colors.deepPurpleAccent),
                                border: const OutlineInputBorder(),
                                suffixIcon: IconButton(
                                  icon: Icon(passwordVisible ? Icons.visibility:Icons.visibility_off),
                                  onPressed: (){
                                    setState(() {
                                      passwordVisible =!passwordVisible;
                                    },
                                    );
                                  },
                                ),
                                alignLabelWithHint: false,
                                filled: true,
                              ),
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
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
                                                    MaterialPageRoute(builder: (context)=> const ForgotPassword(),),
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
                                                    MaterialPageRoute(builder: (context)=> const ForgotPassword()),
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
                                onPressed: () {
                                  if(_formkey.currentState!.validate()){
                                    setState(() {
                                      email= useremailcontroller.text;
                                      password= userpasswordcontroller.text;
                                    });
                                  }
                                  userLogin();
                                },
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
