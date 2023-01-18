// ignore: unused_import
import 'package:aug_new_demo/extrapages/loginpagedesigndemo.dart';
import 'package:aug_new_demo/ui_pages/First_homepage.dart';
import 'package:aug_new_demo/ui_pages/no_Interetavalible.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controller/internet_controller.dart';
import 'controller/theme.dart';

//firebase authentication start for this page;-
// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await FirebaseFirestore.instance;

//firebase authentication end for this page;-

// void main() {
//   runApp(const MyApp());
//   // create:
//   // (BuildContext context) => Themeprovider(isdarkmode: true);
// }

// Themeprovider({required bool isdarkmode}) {}

void main() {
  // await FirebaseFirestore.instance;

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then(
    (prefs) {
      var isDarkTheme = prefs.getBool("darkTheme") ?? false;
      return runApp(
        ChangeNotifierProvider<ThemeProvider>(
          child: const MyApp(),
          create: (BuildContext context) {
            return ThemeProvider(isDarkTheme);
          },
        ),
      );
    },
  );

  Singleton.instance.isInternetConnected().then((intenet) {
    // ignore: unnecessary_null_comparison
    if (intenet != null && intenet) {
      Get.to(first_Homepage());
    } else {
      Get.to(const Nointernetaccess());
    }
  });

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, value, child) {
      return GetMaterialApp(
        // key: Get.key,
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: value.getTheme(),
        home: first_Homepage(),
      );
    });
  }
}



// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return signup();
//   }
// }
