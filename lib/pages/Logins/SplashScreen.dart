import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:future/Library/TextStyle.dart';
import 'package:get/get.dart';
import '../../Library/AppColors.dart';
import '../../Library/MyNavigator.dart';

class SplashScreen extends StatefulWidget {
  final Color backgroundColor = Colors.white;
  final TextStyle styleTextUnderTheLoader = const TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  bool isInternetOn = true;
  final splashDelay = 3;
  int count = 0;
  bool checkLocalAuth = false;

  @override
  void initState() {
    loadWidget();
    super.initState();
  }

  loadWidget() async {
    var duration = Duration(seconds: splashDelay);
    return Timer(
      duration,
      navigationPage,
    );
  }

  void navigationPage() async {
    MyNavigator().goToDashBoard(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white_00,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Center(
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://th.bing.com/th/id/OIP.mbQDIhh9reWCFsxnsmc0qQHaKH?pid=ImgDet&w=630&h=860&rs=1'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            child: Column(
              children: [
                isInternetOn
                    ? const Text(
                        "",
                        style: FontStyle.textLabel,
                      )
                    : const Text(
                        "Please Check Your Internet Connection",
                        style: FontStyle.textLabel,
                      ),
                const SizedBox(
                  height: 20.0,
                ),
                const SpinKitThreeBounce(
                  color: AppColors.primaryColor,
                  size: 30.0,
                ),
                const SizedBox(
                  height: 30.0,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
