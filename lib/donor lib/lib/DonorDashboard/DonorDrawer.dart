import 'package:donor/AdminDashborad/AdminDashboard.dart';
import 'package:donor/DonorDashboard/DStudentDetail.dart';
import 'package:donor/DonorDashboard/StudentListPage.dart';
import 'package:donor/Library/TextStyle.dart';
import 'package:donor/StudentDashboard/StudentActivity.dart';
import 'package:donor/StudentDashboard/StudentDashboard.dart';
import 'package:donor/StudentDashboard/StudentFundingHistory.dart';
import 'package:donor/StudentDashboard/StudentProfile.dart';
import 'package:donor/VerifierDashboard/VerifierDashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Library/AppColors.dart';
import '../Library/Utils.dart';
import '../Login/LoginPage.dart';

class DonorDrawer extends StatefulWidget {
  const DonorDrawer({Key? key}) : super(key: key);

  @override
  State<DonorDrawer> createState() => _DonorDrawerState();
}

class _DonorDrawerState extends State<DonorDrawer> {
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
                    Navigator.pop(context);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const StudentListPage()));
                  },
                  leading: const Icon(Icons.person,
                      color: AppColors.primaryColor, size: 30),
                  title:
                      const Text('Student List', style: FontStyle.drawerText),
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
                  title: const Text('Logout', style: FontStyle.drawerText),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
