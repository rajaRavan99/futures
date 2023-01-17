import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:future/Library/AppColors.dart';
import 'package:future/Library/TextStyle.dart';
import 'package:future/pages/Logins/MobileVerification.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Library/Utils.dart';
import '../HomePage.dart';
import 'SignUp.dart';

class SignIn extends StatefulWidget {
  const SignIn({
    super.key,
  });

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailcontroller = TextEditingController(text: "");
  TextEditingController pwdcontroller = TextEditingController(text: "");
  String name = "";
  String email = "";
  String temp = "";
  String password = "";
  late SharedPreferences prefs;

  @override
  void initState() {
    // _showSavedValue();
    super.initState();
  }

  @override
  void dispose() {
    emailcontroller.dispose();
    pwdcontroller.dispose();
    super.dispose();
  }

  final form = GlobalKey<FormState>();

  bool ishidden = true;

  _showSavedValue() async {
    prefs = await SharedPreferences.getInstance();
    email = prefs.getString("Email").toString();
    password = prefs.getString("password").toString();

    emailcontroller.text = email;
    pwdcontroller.text = password;
  }

  getText2() {
    return emailcontroller.text;
  }

  getText3() {
    return pwdcontroller.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Object>(
        stream: null,
        builder: (context, snapshot) {
          return Form(
            key: form,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Lottie.network(
                      'https://assets4.lottiefiles.com/packages/lf20_xlmz9xwm.json',
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.5,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: emailcontroller,
                      style: FontStyle.textInput,
                      textInputAction: TextInputAction.next,
                      decoration: Utils().inputDecoration("E-mail"),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter E-mail Please';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      obscureText: ishidden,
                      controller: pwdcontroller,
                      style: FontStyle.textInput,
                      textInputAction: TextInputAction.next,
                      decoration: Utils().inputDecoration("Password").copyWith(
                              suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                ishidden = !ishidden;
                              });
                            },
                            child: Icon(
                              ishidden
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.primaryColor,
                            ),
                          )),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Password';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        if (form.currentState!.validate()) {
                          signIn();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                          );
                        }
                      },
                      child: Utils().primaryButton(
                          'Login', MediaQuery.of(context).size.width * 0.7),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          "Don't have an Account ?",
                          style: FontStyle.primaryLabel,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(
                              const SignUp(),
                            );
                          },
                          child: const Text(
                            "Sign Up",
                            style: FontStyle.primaryLabel,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          "Sign In With Number",
                          style: FontStyle.primaryLabel,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Get.to(
                              const MobileLogin(),
                            );
                          },
                          child: const Text(
                            "Click Here",
                            style: FontStyle.primaryLabel,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future signIn() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: SpinKitThreeBounce(
          color: AppColors.primaryColor,
          size: 25,
        ),
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: pwdcontroller.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }
}
