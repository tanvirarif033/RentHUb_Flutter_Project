import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/login_screen.dart';
import '../../../constants/images_strings.dart';
import '../../../constants/sizes.dart';
import '../../../constants/text_strings.dart';
import 'firebase_auth_services.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool passwordVisible=false;

  @override
  void initState(){
    super.initState();
    passwordVisible=true;
  }

  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
              padding: const EdgeInsets.all(tDefaultSize),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image: const AssetImage(tWelcomeScreenImage),
                    height: size.height * 0.2,
                  ),
                  Text(
                    tSignUpTitle,
                    style: Theme
                        .of(context)
                        .textTheme
                        .displayLarge,
                  ),
                  Text(
                    tSignUpSubTitle,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyLarge,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: tFormHeight - 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller:_usernameController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(13),
                            prefixIcon: Icon(Icons.person_outline_outlined),
                            labelText: tFullName,
                            hintText: tFullName,
                            border: OutlineInputBorder(),
                            filled: true,
                          ),
                        ),
                        const SizedBox(
                          height: tFormHeight - 20,
                        ),
                        TextField(
                          controller:_emailController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.all(13),
                            prefixIcon: Icon(Icons.mail_outline_outlined),
                            labelText: tEmail,
                            hintText: tEmail,
                            border: OutlineInputBorder(),
                            filled: true,
                          ),
                        ),
                        const SizedBox(height: tFormHeight - 20),
                        TextField(
                          controller:_passwordController,
                          obscureText: passwordVisible,
                          decoration:  InputDecoration(
                            contentPadding: const EdgeInsets.all(13),
                            prefixIcon: const Icon(Icons.key_outlined),
                            labelText: tPassword,
                            hintText: tPassword,
                            border: const OutlineInputBorder(),
                            filled: true,
                            alignLabelWithHint: false,
                            suffixIcon: IconButton(
                              icon: Icon(passwordVisible ? Icons.visibility:Icons.visibility_off),
                              onPressed: (){
                                setState(() {
                                  passwordVisible =!passwordVisible;
                                },
                                );
                              },
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                        ),
                        const SizedBox(height: tFormHeight - 20),
                        SizedBox(
                          width: double.infinity,
                          child:  ElevatedButton(
                            onPressed: () {
                              _singUp();
                            },
                            child: Text(
                              tSignup.toUpperCase(),

                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("OR"),
                      const SizedBox(height: 10.0,),
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
                            MaterialPageRoute(builder: (context)=>const LogIn(),),
                          );
                        },
                        child: Text.rich(
                          TextSpan(
                            text: tAlreadyHaveAnAccount,
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge,
                            children: [
                              TextSpan(
                                style: const TextStyle(color: Colors.blue),
                                text: tLogin.toUpperCase(),
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
  void _singUp() async{
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user =await _auth.signUpWithEmailAndPassword(email, password);
    if(user != null){
      print("user is successfully created");
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const LogIn()));
    }else{
      print("some error happened");
    }
  }
}
