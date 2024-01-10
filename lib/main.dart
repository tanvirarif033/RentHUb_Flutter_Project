import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/filter_page.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/login_screen.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/splash_screen.dart';
import 'package:rent_hub_flutter_project/src/utils/theme/theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: const splash_screen(
        child: LogIn(), // Assuming WelcomeScreen is the initial screen after the splash screen
      ),
    );
  }
}


