import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasedatareleted/homepage.dart';
import 'package:firebasedatareleted/loginpage.dart';
import 'package:firebasedatareleted/otpscreen.dart';
import 'package:firebasedatareleted/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _phoneController = TextEditingController();

//   final _codeController = TextEditingController();

//   Future<void> Loginuser(String phone, BuildContext context) async {
//     FirebaseAuth _auth = FirebaseAuth.instance;

//     _auth.verifyPhoneNumber(
//       phoneNumber: phone,
//       timeout: Duration(seconds: 60),
//       verificationCompleted: (AuthCredential credential) async {
//         Utils.showSnackBar("Auth Completed!");
//         Navigator.of(context).pop();

//         UserCredential result = await _auth.signInWithCredential(credential);

//         User? user = result.user;

//         if (user != null) {
//           Get.to(DashBoard());
//         } else {
//           print("Error");
//         }

//         //This callback would gets called when verification is done auto maticlly
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         print(e);
//         Utils.showSnackBar("Auth Failed!");
//       },
//       codeSent: (String verificationId, int? resendToken) {
//         showDialog(
//             context: context,
//             barrierDismissible: false,
//             builder: (context) {
//               return AlertDialog(
//                 title: Text("Give the code?"),
//                 content: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     TextField(
//                       controller: _codeController,
//                     ),
//                   ],
//                 ),
//                 actions: <Widget>[
//                   ElevatedButton(
//                     child: Text("Confirm"),
//                     onPressed: () async {
//                       final code = _codeController.text.trim();
//                       AuthCredential credential = PhoneAuthProvider.credential(
//                           verificationId: verificationId, smsCode: code);

//                       UserCredential result =
//                           await _auth.signInWithCredential(credential);

//                       User? user = result.user;

//                       if (user != null) {
//                         Get.to(DashBoard());
//                       } else {
//                         print("Error");
//                       }
//                     },
//                   )
//                 ],
//               );
//             });
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {},
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SingleChildScrollView(
//       child: Container(
//         padding: EdgeInsets.all(32),
//         child: Form(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 "Login",
//                 style: TextStyle(
//                     color: Colors.lightBlue,
//                     fontSize: 36,
//                     fontWeight: FontWeight.w500),
//               ),
//               SizedBox(
//                 height: 16,
//               ),
//               TextFormField(
//                 decoration: InputDecoration(
//                     enabledBorder: const OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(8)),
//                         borderSide: BorderSide()),
//                     focusedBorder: const OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(8)),
//                         borderSide: BorderSide()),
//                     filled: true,
//                     fillColor: Colors.grey[100],
//                     hintText: "Mobile Number"),
//                 controller: _phoneController,
//                 keyboardType: TextInputType.number,
//               ),
//               const SizedBox(
//                 height: 16,
//               ),
//               Container(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   child: Text("LOGIN"),
//                   onPressed: () {
//                     final phone = _phoneController.text.trim();

//                     Loginuser(phone, context);
//                   },
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
// }

enum LoginScreen { SHOW_MOBILE_ENTER_WIDGET, SHOW_OTP_FORM_WIDGET }

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
          const SnackBar(content: Text('Some Error Occured. Try Again Later')));
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
                    Utils.showSnackBar('Completed');
                  },
                  verificationFailed: (verificationFailed) {
                    print(verificationFailed);
                    Utils.showSnackBar('falied');
                  },
                  codeSent: (verificationID, resendingToken) async {
                    Utils.showSnackBar('Sent');
                    setState(() {
                      currentState = LoginScreen.SHOW_OTP_FORM_WIDGET;
                      this.verificationID = verificationID;
                      Get.to(const MyVerify());
                    });
                  },
                  codeAutoRetrievalTimeout: (verificationID) async {
                    Utils.showSnackBar('Timesup');
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


// Future<void> sentOtp(String number) async {
//     await FirebaseAuth.instance.verifyPhoneNumber(
//       phoneNumber: '${countryController.text + phone}',
//       timeout: const Duration(seconds: 20),
//       verificationCompleted: (PhoneAuthCredential credential) async {
//         Utils.showSnackBar("Auth Completed!");
//         UserCredential result = await _auth.signInWithCredential(credential);

//         UserCredential user = result.user as UserCredential;

//         if (user != null) {
//           Get.to(verifyOtp(otpPin));
//         } else {
//           print("Error");
//         }
//       },
//       verificationFailed: (FirebaseAuthException e) {
//         Utils.showSnackBar("Auth Failed!");
//       },
//       codeSent: (String verificationId, int? resendToken) {
//         Utils.showSnackBar("OTP Sent!");
//         verID = verificationId;
//         setState(() {
//           screenState = 1;
//         });
//         Get.to(const MyVerify());
//       },
//       codeAutoRetrievalTimeout: (String verificationId) {
//         Utils.showSnackBar("Timeout!");
//       },
//     );
//   }


//   Future<void> verifyPhone(String number) async {
//     FirebaseAuth _auth = FirebaseAuth.instance;
//     final code = countryController.text.trim();
//     AuthCredential credential =
//         PhoneAuthProvider.credential(verificationId: verID, smsCode: code);

//     UserCredential result = await _auth.signInWithCredential(credential);

//     UserCredential user = result.user as UserCredential;

//     if (user != null) {
//       Get.to(DashBoard());
//     } else {
//       print("Error");
//     }
//   }