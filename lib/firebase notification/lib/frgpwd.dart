import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasedatareleted/utils.dart';
import 'package:flutter/material.dart';

class forgetpwd extends StatefulWidget {
  forgetpwd({super.key});

  // var email = "";
  // var Password = "";

  @override
  State<forgetpwd> createState() => _loginpageState();
}

class _loginpageState extends State<forgetpwd> {
  final formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController(text: "");
  // final passwordcontroller = TextEditingController(text: "");

  @override
  void dispose() {
    emailcontroller.dispose();
    // passwordcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Firebase Auth"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 150,
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
                          color: Colors.white,
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
                        color: Colors.black38,
                      ),
                      labelText: "E-mail",
                      labelStyle: const TextStyle(
                        color: Colors.black38,
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (email) =>
                        email != null && !EmailValidator.validate(email)
                            ? 'Enter valid Email'
                            : null,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      verifyemail();
                    },
                    child: const Text("Reset Password"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future verifyemail() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailcontroller.text.trim(),
      );

      // Utils.showSnackBar('Password Reset email Sent');
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }
  }

  // Future signup() async {
  //   final isvalid = formkey.currentState!.validate();
  //   if (isvalid) return;
  //   try {
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: emailcontroller.text.trim(),
  //       password: passwordcontroller.text.trim(),
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     print(e);

  //     Utils.showSnackBar(e.message);
  //   }
  // }
}
