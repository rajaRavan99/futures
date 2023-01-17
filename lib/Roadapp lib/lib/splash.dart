import 'dart:async';

import 'package:flutter/material.dart';
import 'package:roadapp/Library/AppColors.dart';
import 'package:roadapp/Library/MyNavigator.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final splashDelay = 3;
  @override
  void initState() {
    super.initState();
    loadWidget();
  }

  loadWidget() async {
    var duration = Duration(seconds: splashDelay);
    return Timer(duration, navigationPage);
  }

  void navigationPage() async {
    MyNavigator.goToDashBoard(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          color: AppColors.white_00,
          image: DecorationImage(
            image: AssetImage('assets/image/road.gif'),
            fit: BoxFit.cover,
          )),
    );
  }
}
