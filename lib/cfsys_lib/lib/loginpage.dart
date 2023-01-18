// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:cfsys/colors.dart';
import 'package:cfsys/service.dart';
import 'package:cfsys/signuppage.dart';
import 'package:cfsys/stylepage/textstyles.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dashboard.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  String email = "";
  String passwords = "";
  TextEditingController username = TextEditingController(text: '');
  TextEditingController password = TextEditingController(text: '');

  String baseUrl = 'https://erp.cfsys.xyz/api/V1/get_access_code';

  final _formkey = GlobalKey<FormState>();

  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  // ignore: non_constant_identifier_names
  double password_strength = 0;

  bool validatePassword(String pass) {
    String _password = pass.trim();

    if (_password.isEmpty) {
      setState(() {
        password_strength = 0;
      });
    } else if (_password.length < 6) {
      setState(() {
        password_strength = 1 / 4;
      });
    } else if (_password.length < 8) {
      setState(() {
        password_strength = 2 / 4;
      });
    } else {
      if (pass_valid.hasMatch(_password)) {
        setState(() {
          password_strength = 4 / 4;
        });
        return true;
      } else {
        setState(() {
          password_strength = 3 / 4;
        });
        return false;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: context.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://th.bing.com/th/id/R.2bf0158b789c0d7f2bd66a3ec3f76488?rik=4gxDZrVISRZeAg&riu=http%3a%2f%2f3.bp.blogspot.com%2f-1SYrbxJsLiI%2fUh9yksZGFvI%2fAAAAAAAAHCQ%2fi41Qndj_YIs%2fs1600%2fPhoto-Background-Application.jpg&ehk=zmxcqeaoAc21%2bczrHEqfYuNZB%2fS9g6e9XU%2bu8IFu39U%3d&risl=&pid=ImgRaw&r=0"),
                    fit: BoxFit.cover),
              ),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.all(5),
                        child: Text(
                          "WelCome",
                          style: CustomTextStyle.welcome,
                        )
                        // Image.network(
                        //   'https://th.bing.com/th/id/OIP.W-jIfDUNBfdErx523vZDNAHaDj?pid=ImgDet&rs=1',
                        //   height: 300,
                        //   width: 300,
                        //   fit: BoxFit.fitWidth,
                        // ),
                        ),
                    Container(
                      // height: 50,
                      margin:
                          const EdgeInsets.only(top: 00, left: 20, right: 20),
                      child: TextFormField(
                        controller: username,
                        style: const TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 3,
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          labelText: "Username",
                          labelStyle: const TextStyle(
                            color: Colors.black38,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty || value.length < 6) {
                            return "Please enter Username";
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      // height: 50,
                      margin:
                          const EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: TextFormField(
                        controller: password,
                        style: const TextStyle(fontSize: 15),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 2,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              width: 3,
                              color: Colors.black12,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          labelText: "Password",
                          labelStyle: const TextStyle(
                            color: Colors.black38,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter password";
                          } else {
                            //call function to check password
                            bool result = validatePassword(value);
                            if (result) {
                              // create account event
                              return null;
                            } else {
                              return " Password should contain Capital, small letter & Number & Special";
                            }
                          }
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(20),
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: AppColors.lightblack,
                            textStyle: CustomTextStyle.style44),
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            Get.to(dashboard());
                            // Service().postdata(username.text, password.text);
                            // print(username.text);
                            // print(password.text);
                          }
                        },
                        child: Text(
                          "Log in",
                          style: CustomTextStyle.style3,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              // Note: Styles for TextSpans must be explicitly defined.
                              // Child text spans will inherit styles from parent
                              style: const TextStyle(
                                fontSize: 13.0,
                                color: Colors.black38,
                              ),
                              children: <TextSpan>[
                                const TextSpan(
                                    text: "New User Register Here?",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.grey_50)),
                                TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Get.to(Signuppage()),
                                    text: ' Sign Up',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.pink)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Future<void> Login() async {
    if (username.text.isNotEmpty && password.text.isNotEmpty) {
      var response = await http.post(
          Uri.parse('https://erp.cfsys.xyz/api/V1/get_access_code'),
          body: ({
            "userid": username.text,
            "password": password.text,
          }));
      print(response);
      print('Email + ${username.text}');
      print('Email + ${password.text}');

      if (response.statusCode == 200) {
        Get.snackbar("Success", "",
            backgroundColor: Colors.black45, colorText: Colors.white);
        Get.to(dashboard());
      } else {
        Get.snackbar("Invalid", "",
            backgroundColor: Colors.black45, colorText: Colors.white);
      }
    } else {
      Get.snackbar("Blacnk field Not Updated!", "",
          backgroundColor: Colors.black45, colorText: Colors.white);
    }
  }

  Future<dynamic> put() async {
    var client = http.Client();

    var url = Uri.parse(baseUrl);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    var bodydata = json.encode({
      "userid": username.text,
      "password": password.text,
      "device_id": "a91dec2903cd013d",
      "device_detail": "{\"version.securityPatch\":\"2022-07-01\"}"
    });

    var response = await client.put(url, body: bodydata, headers: headers);

    print('Email + ${username.text}');
    print('password + ${password.text}');

    if (response.statusCode == 200) {
      var newdata = json.decode(response.body);
      Get.snackbar("Success", "",
          backgroundColor: Colors.black45, colorText: Colors.white);
      Get.to(dashboard());
      print(newdata);
    } else {
      Get.snackbar("Invalid", "",
          backgroundColor: Colors.black45, colorText: Colors.white);
    }
  }
}
