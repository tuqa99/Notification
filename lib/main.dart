import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:notificationfinal/notification%20screen.dart';
import 'package:notificationfinal/semd%20Notification.dart';
import 'firebasemodel.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();

//   print("Handling a background message: $message");
// }
final navigatorKey = GlobalKey<NavigatorState>();
Future handleBeckgroundMessage(RemoteMessage message) async {
  print('==========================================================');
  print('title: ${message.notification?.title}');
  print('body: ${message.notification?.body}');
  // Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => notificationpage()),
  //       );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(handleBeckgroundMessage);
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SendNotification(),
    );
  }
}

class NotificationsApp extends StatefulWidget {
  const NotificationsApp({super.key});

  @override
  State<NotificationsApp> createState() => _NotificationsAppState();
}

class _NotificationsAppState extends State<NotificationsApp> {
  var fbm = FirebaseMessaging.instance;
  void handelMassage(RemoteMessage? message) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => notificationpage()),
    );
  }

  initialMessag() async {
    var masseg = await FirebaseMessaging.instance.getInitialMessage();
    if (masseg != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => notificationpage()),
      );
    }
  }

  @override
  void initState() {
    initialMessag();
    super.initState();
    fbm.getToken().then((value) {
      print('==============================================');
      print(value);
    });
    FirebaseMessaging.onMessageOpenedApp.listen(handelMassage);
    FirebaseMessaging.onMessage.listen((event) {
      print('========================data notification===================');

      AwesomeDialog(
        context: context,
        titleTextStyle: TextStyle(fontSize: 23),
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        title: 'notification',
        desc: 'Dialog description here.............',
        body: Text('${event.notification?.body}'),
        btnCancelOnPress: () {},
        btnOkOnPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => notificationpage()),
          );
        },
      ).show();
    });

    // FirebaseMessaging.onMessageOpenedApp.listen((event) {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => const notificationpage()),
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: const Text('Notifications Inbox'),
          centerTitle: true,
        ),
      ),
    );
  }
}
