import 'package:donor/Library/AppColors.dart';
import 'package:donor/Login/RegisterPage.dart';
import 'package:donor/SplashScreen.dart';
import 'package:donor/StudentDashboard/AddOtherInfo.dart';
import 'package:donor/StudentDashboard/AddPersonalInfo.dart';
import 'package:donor/StudentDashboard/StudentDashboard.dart';
import 'package:donor/VerifierDashboard/VerifierDashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'AdminDashborad/AdminDashboard.dart';
import 'DonorDashboard/DonorDashboard.dart';
import 'Library/firebase_option.dart';
import 'Login/LoginPage.dart';

Future<void> main() async {
  runApp(const MyApp());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Donor App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(primary: AppColors.primaryColor)),
      home: const SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/StudentDashboard': (BuildContext context) => const StudentDashboard(),
        '/DonorDashboard': (BuildContext context) => const DonorDashboard(),
        '/AdminDashboard': (BuildContext context) => const AdminDashboard(),
        '/VerifierDashboard': (BuildContext context) =>
            const VerifierDashboard(),
        '/Login': (BuildContext context) => const LoginPage(),
        '/Registration': (BuildContext context) => const RegisterPage(),
        '/AddPersonalInfo': (BuildContext context) => const AddPersonalInfo(isRegister: true),
        '/AddOtherInfo': (BuildContext context) => const AddOtherInfo(isRegister: true),
      },
    );
  }
}
