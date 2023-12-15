import 'package:flutter/material.dart';
import 'package:rent_hub_flutter_project/userType_screen.dart';
import '../../../constants/images_strings.dart';
import '../../../constants/sizes.dart';
import '../../../constants/text_strings.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
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
                image: AssetImage(tWelcomeScreenImage),
                height: size.height * 0.2,
              ),
              Text(
                tSignUpTitle,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Text(
                tSignUpSubTitle,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Form(
                  child: Container(
                padding: EdgeInsets.symmetric(vertical: tFormHeight - 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(13),
                        prefixIcon: Icon(Icons.person_outline_outlined),
                        labelText: tFullName,
                        hintText: tFullName,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(
                      height: tFormHeight - 20,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(13),
                        prefixIcon: Icon(Icons.mail_outline_outlined),
                        labelText: tEmail,
                        hintText: tEmail,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: tFormHeight - 20),
                    TextFormField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(13),
                        prefixIcon: Icon(Icons.numbers_outlined),
                        labelText: tPhoneNo,
                        hintText: tPhoneNo,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: tFormHeight-20),
                    TextFormField(
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(13),
                        prefixIcon: Icon(Icons.key_outlined),
                        labelText: tPassword,
                        hintText: tPassword,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: tFormHeight-20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          tSignup.toUpperCase(),
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
                      icon: Image(
                        image: AssetImage(tGoogleLogoImage),
                        width: 20.0,
                      ),
                      onPressed: () {},
                      label: Text(tSignInWithGoogle),
                    ),
                  ),
                  const SizedBox(
                    height: tFormHeight - 20,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text.rich(
                      TextSpan(
                        text: tAlreadyHaveAnAccount,
                        style: Theme.of(context).textTheme.bodyLarge,
                        children:  [
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
}
