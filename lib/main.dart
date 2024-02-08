import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/ThemeModeProvider.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/login_screen.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/notification_controller.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/notification_service.dart';
import 'package:rent_hub_flutter_project/src/features/authentication/screens/splash_screen.dart';
import 'package:rent_hub_flutter_project/src/utils/theme/theme.dart';
import 'firebase_options.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeModeProvider(),
      child: MyApp(),
    ),
  );
}
Future<void>_firebaseMessagingBackgroundHandler(RemoteMessage message)async{
  await Firebase.initializeApp();
  print(message.notification?.title.toString());
}
class MyApp extends StatefulWidget {
  MyApp({super.key}) ;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod: NotificationController.onNotificationCreateMethod,
      onNotificationDisplayedMethod: NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: NotificationController.onDismissActionReceivedMethod,
    );
    super.initState();

    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.getDeviceToken().then((value){
      print('device token: ');
      print(value);
    });

  }

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
        child: LogIn(), // Assuming LogIn is the initial screen after the splash screen
      ),
    );
  }
}
