import 'package:donor/AdminDashborad/AdminDashboard.dart';
import 'package:donor/DonorDashboard/DonorDashboard.dart';
import 'package:donor/Library/TextStyle.dart';
import 'package:donor/StudentDashboard/StudentDashboard.dart';
import 'package:donor/VerifierDashboard/VStudentList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Library/AppColors.dart';
import '../Library/MyNavigator.dart';
import '../Library/Utils.dart';
import '../Login/LoginPage.dart';

class VerifierDrawer extends StatefulWidget {
  const VerifierDrawer({Key? key}) : super(key: key);

  @override
  State<VerifierDrawer> createState() => _VerifierDrawerState();
}

class _VerifierDrawerState extends State<VerifierDrawer> {
  @override
  void initState() {
    Get.put(Utils()).checkMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Utils>(builder: (utilsController) {
      return Container(
        color: AppColors.primaryColor,
        child: SafeArea(
          child: Drawer(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(utilsController.logo.toString()))),
                  accountName: null,
                  accountEmail: null,
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const VStudentList(
                              status: "2",
                            )));
                    MyNavigator.goToSignOut(context);
                  },
                  leading: const Icon(Icons.verified_user,
                      color: AppColors.primaryColor, size: 30),
                  title: const Text('VERIFIED', style: FontStyle.drawerText),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const VStudentList(
                              status: "1",
                            )));
                  },
                  leading: const Icon(Icons.pending_actions_outlined,
                      color: AppColors.primaryColor, size: 30),
                  title: Text('PENDING'.toUpperCase(),
                      style: FontStyle.drawerText),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ));
                  },
                  leading: const Icon(Icons.logout_rounded,
                      color: AppColors.primaryColor, size: 30),
                  title: const Text('LOGOUT', style: FontStyle.drawerText),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
