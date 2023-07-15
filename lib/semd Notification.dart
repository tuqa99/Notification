import 'dart:async';
import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'notification screen.dart';

class SendNotification extends StatefulWidget {
  const SendNotification({super.key});

  @override
  State<SendNotification> createState() => _SendNotificationState();
}

class _SendNotificationState extends State<SendNotification> {
  final String serverToken =
      'AAAAZHKvA8A:APA91bE4xAQJ7xHv3ukfZKnKXVtHG0gtKsGgine8TJ69m5dAhECp4pemMSBciHWpSG0F40uJTeTIjloL4UMwMPqBA8Hwv62dzsiEe9aSSxBqtwkAee_3XYVa7lWZmFVa2A_YTh6vL3Kl';
  sendNotify(String title, String body, String id) async {
    await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': body.toString(),
            'title': title.toString(),
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': id.toString(),
            'name': 'tuqa',
            'last name': 'abu dahab'
          },
          'to': await FirebaseMessaging.instance.getToken()
        },
      ),
    );
  }

  getmassege() {
    FirebaseMessaging.onMessage.listen((message) {
      //   print('====================================');
      //   print(message.notification?.title);
      //   print(message.notification?.body);
      //   print(message.data['name']);
      AwesomeDialog(
        context: context,
        titleTextStyle: TextStyle(fontSize: 23),
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        title: 'notification',
        desc: 'Dialog description here.............',
        body: Text('${message.notification?.body}'),
        btnCancelOnPress: () {},
        btnOkOnPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => notificationpage()),
          );
        },
      ).show();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getmassege();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: MaterialButton(
        onPressed: () async {
          await sendNotify("title", "body", "id");
        },
        child: Text('send notify'),
      ),
    );
  }
}
