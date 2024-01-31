import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices{

  //static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  //FlutterLocalNotificationsPlugin();
  FirebaseMessaging messaging =FirebaseMessaging.instance;

   void requestNotificationPermission()async{
    NotificationSettings settings =await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if(settings.authorizationStatus == AuthorizationStatus.authorized){
      print('user granted permission');
    }else if(settings.authorizationStatus == AuthorizationStatus.provisional){
      print('user granted provisional permission');
    }else{
      print('user denied permission');
    }
  }
  Future<String>getDeviceToken() async{
    String? token= await messaging.getToken();
    return token!;
  }
  void isTokenRefresh()async{
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      print('refresh');
    });
  }

}