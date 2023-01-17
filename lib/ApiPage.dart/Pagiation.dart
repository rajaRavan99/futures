import 'package:flutter/material.dart';
import 'package:future/ApiPage.dart/api.dart';
import 'package:future/Library/AppColors.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller.dart';

class Pagiation extends StatefulWidget {
  const Pagiation({super.key});

  @override
  State<Pagiation> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Pagiation> {
  String email = "";

  late SharedPreferences prefs;

  TextEditingController firstnamecontroller = TextEditingController(text: "");
  TextEditingController lastnamecontroller = TextEditingController(text: "");
  TextEditingController emailcontroller = TextEditingController(text: "");

  final scrolc = ScrollController();

  Future<void> pullrefresh() async {
    services.fetchProducts();
  }

  @override
  void initState() {
    super.initState();

    scrolc.addListener(() {
      if (scrolc.position.maxScrollExtent == scrolc.offset) {
        fetch();
      }
    });
  }

  @override
  void dispose() {
    scrolc.dispose();
    super.dispose();
  }

  Future fetch() async {
    setState(() {
      item.addAll(['Item 3', 'Item1', 'Item1']);
    });
  }

  List<String> item = List.generate(
    15,
    (index) => 'Item ${index + 1}',
  );

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => dataController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primaryColor),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'DashBoard',
          style: TextStyle(color: AppColors.primaryColor),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.builder(
              controller: scrolc,
              shrinkWrap: true,
              itemCount: item.length + 1,
              physics: const NeverScrollableScrollPhysics(),

              // itemCount: controller.productList.length + 1,
              itemBuilder: (BuildContext context, int i) {
                if (i < item.length) {
                  final Item = item[i];

                  return ListTile(
                    title: Text(Item),
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
