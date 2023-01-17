import 'package:flutter/material.dart';
import 'package:stonesearch/Liabrary/AppColors.dart';
import 'Dashboard2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSwatch().copyWith(primary: AppColors.black),
        ),
        home: const DashBoard2());
  }
}
