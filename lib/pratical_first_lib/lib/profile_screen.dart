import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pratical_tushar/controller.dart';
import 'package:pratical_tushar/home_page.dart';
import 'package:pratical_tushar/model_class.dart';
import 'package:pratical_tushar/services.dart';

// ignore: camel_case_types
class profilepage extends StatefulWidget {
  final Datum data;
  const profilepage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<profilepage> createState() => _profilepageState();
}

class _profilepageState extends State<profilepage> {
  Future<void> pullrefresh() async {
    services.fetchProducts();
  }

  TextEditingController firstnamecontroller = TextEditingController(text: "");
  TextEditingController lastnamecontroller = TextEditingController(text: "");
  TextEditingController emailcontroller = TextEditingController(text: "");

  late SharedPreferences prefs;
  String text = '';

  void updatedata() {
    setState(() {
      for (var i = 0; i < services.listofdata.length; i++) {
        if (services.listofdata[i].id == widget.data.id) {
          services.listofdata[i].email = emailcontroller.text;
          services.listofdata[i].firstName = firstnamecontroller.text;
          services.listofdata[i].lastName = lastnamecontroller.text;
        } else {
          print('nothing');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(dataController());

    firstnamecontroller.text = widget.data.firstName ?? "";
    lastnamecontroller.text = widget.data.lastName ?? "";
    emailcontroller.text = widget.data.email ?? "";

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.blue),
            onPressed: () {
              Get.to(const MyWidget());
            },
          ),
          title: const Text(
            'Back',
            style: TextStyle(color: Colors.blue),
          ),
        ),
        body: WillPopScope(
          onWillPop: () async {
            Get.to(const MyWidget());
            return true;
          },
          child: Obx(
            () {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return RefreshIndicator(
                  onRefresh: pullrefresh,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ClipOval(
                            child: Image.network(widget.data.avatar == null
                                ? ''
                                : widget.data.avatar!),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Email :'),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: emailcontroller,
                                  ),
                                ),
                              ]),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('FirstName:'),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: firstnamecontroller,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('FirstName:'),
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: lastnamecontroller,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: SizedBox(
                              width: 250,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.pink),
                                onPressed: () async {
                                  updatedata();
                                  // controller.updateList(controller.productList);
                                  setState(() {});
                                  Get.to(const MyWidget());
                                },
                                child: const Text("Update"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          ), // Your Scaffold goes here.
        ));
  }
}
