import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:roadapp/Dashboard/HomePage.dart';
import 'package:roadapp/splash.dart';
import 'Authentication/ProfileUpdate.dart';
import 'Authentication/login.dart';
import 'Dashboard/ProfilePage.dart';
import 'Library/firebase_option.dart';

void main() async {
  runApp(const MyApp());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roadapp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        '/Login': (BuildContext context) => const LogIn(),
        '/HomePage': (BuildContext context) => HomePage(),
        '/ProfileUpdate': (BuildContext context) => const ProfileUpdate(),
        '/ProfilePage': (BuildContext context) => const ProfilePage(),
      },
    );
  }
}
