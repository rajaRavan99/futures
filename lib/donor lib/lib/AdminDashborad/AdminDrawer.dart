import 'package:donor/AdminDashborad/AFundRequestList.dart';
import 'package:donor/AdminDashborad/AddUser.dart';
import 'package:donor/AdminDashborad/UserList.dart';
import 'package:donor/DonorDashboard/DonorDashboard.dart';
import 'package:donor/Library/TextStyle.dart';
import 'package:donor/StudentDashboard/StudentDashboard.dart';
import 'package:donor/VerifierDashboard/VerifierDashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Library/AppColors.dart';
import '../Library/Utils.dart';
import '../Login/LoginPage.dart';

class AdminDrawer extends StatefulWidget {
  const AdminDrawer({Key? key}) : super(key: key);

  @override
  State<AdminDrawer> createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddUser(),
                        ));
                  },
                  leading: const Icon(Icons.person_add_alt_outlined,
                      color: AppColors.primaryColor, size: 30),
                  title: const Text('Add User', style: FontStyle.drawerText),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserList(),
                        ));
                  },
                  leading: const Icon(Icons.supervised_user_circle_outlined,
                      color: AppColors.primaryColor, size: 30),
                  title: const Text('User List', style: FontStyle.drawerText),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AFundRequestList(),
                        ));
                  },
                  leading: const Icon(Icons.list_alt_sharp,
                      color: AppColors.primaryColor, size: 30),
                  title: const Text('Total Fund Request',
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
