import 'package:aug_new_demo/ui_pages/First_homepage.dart';
import 'package:aug_new_demo/ui_pages/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';
// import 'package:test_demo/models/catalog.dart';

class LoginPagedemo extends StatefulWidget {
  const LoginPagedemo({Key? key}) : super(key: key);

  @override
  State<LoginPagedemo> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPagedemo> {
  @override
  void initState() {
    // _showSavedValue();
    super.initState();
  }

  TextEditingController emailcontroller = TextEditingController(text: "");
  TextEditingController pwdcontroller = TextEditingController(text: "");

  // ignore: non_constant_identifier_names

  String name = "";
  String email = "";
  String temp = "";
  String password = "";
  bool changebutton = false;
  bool ishiddenpassword = true;
  late SharedPreferences prefs;
  final _formkey = GlobalKey<FormState>();
  // late SharedPreferences prefs;
  get prefixIcon => null;

  // ignore: non_constant_identifier_names
  // _saveToShared_Preferences() async {
  //   prefs = await SharedPreferences.getInstance();
  //   prefs.setString("KEY_1", T_controller.text.toString());
  // }

  // ignore: unused_element
  _showSavedValue() async {
    prefs = await SharedPreferences.getInstance();
    email = prefs.getString("Email").toString();
    password = prefs.getString("password").toString();

    emailcontroller.text = email;
    pwdcontroller.text = password;
    // ignore: use_build_context_synchronously
  }

  // ignore: non_constant_identifier_names
  // _delete_Shared_Preferences() async {
  //   prefs = await SharedPreferences.getInstance();
  //   prefs.remove("KEY_1");
  //   setState(() {
  //     name = " ";
  //   });
  // }
  getText2() {
    return emailcontroller.text;
  }

  getText3() {
    return pwdcontroller.text;
  }

  movetoHome(BuildContext context) async {
    // ignore: unused_local_variable
    final double screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    final double screenWidth = MediaQuery.of(context).size.width;
    if (_formkey.currentState!.validate()) {
      setState(() {
        changebutton = true;
      });
      Future.delayed(const Duration(seconds: 1));
      // ignore: use_build_context_synchronously
      await Get.to(first_Homepage());
      setState(() {
        changebutton = false;
      });
    }
  }

  @override
  bool isValidEmail(String value) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value);
  }

  //firebase data fetching
  // @override
  // void initstate() {
  //   fetchRecords();
  //   super.initState();
  // }

  // fetchRecords() async {
  //   var records =
  //       await FirebaseFirestore.instance.collection('Product_Items').get();
  //   mapRecords(records);
  // }

  // mapRecords(QuerySnapshot<Map<String, dynamic>> records) {}

  //firebase data fetching

  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
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
      if (pass_valid.hasMatch(_password)) {
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

  // Widget buildButton() => ButtonWidget(
  //     text: 'save',
  //     onclicked: () async {
  //       await Usersimplepreferences.setusername(name);
  //     });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: false,
          child: Center(
            child: Container(
              // height: context.height,
              // width: context.width,
              height: 900,
              //MediaQuery.of(context).size.height
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      "https://img.freepik.com/free-vector/abstract-blue-geometric-shapes-background_1035-17545.jpg?size=626&ext=jpg"),
                  fit: BoxFit.cover,
                  // alignment: Alignment.topLeft,
                ),
              ),
              child: Center(
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Lottie.network(
                        "https://assets5.lottiefiles.com/private_files/lf30_kj1v7uim.json",
                        height: 200,
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const Text(
                        "Sign In ",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 14.0),
                        child: Container(
                          height: 350,
                          padding: const EdgeInsets.only(
                              top: 20, right: 10, left: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.white24,
                          ),
                          child: Column(
                            children: [
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
                                      color: Colors.black54,
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  prefixIcon: prefixIcon ??
                                      const Icon(
                                        Icons.person,
                                        color: Colors.black54,
                                      ),
                                  hintText: "Enter E-mail",
                                  hintStyle: const TextStyle(
                                    color: Colors.black54,
                                  ),
                                  labelText: "E-mail",
                                  labelStyle: const TextStyle(
                                    color: Colors.black54,
                                  ),
                                ),
                                validator: (value) {
                                  bool valid = isValidEmail(value ?? "");

                                  if (value!.isEmpty) {
                                    return "Email can not be empty";
                                  } else if (!valid) {
                                    return "Please Enter Valid Email";
                                  }
                                },
                                onChanged: (value) {
                                  setState(() {
                                    email = value;
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              TextFormField(
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                                cursorColor: Colors.black54,
                                controller: pwdcontroller,
                                obscureText: ishiddenpassword,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: Colors.white),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 3, color: Colors.black54),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  prefixIcon: prefixIcon ??
                                      const Icon(
                                        Icons.lock,
                                        color: Colors.black54,
                                      ),
                                  hintText: "Enter Password ",
                                  hintStyle: const TextStyle(
                                    color: Colors.black54,
                                  ),
                                  labelText: "Password",
                                  labelStyle: const TextStyle(
                                    color: Colors.black54,
                                  ),
                                  suffixIcon: IconButton(
                                    color: Colors.black54,
                                    onPressed: () {
                                      setState(() {
                                        ishiddenpassword = !ishiddenpassword;
                                      });
                                    },
                                    icon: Icon(ishiddenpassword
                                        ? Icons.visibility_off
                                        : Icons.visibility),
                                  ),

                                  // myIcon is a 48px-wide widget.
                                ),
                                // validator: (value) {
                                //   if (value!.isEmpty) {
                                //     return "Password can not be empty";
                                //   } else if (value.length < 8) {
                                //     return "Password length sould be atleast 8";
                                //   }

                                //   return null;
                                // },

                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please enter password";
                                  } else {
                                    //call function to check password
                                    bool result = validatePassword(value);
                                    if (result) {
                                      // create account event
                                      return null;
                                    } else {
                                      return " Password should contain Capital, small letter & Number & Special";
                                    }
                                  }
                                },
                                onChanged: (value) {
                                  setState(() {
                                    password = value;
                                  });
                                },
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              InkWell(
                                onTap: () {
                                  // Get.to(const forgetpwd());
                                  Get.snackbar(
                                    "Are you Sure to modify your password",
                                    "Change Password",
                                    snackPosition: SnackPosition.TOP,
                                    colorText: Colors.black,
                                    dismissDirection:
                                        DismissDirection.horizontal,
                                    // forwardAnimationCurve: Curves.easeIn,
                                    backgroundGradient: const LinearGradient(
                                      colors: [
                                        Colors.orange,
                                        Colors.white,
                                        Colors.green
                                      ],
                                    ),
                                  );
                                },
                                child: const Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Forget Password ? ",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              InkWell(
                                onTap: () {
                                  if (_formkey.currentState!.validate()) {
                                    Get.off(first_Homepage(),
                                        fullscreenDialog: true);
                                    Get.snackbar(
                                      "",
                                      "",
                                      titleText: const Text(
                                        'Welcome',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.black45,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      borderRadius: 50,
                                      padding: const EdgeInsets.all(20),
                                      margin: const EdgeInsets.all(20),
                                      backgroundGradient: const LinearGradient(
                                        colors: [
                                          Colors.orange,
                                          Colors.white,
                                          Colors.green
                                        ],
                                      ),
                                    );
                                  }

                                  //   // else if (_showSavedValue()) {
                                  //   //   return;
                                  //   // }
                                },
                                // onDoubleTap: () => _showSavedValue(),
                                child: AnimatedContainer(
                                  duration: const Duration(seconds: 1),
                                  child: Container(
                                    width: changebutton ? 100 : 150,
                                    height: 40,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.black38,
                                        borderRadius: BorderRadius.circular(
                                            changebutton ? 50 : 8)),
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const InkWell(
                                    // onTap: () {
                                    //   Navigator.pushNamed(
                                    //       context, MyRoutes.forgetpwd);
                                    // },
                                    child: Text(
                                      "   Don't have an account ?",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 3.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.to(const signup());
                                    },
                                    child: const Text(
                                      "Sign up",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              // Expanded(
                              //   child: Column(
                              //     children: [],
                              //   ),
                              // ),
                              // Padding(
                              //     padding: EdgeInsets.only(
                              //         bottom: MediaQuery.of(context)
                              //             .viewInsets
                              //             .bottom)),
                            ],
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SignInButton.mini(
                              buttonSize: ButtonSize.medium,
                              // btnColor: Colors.lightBlue,
                              buttonType: ButtonType.facebook,
                              onPressed: () {},
                            ),
                            InkWell(
                              child: SignInButton.mini(
                                buttonSize: ButtonSize.medium,
                                buttonType: ButtonType.googleDark,
                                //btnDisabledColor: Colors.grey,
                                onPressed: () {
                                  GoogleSignIn().signIn();
                                },
                              ),
                            ),
                            SignInButton.mini(
                              buttonSize: ButtonSize.medium,
                              buttonType: ButtonType.linkedin,
                              // btnColor: Colors.lightBlue,
                              onPressed: null,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

//   void _togglePasswordView() {
//     if (ishiddenpassword == true) {
//       ishiddenpassword = false;
//     } else {
//       ishiddenpassword = true;
//     }
// //     setState(() {
// //       // isHiddenPassword = !isHiddenPassword;
// //     });
//   }
}
