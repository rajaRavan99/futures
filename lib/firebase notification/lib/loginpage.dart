import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasedatareleted/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'frgpwd.dart';

class loginwidget extends StatefulWidget {
  loginwidget({super.key});

  // var email = "";
  // var Password = "";

  @override
  State<loginwidget> createState() => _loginpageState();
}

class _loginpageState extends State<loginwidget> {
  final formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController(text: "");
  final passwordcontroller = TextEditingController(text: "");

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.dispose();
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(25),
                child: ClipOval(
                  child: Image.network(
                    'https://static.vecteezy.com/system/resources/previews/000/626/877/original/home-logo-building-vectors.jpg',
                  ),
                ),
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

                  hintText: "Password",
                  hintStyle: const TextStyle(
                    color: Colors.black38,
                  ),
                  labelText: "Password",
                  labelStyle: const TextStyle(
                    color: Colors.black38,
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
                      // Get.to(signup());
                      signup();
                    },
                    child: const Text("Singup"),
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
}
