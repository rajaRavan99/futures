import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:roadapp/Library/TextStyle.dart';
import 'package:roadapp/Library/Utils.dart';
import '../Library/ApiData.dart';
import '../Library/AppColors.dart';
import '../Library/ManageStorage.dart';
import '../Library/MyNavigator.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Otp extends StatefulWidget {
  const Otp({Key? key, this.mobilenumber}) : super(key: key);
  final String? mobilenumber;

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  String umobile = "";
  String otpText = "";
  String verificationIdText = "";
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();
  bool isLoading = false;

  void initState() {
    super.initState();
    umobile = widget.mobilenumber!;
    verifyPhone();
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
      phoneNumber: widget.mobilenumber,
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
        MyNavigator.goToDashBoard(context);
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/image/login.png',
                        height: 250,
                        width: MediaQuery.of(context).size.width - 50,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Expanded(
                        child: Text(
                          "OTP Verification",
                          textAlign: TextAlign.center,
                          style: FontStyle.textLabel,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                            "Enter the OTP send to " +
                                widget.mobilenumber.toString(),
                            textAlign: TextAlign.center,
                            style: FontStyle.greyTextSmall),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  PinCodeTextField(
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    textStyle: FontStyle.textInput,
                    textInputAction: TextInputAction.next,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      //activeColor: Colors.white,
                      disabledColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      activeFillColor: Colors.white,
                      inactiveColor: AppColors.grey_10,
                      selectedColor: Colors.black54,
                      selectedFillColor: Colors.white,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    //backgroundColor: Colors.white,
                    autoDismissKeyboard: true,
                    cursorColor: Colors.black87,
                    keyboardType: TextInputType.number,
                    autoFocus: true,
                    enableActiveFill: true,
                    controller: otpController,
                    onCompleted: (v) {
                      debugPrint("Completed");
                    },
                    onChanged: (value) {
                      debugPrint(value);
                      setState(() {
                        otpText = value;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty || value.length != 6) {
                        return "Enter Valid OTP";
                      } else {
                        return null;
                      }
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      return true;
                    },
                    appContext: context,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Didn't receive the code? ",
                          style: FontStyle.primaryLabel.copyWith(fontSize: 14)),
                      InkWell(
                        onTap: () => snackBar("OTP resend!!"),
                        child: Text("RESEND",
                            style: FontStyle.primaryLabel.copyWith(
                                fontFamily: 'SemiBold', fontSize: 15)),
                      )
                    ],
                  ),
                  const SizedBox(height: 50),
                  verificationIdText == "" || isLoading
                      ? const SpinKitThreeBounce(
                          color: AppColors.primaryColor,
                          size: 30.0,
                        )
                      : InkWell(
                          onTap: () async {
                            final form = _formKey.currentState;
                            if (form!.validate()) {
                              form.save();
                              userLogin();
                            }
                          },
                          child: Utils().primaryButton(
                              'VERIFY', MediaQuery.of(context).size.width),
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
