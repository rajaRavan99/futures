import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebasedatareleted/demologin.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'package:firebasedatareleted/homepage.dart';
import 'package:firebasedatareleted/loginpage.dart';
import 'package:firebasedatareleted/utils.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupFirebaseNotification();

  runApp(const MyApp());
}

Future<void> setupFirebaseNotification() async {
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  try {
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      requestPermissionss();
    }

    //Handle the background notifications (the app is termianted)
    FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) {
        if (kDebugMode) {
          print("ON INITIAL MESSAGE TITLE ==> ${value.notification?.title}");
          print("ON INITIAL MESSAGE BODY==> ${value.notification?.body}");
        }
      }
      if (kDebugMode) {
        print("messages handleed in background $value");
      }
    });

    //Handle the notification if the app is in Foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      // RemoteNotification notification1 = message.data['title'];

      // AndroidNotification? android = message.notification?.android;

      if (notification != null) {
        if (kDebugMode) {
          print(
              "ON ANDROID FOREGROUND MESSAGE TITLE ==> ${message.notification?.title}");
          print(
              "ON ANDROID FOREGROUND MESSAGE BODY ==> ${message.notification?.body}");
        }

        String? title;
        String? body;
        if (Platform.isIOS) {
          title = notification.title;
          body = notification.body;
        } else if (Platform.isAndroid) {
          title = message.notification?.title;
          body = message.notification?.body;
        }

        print(title);
        print(body);
        //
      } else {
        if (kDebugMode) {
          print("data not available");
        }
      }
    });

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);

    //Handle the background notifications (the app is closed but not termianted)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('A new onMessageOpenedApp event was published!');
        print("ON MESSAGEOPEN APP TITLE ==> ${message.notification?.title}");
        print("ON MESSAGEOPEN APP BODY ==> ${message.notification?.body}");
      }
      // showPushNotificationWithAlertDialog((message.notification?.title ?? ""),
      //     (message.notification?.body ?? ""));
    });
  } on PlatformException catch (e) {
    if (kDebugMode) {
      print("message------ PlatformException $e");
    }
  } catch (e) {
    if (kDebugMode) {
      print("message------ Exception $e");
    }
  }

  _firebaseMessaging.getToken().then((token) {
    if (kDebugMode) {
      print("TOKEN ==> $token");
    }
  });
}

void requestPermissionss() {
  try {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        )
        .then((value) {
      if (!value!) {
        if (kDebugMode) {
          print("Please allow permission from settings");
        }
      }
    });
  } catch (e) {
    if (kDebugMode) {
      print("===exception" + e.toString());
    }
  }
}

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
bool permissionAllowed = false;
AndroidNotificationChannel channel = const AndroidNotificationChannel(
  '1',
  'tellme_build',
  importance: Importance.high,
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final navigatorkey = GlobalKey<NavigatorState>();
    return GetMaterialApp(
        scaffoldMessengerKey: Utils.messengerKey,
        title: 'Flutter Demo',
        navigatorKey: navigatorkey,
        showSemanticsDebugger: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: loginwidget());
  }
}

class homepage extends StatelessWidget {
  const homepage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // if (snapshot.hasData) {
            //   return const emailverified();
            // } else {
            //   return loginwidget();
            // }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Text('Something Went wrong');
            } else if (snapshot.hasData) {
              return DashBoard();
            } else {
              return loginwidget();
            }
          },
        ),
      );
}
