import 'package:donor/Library/TextStyle.dart';
import 'package:donor/Library/Utils.dart';
import 'package:donor/Login/OtpPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../Library/AppColors.dart';

class ForgetPwd extends StatefulWidget {
  const ForgetPwd({Key? key}) : super(key: key);

  @override
  State<ForgetPwd> createState() => _ForgetPwdState();
}

class _ForgetPwdState extends State<ForgetPwd> {
  final TextEditingController pwdcontroller = TextEditingController(text: "");
  final TextEditingController cnfpwd = TextEditingController(text: "");
  String name = "";
  bool changebutton = false;

  final _formKey = GlobalKey<FormState>();

  get prefixIcon => null;
  bool isHidden = true;
  RegExp passValid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
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
      if (passValid.hasMatch(_password)) {
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

  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changebutton = true;
      });
      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        changebutton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    color: AppColors.primaryColor,
                    width: context.width,
                    child: Image.asset(
                      'assets/image/logo2.png',
                      height: 250,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: Text(
                      "Forget Password",
                      style: FontStyle.textHeader,
                    ),
                  ),
                  Container(
                    height: 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white24,
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: TextFormField(
                              obscureText: isHidden,
                              style: const TextStyle(fontSize: 15),
                              controller: pwdcontroller,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(RegExp(r"\s")),
                              ],
                              decoration: Utils()
                                  .inputDecoration("Enter New Password")
                                  .copyWith(
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          isHidden = !isHidden;
                                        });
                                      },
                                      child: Icon(
                                        size: 20,
                                        isHidden
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                    ),
                                  ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: TextFormField(
                              obscureText: isHidden,
                              style: const TextStyle(fontSize: 15),
                              controller: cnfpwd,
                              inputFormatters: [
                                FilteringTextInputFormatter.deny(RegExp(r"\s")),
                              ],
                              decoration: Utils()
                                  .inputDecoration("Enter New Confirm Password")
                                  .copyWith(
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          isHidden = !isHidden;
                                        });
                                      },
                                      child: Icon(
                                        size: 20,
                                        isHidden
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                    ),
                                  ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AnimatedContainer(
                            alignment: Alignment.bottomRight,
                            duration: const Duration(seconds: 1),
                            child: Container(
                              height: 35,
                              width: 110,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) => const OtpPage(
                                                phoneNumber: "+919876543210")));
                                  } else {
                                    return;
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                                child: const Text(
                                  'Submit',
                                  style: FontStyle.textHeaderWhite,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
