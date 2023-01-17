import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:future/Library/TextStyle.dart';
import 'package:future/pages/SettingPage.dart';
import 'package:future/pages/VideoPage.dart';
import 'package:get/get.dart';
import '../Library/AppColors.dart';
import '../Library/Utils.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<MyDrawer> {
  final user = FirebaseAuth.instance.currentUser;
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
                const SizedBox(
                  height: 15,
                ),
                UserAccountsDrawerHeader(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: const DecorationImage(
                      image: NetworkImage(
                        'https://www.wallpapers13.com/wp-content/uploads/2015/11/Beautiful-loving-couple-romance-in-nature-autumn-leaves-HD-Wallpaper-1920x1200-1440x900.jpg',
                      ),
                    ),
                  ),
                  accountName: null,
                  accountEmail: Text(user!.email.toString(),
                      style: FontStyle.buttonBoldWhite),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VideoPage(),
                        ));
                  },
                  leading: const Icon(Icons.image,
                      color: AppColors.primaryColor, size: 30),
                  title: const Text(
                    'Images',
                    style: FontStyle.drawerText,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const VideoPage(),
                        ));
                  },
                  leading: const Icon(
                    Icons.theater_comedy,
                    color: AppColors.primaryColor,
                    size: 30,
                  ),
                  title: const Text(
                    'Vides',
                    style: FontStyle.drawerText,
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingPage(),
                        ));
                  },
                  leading: const Icon(
                    Icons.theater_comedy,
                    color: AppColors.primaryColor,
                    size: 30,
                  ),
                  title: const Text(
                    'Vides',
                    style: FontStyle.drawerText,
                  ),
                ),
                ListTile(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                  },
                  leading: const Icon(
                    Icons.logout,
                    color: AppColors.primaryColor,
                    size: 30,
                  ),
                  title: const Text(
                    'Log Out',
                    style: FontStyle.drawerText,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
