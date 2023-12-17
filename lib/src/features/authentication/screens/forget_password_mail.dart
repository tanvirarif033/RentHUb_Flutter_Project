import 'package:flutter/material.dart';
import 'package:rent_hub_flutter_project/src/constants/sizes.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/otp_screen.dart';

import '../../../constants/images_strings.dart';
import '../../../constants/text_strings.dart';

class ForgetPasswordMailScreen extends StatelessWidget {
  const ForgetPasswordMailScreen({super.key});

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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
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
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context)=>const OTPScreen(),),
                              );
                            },
                            child: const Text(tNext),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
