import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:future/ApiPage.dart/ApiHomepage.dart';
import 'package:future/Library/AppColors.dart';
import 'package:future/pages/HomePage.dart';
import 'package:future/pages/Logins/MobileVerification.dart';
import 'package:future/pages/Logins/SignIn.dart';
import 'package:future/pages/Logins/SignUp.dart';
import 'package:future/pages/Logins/Verification.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final navigatorkey = GlobalKey<NavigatorState>();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      navigatorKey: navigatorkey,
      showSemanticsDebugger: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSwatch().copyWith(primary: AppColors.black),
      ),
      home: const homepage(),
      routes: {
        'phone': (context) => MobileLogin(),
        'verify': (context) => MyVerify()
      },
    );
  }
}

class homepage extends StatelessWidget {
  const homepage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Text('Something Went wrong');
            } else if (snapshot.hasData) {
              return const HomePage();
            } else {
              return const HomePage();
            }
          },
        ),
      );
}
