import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasedatareleted/homepage.dart';
import 'package:firebasedatareleted/loginpage.dart';
import 'package:firebasedatareleted/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

class MyVerify extends StatefulWidget {
  const MyVerify({Key? key}) : super(key: key);

  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify> {
  bool isloading = false;
  String verificationID = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String otpPin = " ";
  String countryDial = "+1";
  String verID = " ";
  final countryController = TextEditingController(text: "");
  final otpController = TextEditingController(text: "");
  String phone = '';

  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          key: formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(
                'https://static.vecteezy.com/system/resources/previews/000/626/877/original/home-logo-building-vectors.jpg',
                width: 150,
                height: 150,
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                // defaultPinTheme: defaultPinTheme,
                // focusedPinTheme: focusedPinTheme,
                // submittedPinTheme: submittedPinTheme,

                showCursor: true,
                controller: otpController,
                onCompleted: (pin) => print(pin),
                onChanged: (value) {
                  otpPin = value;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      AuthCredential phoneAuthCredential =
                          PhoneAuthProvider.credential(
                              verificationId: verificationID,
                              smsCode: otpController.text);
                      signInWithPhoneAuthCred(phoneAuthCredential);
                      // verifyOtp;
                    },
                    child: const Text("Verify Phone Number")),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Get.to(loginwidget());
                    },
                    child: const Text(
                      "Edit Phone Number ?",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        sendotp(countryController.text);
                      },
                      child: Text("Resend Otp"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> verifyOTP() async {
  //   // showDialog(
  //   //   context: context,
  //   //   barrierDismissible: false,
  //   //   builder: (context) => const Center(
  //   //     child: CircularProgressIndicator(),
  //   //   ),
  //   // );
  //   await FirebaseAuth.instance
  //       .signInWithCredential(
  //     PhoneAuthProvider.credential(
  //       verificationId: verID,
  //       smsCode: otpPin,
  //     ),
  //   )
  //       .whenComplete(() {
  //     Navigator.of(context).pushReplacement(
  //       MaterialPageRoute(
  //         builder: (context) => DashBoard(),
  //       ),
  //     );
  //   });
  // }

  Future<void> verifyOtp(AuthCredential credential) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verID,
        smsCode: otpController.text,
      );
      // await FirebaseAuth.instance.signInWithCredential(
      //     PhoneAuthProvider.credential(
      //         verificationId: verID, smsCode: otpController.text,));
      await _auth
      .signInWithCredential(credential);
      Utils.showSnackBar('Otp Correct');
      Get.to(DashBoard());
    } catch (e) {
      print('error');
    }
  }

  Future<void> sendotp(String number) async {
    String phone = '';
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: countryController.text + phone,
      timeout: const Duration(seconds: 30),
      verificationCompleted: (PhoneAuthCredential credential) {
        Utils.showSnackBar("Auth Completed!");
      },
      verificationFailed: (FirebaseAuthException e) {
        Utils.showSnackBar("Auth Failed!");
      },
      codeSent: (String verificationId, int? resendToken) {
        Utils.showSnackBar("OTP Sent!");
        verID = verificationId;
        // setState(() {
        //   screenState = 1;
        // });
        Get.to(const MyVerify());
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        Utils.showSnackBar("Timeout!");
      },
    );
  }

  void signInWithPhoneAuthCred(AuthCredential phoneAuthCredential) async {
    try {
      final authCred = await _auth.signInWithCredential(phoneAuthCredential);

      if (authCred.user != null) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => DashBoard()));
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Some Error Occured. Try Again Later')));
    }
  }
}
