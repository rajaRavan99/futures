import 'dart:async';
import 'package:donor/Library/AppColors.dart';
import 'package:donor/Library/TextStyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../Library/ApiData.dart';
import '../Library/ManageStorage.dart';
import '../Library/MyNavigator.dart';
import '../Library/Utils.dart';

class OtpPage extends StatefulWidget {
  final String? phoneNumber;

  const OtpPage({Key? key, this.phoneNumber}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final TextEditingController textEditingController = TextEditingController();
  String umobile = "";

  String otpText = "";
  String verificationIdText = "";
  bool isLoading = false;

  TextEditingController otpController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    umobile = widget.phoneNumber!;
    verifyPhone();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  // snackBar Widget
  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  verifyPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        Utils().successSnack(context, "Your phone number is verified.");
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        // ignore: avoid_print
        print("Login Error : $e");
        Utils().errorSnack(context, e.message.toString());
      },
      codeSent: (String verificationId, int? resendToken) {
        print("vid : $verificationId");
        print("token : $resendToken");

        Utils().defaultSnack(context, "Check your phone for OTP.");
        setState(() {
          verificationIdText = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          verificationIdText = verificationId;
        });
        print("tvid : $verificationId");
      },
    );
  }

  userLogin() async {
    setState(() {
      isLoading = true;
    });
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationIdText,
        smsCode: otpText,
      );
      final User? user = (await auth.signInWithCredential(credential)).user;
      if (user != null) {
        if (!mounted) return;
        AppStorage.setData('umobile', user.phoneNumber.toString());
        MyNavigator().goToDashBoard(context);
      } else {
        if (!mounted) return;
        Utils().errorSnack(context, "Failed to login.");
      }
    } catch (e) {
      print(e);
      Utils().errorSnack(context, "Failed to login.");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: AppColors.primaryColor,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: AppColors.primaryColor,
                      width: context.width,
                      child: Image.asset(
                        'assets/image/logo2.png',
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height -
                          200 -
                          MediaQuery.of(context).padding.top,
                      color: AppColors.white_00,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            children: [
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Phone Number Verification',
                                style:
                                    FontStyle.textHeader.copyWith(fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: RichText(
                              text: TextSpan(
                                  text: "Enter the code sent to ",
                                  children: [
                                    TextSpan(
                                      text: umobile,
                                      style: FontStyle.textHint,
                                    )
                                  ],
                                  style: FontStyle.primaryLabel
                                      .copyWith(fontFamily: 'Regular')),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                          Form(
                            key: formKey,
                            child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 0.0,
                                  horizontal: 15,
                                ),
                                child: PinCodeTextField(
                                  controller: otpController,
                                  appContext: context,
                                  pastedTextStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  length: 6,
                                  obscureText: false,
                                  blinkWhenObscuring: true,
                                  animationType: AnimationType.fade,
                                  errorTextMargin:
                                      const EdgeInsets.only(top: 20),
                                  pinTheme: PinTheme(
                                      shape: PinCodeFieldShape.box,
                                      borderRadius: BorderRadius.circular(5),
                                      fieldHeight: 50,
                                      fieldWidth: 40,
                                      activeFillColor: AppColors.white_00,
                                      selectedFillColor: AppColors.black,
                                      inactiveFillColor: AppColors.black,
                                      activeColor:
                                          AppColors.black.withOpacity(0.3),
                                      inactiveColor: AppColors.black,
                                      selectedColor: AppColors.black),
                                  cursorColor: AppColors.black,
                                  animationDuration:
                                      const Duration(milliseconds: 300),
                                  keyboardType: TextInputType.number,
                                  onCompleted: (v) {
                                    debugPrint("Completed");
                                  },
                                  onChanged: (value) {
                                    debugPrint(value);
                                    setState(() {
                                      otpText = value;
                                    });
                                  },
                                  beforeTextPaste: (text) {
                                    debugPrint("Allowing to paste $text");

                                    return true;
                                  },
                                )),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          verificationIdText == "" || isLoading
                              ? const SpinKitThreeBounce(
                                  color: AppColors.primaryColor,
                                  size: 30.0,
                                )
                              : InkWell(
                                  onTap: () async {
                                    final form = formKey.currentState;
                                    if (form!.validate()) {
                                      form.save();
                                      userLogin();
                                    }
                                  },
                                  child: Utils().primaryButton('VERIFY',
                                      MediaQuery.of(context).size.width),
                                ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Didn't receive the code? ",
                                  style: FontStyle.primaryLabel),
                              TextButton(
                                onPressed: () => snackBar("OTP resend!!"),
                                child: Text("RESEND",
                                    style: FontStyle.primaryLabel
                                        .copyWith(fontFamily: 'SemiBold')),
                              )
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Text(
                              hasError
                                  ? "*Please fill up all the cells properly"
                                  : "",
                              style: const TextStyle(
                                  color: AppColors.white_00,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 0,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 25,
                color: AppColors.white_00,
              ),
            ),
          )
        ],
      ),
    );
  }
}
