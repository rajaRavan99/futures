import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasedatareleted/homepage.dart';
import 'package:firebasedatareleted/loginpage.dart';
import 'package:firebasedatareleted/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class emailverified extends StatefulWidget {
  const emailverified({super.key});

  @override
  State<emailverified> createState() => _emailverifiedState();
}

// ignore: camel_case_types
class _emailverifiedState extends State<emailverified> {
  bool isemailverified = false;
  final user = FirebaseAuth.instance.currentUser!;
  Timer? timer;

  @override
  void initstate() {
    super.initState();

    isemailverified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isemailverified) {
      sendverificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isemailverified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isemailverified) timer?.cancel();
  }

  Future sendverificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
    } catch (e) {
      Utils.showSnackBar(e.toString());
    }
  }

  // final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) => isemailverified
      ? DashBoard()
      : Scaffold(
          appBar: AppBar(
            title: const Text('Verified Email'),
          ),
          body: Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Get.to(loginwidget());
                  },
                  child: const Text('BacktoHome'),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  user.email!,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed: () => FirebaseAuth.instance.signOut(),
                    child: const Text('Logout'))
              ],
            ),
          ),
        );
}
