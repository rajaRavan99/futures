import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:roadapp/Dashboard/NewsDetails.dart';
import 'package:roadapp/Library/AppDrawer.dart';
import 'package:roadapp/Library/TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:roadapp/Library/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Library/AppColors.dart';

class AboutUs extends StatefulWidget {
  AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        titleSpacing: 5,
        title: const Padding(
          padding: EdgeInsets.only(bottom: 5, left: 10.0),
          child: Text("About Us", style: FontStyle.textHeader),
        ),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
