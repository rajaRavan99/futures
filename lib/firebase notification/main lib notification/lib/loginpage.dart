import 'package:email_auth/email_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasedatareleted/homepage.dart';
import 'package:firebasedatareleted/otpscreen.dart';
import 'package:firebasedatareleted/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import 'frgpwd.dart';

class loginwidget extends StatefulWidget {
  loginwidget({super.key});

  // var email = "";
  // var Password = "";
  static String verify = '';

  @override
  State<loginwidget> createState() => _loginpageState();
}

class _loginpageState extends State<loginwidget> {
  String otpPin = " ";

  final FirebaseAuth auth = FirebaseAuth.instance;
  String countryDial = "+1";
  String verID = " ";
  var phone = "";

  int screenState = 0;
  final formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController(text: "");
  final passwordcontroller = TextEditingController(text: "");

  final countryController = TextEditingController(text: "");

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    countryController.dispose();
    super.dispose();
  }

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

  // final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  //   border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
  //   borderRadius: BorderRadius.circular(8),
  // );

  // final submittedPinTheme = defaultPinTheme.copyWith(
  //   decoration: defaultPinTheme.decoration?.copyWith(
  //     color: const Color.fromRGBO(234, 239, 243, 1),
  //   ),
  // );

  @override
  void initState() {
    // TODO: implement initState
    countryController.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Firebase Auth"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Register Here",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  style: const TextStyle(
                      // color: Colors.black,
                      ),
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    // filled: true,
                    // fillColor: Colors.black,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 2,
                        color: Colors.black12,
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

                    hintText: "Enter E-mail",
                    hintStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    labelText: "E-mail",
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'Enter valid Email'
                          : null,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 40,
                        child: TextField(
                          controller: countryController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const Text(
                        "|",
                        style: TextStyle(fontSize: 33, color: Colors.grey),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          onChanged: (value) {
                            phone = value;
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Phone",
                            hintStyle: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Pinput(
                      length: 6,
                      // defaultPinTheme: defaultPinTheme,
                      // focusedPinTheme: focusedPinTheme,
                      // submittedPinTheme: submittedPinTheme,

                      showCursor: true,
                      onCompleted: (pin) => print(pin),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  style: const TextStyle(
                      // color: Colors.black,
                      ),
                  controller: passwordcontroller,
                  decoration: InputDecoration(
                    // filled: true,
                    // fillColor: Colors.black,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        width: 2,
                        color: Colors.black12,
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

                    hintText: "Password",
                    hintStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    labelText: "Password",
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (Value) => Value != null && Value.length < 6
                      ? 'Password Length 6 is Required'
                      : null,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        signin();
                      },
                      child: const Text("Login"),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        signup();
                      },
                      child: const Text("Singup"),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        sendotp(countryController.text);
                      },
                      child: const Text("Send Otp"),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  child: const Text("Forget Password"),
                  onTap: () {
                    Get.to(forgetpwd());
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future signin() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passwordcontroller.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }
    // navigatorkey.currentState!.popUntil((route() =>  route.isfirst ))
  }

  Future signup() async {
    // final isvalid = formkey.currentState!.validate();
    // if (isvalid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passwordcontroller.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }
  }

  Future<void> sendotp(String number) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: countryController.text + phone,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          UserCredential result = await auth.signInWithCredential(credential);

          UserCredential user = result.user as UserCredential;

          if (user != null) {
            // ignore: use_build_context_synchronously

          } else {
            print("Error");
          }
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
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
          Get.to(const MyVerify());
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          Utils.showSnackBar("Timeout!");
        },
      );
    } catch (e) {
      print(e);
    }
  }

  // Future<void> verifyOTP() async {
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

  Future<void> verifyOtp(String otp, {required UserCredential user}) async {
    await FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.credential(
      verificationId: verID,
      smsCode: otp,
    ));
  }
}
