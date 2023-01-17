import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ApiData.dart';
import 'ManageStorage.dart';
import 'Utils.dart';
import 'loginchk.dart';

class MyNavigator {
  static void goToDashBoard(BuildContext context) async {
    var User = await CheckLogin.chkauth();
    if (User == null) {
      Navigator.of(context).pushNamedAndRemoveUntil('/Login', (route) => false);
    } else {
      await ApiData().get_access_code();
      var isVerify = await AppStorage.getData('is_verify') ?? "0";
      if (isVerify.toString() == '0') {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/ProfilePage', (route) => false);
        // Navigator.of(context)
        //     .pushNamedAndRemoveUntil('/ProfileUpdate', (route) => false);
      } else if (isVerify.toString() == "1") {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/HomePage', (route) => false);
      }
    }
  }

  static void goToLoginPage(BuildContext context) async {
    var User = await AppStorage.getData('UserId');
    if (User == null) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/loginPage', (route) => false);
    } else {
      Utils().successSnack(context, "You are already signed.");
    }
  }

  static void goToSignOut(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    var uName = await AppStorage.getData('uname');
    if ((uName ?? "") == "") {
      Navigator.of(context).pushNamedAndRemoveUntil('/Login', (route) => false);
    } else {
      MyNavigator.goToDashBoard(context);
    }
  }
}
