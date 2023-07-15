import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notificationfinal/main.dart';

class FirebaseData {
  final app = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await app.requestPermission();
    final tokenID = await app.getToken();
    print('Token: $tokenID');
    initpushNotification();
    FirebaseMessaging.onBackgroundMessage((message) async {
      handleBeckgroundMessage;
    });
  }
}

Future<void> handleBeckgroundMessage(RemoteMessage message) async {
  print('title: ${message.notification?.title}');
  print('body: ${message.notification?.body}');
  print('payload: ${message.data}');
}

void handelMassage(RemoteMessage? message) {
  if (message == null) return;
  // navigatorKey.currentState?.pushedNumed;
}

Future initpushNotification() async {
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, sound: true, badge: true);
  FirebaseMessaging.instance.getInitialMessage().then(handelMassage);
  FirebaseMessaging.onMessageOpenedApp.listen(handelMassage);
  FirebaseMessaging.onBackgroundMessage(handleBeckgroundMessage);
}
