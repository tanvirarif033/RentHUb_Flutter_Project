import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/ThemeModeProvider.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/login_screen.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/notification_service.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/splash_screen.dart';
import 'package:rent_hub_flutter_project/src/utils/theme/theme.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeModeProvider(),
      child:  MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  NotificationServices notificationServices =NotificationServices();

   /*void intState(){
     super.intState();
      notificationServices.requestNotificationPermission();
   }*/
  @override
  Widget build(BuildContext context) {

    ThemeMode currentThemeMode = ThemeMode.light;

    void toggleThemeMode() {
      currentThemeMode = currentThemeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    }
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      themeMode: currentThemeMode,
      home: const splash_screen(
        child: LogIn(), // Assuming WelcomeScreen is the initial screen after the splash screen

      ),
    );
  }
}


