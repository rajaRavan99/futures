import 'package:flutter/material.dart';
import 'package:roadapp/Library/TextStyle.dart';
import 'package:roadapp/Library/Utils.dart';
import 'otp.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();

  Future<void> _verifyPhoneNumber() async {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              Otp(mobilenumber: "+91${mobileController.text}"),
        ),
      );
    }
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
                          "Enter your Phone Number",
                          textAlign: TextAlign.center,
                          style: FontStyle.textLabel,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Expanded(
                        child: Text(
                          "We will send you the 6 digit verification code",
                          textAlign: TextAlign.center,
                          style: FontStyle.greyTextSmall,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: mobileController,
                    maxLength: 10,
                    style: FontStyle.textInput,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration:
                        Utils().mobile_decoration('Mobile Number').copyWith(
                              prefixIcon: SizedBox(
                                width: 60,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: const [
                                    Text("+91", style: FontStyle.textInput),
                                    SizedBox(
                                      height: 15,
                                      child: VerticalDivider(
                                        color: Colors.grey,
                                        thickness: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    validator: (value) {
                      if (value!.isEmpty || value.length != 10) {
                        return " Mobile Number invalid";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 50),
                  InkWell(
                    onTap: () {
                      _verifyPhoneNumber();
                    },
                    child: Utils().primaryButton("Generate OTP",
                        MediaQuery.of(context).size.width * 0.7),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
