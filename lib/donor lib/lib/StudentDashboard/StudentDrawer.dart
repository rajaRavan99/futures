import 'package:donor/AdminDashborad/AdminDashboard.dart';
import 'package:donor/DonorDashboard/DonorDashboard.dart';
import 'package:donor/Library/MyNavigator.dart';
import 'package:donor/Library/TextStyle.dart';
import 'package:donor/StudentDashboard/RaisedFundList.dart';
import 'package:donor/StudentDashboard/StudentFundingHistory.dart';
import 'package:donor/VerifierDashboard/VerifierDashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Library/AppColors.dart';
import '../Library/Utils.dart';
import 'StudentActivity.dart';
import 'StudentProfile.dart';

class StudentDrawer extends StatefulWidget {
  const StudentDrawer({Key? key}) : super(key: key);

  @override
  State<StudentDrawer> createState() => _StudentDrawerState();
}

class _StudentDrawerState extends State<StudentDrawer> {
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
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage(
                        utilsController.logo.toString(),
                      ),
                    ),
                  ),
                  accountName: null,
                  accountEmail: null,
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const StudentProfile()));
                  },
                  leading: const Icon(Icons.person,
                      color: AppColors.primaryColor, size: 30),
                  title: const Text('PROFILE', style: FontStyle.drawerText),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const StudentActivity()));
                  },
                  leading: const Icon(Icons.person_pin_circle_outlined,
                      color: AppColors.primaryColor, size: 30),
                  title: Text('ACTIVITIES'.toUpperCase(),
                      style: FontStyle.drawerText),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const RaisedFundList()));
                  },
                  leading: const Icon(Icons.note_alt_outlined,
                      color: AppColors.primaryColor, size: 30),
                  title: const Text('RAISED FUND', style: FontStyle.drawerText),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const StudentFundingHistory()));
                  },
                  leading: const Icon(Icons.history,
                      color: AppColors.primaryColor, size: 30),
                  title: const Text('FUNDING HISTORY',
                      style: FontStyle.drawerText),
                ),
                ListTile(
                  onTap: () {
                    MyNavigator.goToSignOut(context);
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
