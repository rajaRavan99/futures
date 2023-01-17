// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:future/pages/HomePage.dart';

class MyNavigator {
  goToDashBoard(BuildContext context) async {
    Navigator.push(
      context,
      // ignore: prefer_const_constructors
      MaterialPageRoute(builder: (context) => HomePage()),
    );
    // var User = await CheckLogin.chkauth();
    // if (User == null) {
    //   Navigator.of(context).pushNamedAndRemoveUntil('/Login', (route) => false);
    // } else {
    //   await ApiData().get_access_code();
    //   var isVerify = await AppStorage.getData('is_verify') ?? "0";
    //   print(isVerify);
    //   if (isVerify.toString() == "0") {
    //     Navigator.of(context).pushNamedAndRemoveUntil('/Registration', (route) => false);
    //   } else {
    //     var utype = await AppStorage.getData("utype");
    //     if (utype.toString() == "1") {
    //       Navigator.of(context)
    //           .pushNamedAndRemoveUntil('/StudentDashboard', (route) => false);
    //     } else if (utype.toString() == "2") {
    //       Navigator.of(context)
    //           .pushNamedAndRemoveUntil('/DonorDashboard', (route) => false);
    //     } else if (utype.toString() == "3") {
    //       Navigator.of(context)
    //           .pushNamedAndRemoveUntil('/AdminDashboard', (route) => false);
    //     } else if (utype.toString() == "4") {
    //       Navigator.of(context)
    //           .pushNamedAndRemoveUntil('/VerifierDashboard', (route) => false);
    //     } else {
    //       Navigator.of(context)
    //           .pushNamedAndRemoveUntil('/Registration', (route) => false);
    //     }
    //   }
    // }
  }

  // static void goToDashBoardBack(BuildContext context) async {
  //   var utype = await AppStorage.getData("utype");
  //   if (utype == "1" || utype == 1) {
  //     Navigator.of(context).pushNamed('/OwnerDashBoard');
  //   } else {
  //     Navigator.of(context).pushNamed('/WalkerDashBoard');
  //   }
  // }

  // static void goToLoginPage(BuildContext context) async {
  //   var User = await CheckLogin.chkauth();
  //   if (User == null) {
  //     Navigator.of(context).pushNamedAndRemoveUntil('/LogIn', (route) => false);
  //   } else {
  //     var utype = await AppStorage.getData("utype");
  //     if (utype == "1" || utype == 1) {
  //       Navigator.of(context).pushNamed('/OwnerDashBoard');
  //     } else {
  //       Navigator.of(context).pushNamed('/WalkerDashBoard');
  //     }
  //   }
  // }

  // static void userLogin(BuildContext context) async {
  //   try {
  //     var data = {};
  //     var User = await CheckLogin.chkauth();
  //     if (User != null) {
  //       data = UserModelToJson(UserModel());
  //       data['umobile'] = await AppStorage.getData("umobile");
  //       data['uname'] = "";
  //       data['utype'] = "";
  //       data['is_verify'] = "0";
  //       var res = await ApiData().send_data(data, 'update_profile');
  //       if (res['st'] == "success") {
  //         print(res['user']['uid']);
  //         AppStorage.setData('uid', res['user']['uid']);
  //         AppStorage.setData("utype", res['user']['utype']);
  //         AppStorage.setData('is_verify', res['user']['is_verify']);
  //         Utils().successSnack(context, "Successfully signed");
  //         if (res['user']['is_verify'] == "0") {
  //           Navigator.pushNamed(context, '/ChooseType');
  //         } else {
  //           var utype = await AppStorage.getData("utype");
  //           MyNavigator().goToDashBoard(context);
  //         }
  //       } else {
  //         Utils().errorSnack(context, "Login Failed");
  //       }
  //     }else {
  //       Utils().errorSnack(context, "Login Failed");
  //     }
  //   } catch (e) {
  //     print('print error: $e');
  //   }
  // }

  // static void goToSplashScreen(BuildContext context) async {
  //   Navigator.of(context)
  //       .pushNamedAndRemoveUntil('/splashscreen', (route) => false);
  // }

  // static void goToSignOut(BuildContext context) async {
  //   await FirebaseAuth.instance.signOut();
  //   AppStorage.setData("umobile", "");
  //   AppStorage.setData("uid", "");
  //   AppStorage.setData("utype", "");
  //   MyNavigator().goToDashBoard(context);

  //   // var User = await CheckLogin.chkauth();
  //   // if (User == null) {
  //   //   MyNavigator.goToLoginPage(context);
  //   // } else {
  //   //   MyNavigator().goToDashBoard(context);
  //   // }
  // }
}
