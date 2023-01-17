import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:future/Library/AppColors.dart';
import 'package:future/Library/TextStyle.dart';
import 'package:future/pages/HomePage.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Library/Utils.dart';
import 'SignIn.dart';

class SignUp extends StatefulWidget {
  const SignUp({
    super.key,
  });

  @override
  State<SignUp> createState() => _SignInState();
}

class _SignInState extends State<SignUp> {
  final namecontroller = TextEditingController(text: "");
  final emailcontroller = TextEditingController(text: "");
  final mobilecontroller = TextEditingController(text: "");
  final passwordcontroller = TextEditingController(text: "");
  bool ishidden = true;

  @override
  void dispose() {
    namecontroller.dispose();
    emailcontroller.dispose();
    mobilecontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
  }

  late SharedPreferences prefs;
  final form = GlobalKey<FormState>();

  _saveToShared_Preferences() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("Name", namecontroller.text.toString());
    prefs.setString("Email", emailcontroller.text.toString());
    prefs.setString("Number", mobilecontroller.text.toString());
    prefs.setString("Password", passwordcontroller.text.toString());
    String detail = prefs.getString("Email").toString();
    print(detail);
    // ignore: use_build_context_synchronously
    Get.to(const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: form,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Lottie.network(
                    'https://assets8.lottiefiles.com/packages/lf20_u8o7BL.json',
                    // 'https://assets2.lottiefiles.com/packages/lf20_lopdm1pc.json',
                    // 'https://assets2.lottiefiles.com/packages/lf20_CgL682.json',
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.6,
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
                        return 'Enter Email';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    obscureText: ishidden,
                    controller: passwordcontroller,
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
                            ishidden ? Icons.visibility_off : Icons.visibility,
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
                        signup();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                        );
                      }
                    },
                    child: Utils().primaryButton(
                        'Sign Up', MediaQuery.of(context).size.width * 0.7),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "Already have an Account ?",
                        style: FontStyle.primaryLabel,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(const SignIn());
                        },
                        child: const Text(
                          "Sign In",
                          style: FontStyle.primaryLabel,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  signup() async {
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
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passwordcontroller.text.trim(),
      );
    } on FirebaseException catch (e) {
      print(e);
    }
  }
}
