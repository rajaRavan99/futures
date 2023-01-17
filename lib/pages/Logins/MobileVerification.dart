

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../ApiPage.dart/ApiHomepage.dart';
import '../../Library/Utils.dart';
import 'Verification.dart';

// class MyPhone extends StatefulWidget {
//   const MyPhone({Key? key}) : super(key: key);

//   @override
//   State<MyPhone> createState() => _MyPhoneState();
// }

// class _MyPhoneState extends State<MyPhone> {
//   TextEditingController countryController = TextEditingController();

//   @override
//   void initState() {
//     // TODO: implement initState
//     countryController.text = "+91";
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         margin: const EdgeInsets.only(left: 25, right: 25),
//         alignment: Alignment.center,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 'assets/img1.png',
//                 width: 150,
//                 height: 150,
//               ),
//               const SizedBox(
//                 height: 25,
//               ),
//               const Text(
//                 "Phone Verification",
//                 style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               const Text(
//                 "We need to register your phone without getting started!",
//                 style: TextStyle(
//                   fontSize: 16,
//                 ),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(
//                 height: 30,
//               ),
//               Container(
//                 height: 55,
//                 decoration: BoxDecoration(
//                     border: Border.all(width: 1, color: Colors.grey),
//                     borderRadius: BorderRadius.circular(10)),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const SizedBox(
//                       width: 10,
//                     ),
//                     SizedBox(
//                       width: 40,
//                       child: TextField(
//                         controller: countryController,
//                         keyboardType: TextInputType.number,
//                         decoration: const InputDecoration(
//                           border: InputBorder.none,
//                         ),
//                       ),
//                     ),

//                     const Text(
//                       "|",
//                       style: TextStyle(fontSize: 33, color: Colors.grey),
//                     ),

//                     const SizedBox(
//                       width: 10,
//                     ),

//                     const Expanded(
//                         child: TextField(
//                       keyboardType: TextInputType.phone,
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                         hintText: "Phone",
//                       ),
//                     ))
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               SizedBox(
//                 width: double.infinity,
//                 height: 45,
//                 child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                         primary: Colors.green.shade600,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10))),
//                     onPressed: () {
//                       Navigator.pushNamed(context, 'verify');
//                     },
//                     child: const Text("Send the code")),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

enum LoginScreen { SHOW_MOBILE_ENTER_WIDGET, SHOW_OTP_FORM_WIDGET }

class MobileLogin extends StatefulWidget {
  const MobileLogin({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<MobileLogin> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  LoginScreen currentState = LoginScreen.SHOW_MOBILE_ENTER_WIDGET;
  FirebaseAuth _auth = FirebaseAuth.instance;
  String verificationID = "";

  void SignOutME() async {
    await _auth.signOut();
  }

  void signInWithPhoneAuthCred(AuthCredential phoneAuthCredential) async {
    try {
      final authCred = await _auth.signInWithCredential(phoneAuthCredential);
      timeout:
      Duration(seconds: 60);
      if (authCred.user != null) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => DashBoard()));
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Some Error Occured. Try Again Later'),
        ),
      );
    }
  }

  showMobilePhoneWidget(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        const Text(
          "Verify Your Phone Number",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 7,
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: TextField(
            controller: phoneController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                hintText: "Enter Your PhoneNumber"),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () async {
              await _auth.verifyPhoneNumber(
                  phoneNumber: "+91${phoneController.text}",
                  verificationCompleted: (phoneAuthCredential) async {
                    Text('data');
                  },
                  verificationFailed: (verificationFailed) {
                    print(verificationFailed);
                    Text('data');
                  },
                  codeSent: (verificationID, resendingToken) async {
                    Text('sent');
                    setState(() {
                      currentState = LoginScreen.SHOW_OTP_FORM_WIDGET;
                      this.verificationID = verificationID;
                      Get.to(const MyVerify());
                    });
                  },
                  codeAutoRetrievalTimeout: (verificationID) async {
                    Text('data');
                  });
            },
            child: const Text("Send OTP")),
        const SizedBox(
          height: 16,
        ),
        const Spacer()
      ],
    );
  }

  showOtpFormWidget(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        const Text(
          "ENTER YOUR OTP",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 7,
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: TextField(
            controller: otpController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                hintText: "Enter Your OTP"),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () {
              AuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
                  verificationId: verificationID, smsCode: otpController.text);
              signInWithPhoneAuthCred(phoneAuthCredential);
            },
            child: const Text("Verify")),
        const SizedBox(
          height: 16,
        ),
        const Spacer()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentState == LoginScreen.SHOW_MOBILE_ENTER_WIDGET
          ? showMobilePhoneWidget(context)
          : showOtpFormWidget(context),
    );
  }
}
