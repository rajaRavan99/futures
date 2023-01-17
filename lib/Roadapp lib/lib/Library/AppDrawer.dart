import 'package:flutter/material.dart';
import 'package:roadapp/Dashboard/ProfilePage.dart';
import 'package:roadapp/Dashboard/RecentUploadList.dart';
import 'package:roadapp/Library/TextStyle.dart';
import '../Dashboard/AboutUs.dart';
import '../Dashboard/HomePage.dart';
import '../Dashboard/NewsList.dart';
import '../Dashboard/TermsCondition.dart';
import 'AppColors.dart';



class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key,required this.scaffoldKey}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  late GlobalKey<ScaffoldState> _scaffoldkey;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [

          SizedBox(
            height: 180,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.blue_00,
              ),
              child: Padding(
                padding: const EdgeInsets.only(right: 40.0),
                child: Row(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Image.asset("assets/image/person.png",width: 60,),
                        // Icon(Icons.account_circle, color: AppColors.black, size: 60),
                      ),
                    ),
                    SizedBox(width: 0),
                    Expanded(
                      child: Text("Parth Vaghasiya\nSurat",
                        style: FontStyle.textTitleSmallWhite,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            leading: Image.asset('assets/image/homepage.png',width: 28,height: 28,),
            title: const Text('Home Page',style: FontStyle.drawerText),
          ),

          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => NewsList()));
            },
            leading: Image.asset('assets/image/news.png',width: 28,height: 28,),
            title: const Text('News',style: FontStyle.drawerText),
          ),

          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => RecentUploadList()));
            },
            leading: Image.asset('assets/image/recentupload.png',width: 28,height: 28,),
            title: const Text('Recent Upload',style: FontStyle.drawerText),
          ),

          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
            },
            leading: Image.asset('assets/image/profilepage.png',width: 28,height: 28,),
            title: const Text('Profile Page',style: FontStyle.drawerText),
          ),

          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => Terms()));
            },
            leading: Image.asset('assets/image/terms.png',width: 28,height: 28,),
            title: const Text("Terms & Condition",style: FontStyle.drawerText),
          ),

          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUs()));
            },
            leading: Image.asset('assets/image/aboutus.png',width: 28,height: 28,),
            title: const Text('About Us',style: FontStyle.drawerText),
          ),

          ListTile(
            onTap: () {
              Navigator.pop(context);
            },
            leading: Image.asset('assets/image/logout.png',width: 28,height: 28,),
            title: const Text('LOGOUT',style: FontStyle.drawerText),
          ),
        ],
      ),
    );

  }
}
