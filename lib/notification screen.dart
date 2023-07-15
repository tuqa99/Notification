import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class notificationpage extends StatefulWidget {
  const notificationpage({super.key});

  @override
  State<notificationpage> createState() => _notificationpageState();
}

class _notificationpageState extends State<notificationpage> {
  Future<void> handleBeckgroundMessage(RemoteMessage message) async {
    print('title: ${message.notification?.title}');
    print('body: ${message.notification?.body}');
    print('payload: ${message.data}');
  }

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('title:123'),
            )
          ],
        ),
      ),
    );
  }
}

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
