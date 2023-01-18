import 'package:aug_new_demo/ui_pages/First_homepage.dart';
import 'package:aug_new_demo/ui_pages/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
// // ignore: unused_import
import 'package:sign_button/sign_button.dart';

// class home extends StatelessWidget {
//   const home({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     launchURL(string url) async {
//       if (await canlaunch(url)) {
//         await launchURL(url);
//       } else {
//         throw 'could not catch $url';
//       }
//     }

//     return Scaffold();
//   }
// }

// main() async {
//   await GetStorage.init();
//   runApp(signup());
// }

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupPageState();
}

class _signupPageState extends State<signup> {
  // final controller = Get.put(loginController());
  final String _buttonClick = "click sign in button";

  var storage = Getstorage;

  final fullnamecontroller = TextEditingController(text: "");

  final emailcontroller = TextEditingController(text: "");

  final numbercontroller = TextEditingController(text: "");

  final pwdcontroller = TextEditingController(text: "");

  bool _isLightTheme = false;
  bool _isLightTheme1 = false;

  // final pwdfocusnode = FocusNode();

  @override
  void dispose() {
    fullnamecontroller.dispose();
    emailcontroller.dispose();
    numbercontroller.dispose();
    pwdcontroller.dispose();
    super.dispose();
  }

  bool changebutton = false;
  bool ishiddenpassword = true;

  // ignore: non_constant_identifier_names

  final _formkey = GlobalKey<FormState>();
  late SharedPreferences prefs;
  get prefixIcon => null;

  // // ignore: non_constant_identifier_names
  // ignore: non_constant_identifier_names
  _saveToShared_Preferences() async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString("FullName", fullnamecontroller.text.toString());
    prefs.setString("Email", emailcontroller.text.toString());
    prefs.setString("Number", numbercontroller.text.toString());
    prefs.setString("password", pwdcontroller.text.toString());

    String uName = prefs.getString("Username").toString();
    print(uName);
    // ignore: use_build_context_synchronously
    Get.to(first_Homepage());
  }

  // Map<String, String> userData;
  // userData = {
  //   "Fullname": T_controller.text,
  //   "Email": T_controller1.text,
  //   "Username": T_controller2.text,
  //   "password": T_controller3.text,
  // };
  // getText() {
  //   return T_controller.text;
  // }

  // getText1() {
  //   return T_controller1.text;
  // }

  // getText2() {
  //   return T_controller2.text;
  // }

  // getText3() {
  //   return T_controller3.text;
  // }

  movetoHome(BuildContext context) async {
    // ignore: unused_local_variable
    final double screenHeight = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    final double screenWidth = MediaQuery.of(context).size.width;
    if (_formkey.currentState!.validate()) {
      setState(() {
        changebutton = true;
      });
      await Future.delayed(const Duration(seconds: 1));
      // ignore: use_build_context_synchronously
      await Get.to(first_Homepage());
      setState(() {
        changebutton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isValidEmail(String value) {
      return RegExp(
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          .hasMatch(value);
    }

    //for passoword
    RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
    double passwordStrength = 0;

    bool validatePassword(String pass) {
      String _password = pass.trim();

      if (_password.isEmpty) {
        setState(() {
          passwordStrength = 0;
        });
      } else if (_password.length < 6) {
        setState(() {
          passwordStrength = 1 / 4;
        });
      } else if (_password.length < 8) {
        setState(() {
          passwordStrength = 2 / 4;
        });
      } else {
        if (pass_valid.hasMatch(_password)) {
          setState(() {
            passwordStrength = 4 / 4;
          });
          return true;
        } else {
          setState(() {
            passwordStrength = 3 / 4;
          });
          return false;
        }
      }
      return false;
    }

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            reverse: false,
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formkey,
                  child: Container(
                    // height: 900,
                    // height: Get.height,
                    // width: Get.width,
                    decoration: const BoxDecoration(
                      // borderRadius: BorderRadius.circular(50),
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://th.bing.com/th/id/R.2bf0158b789c0d7f2bd66a3ec3f76488?rik=4gxDZrVISRZeAg&riu=http%3a%2f%2f3.bp.blogspot.com%2f-1SYrbxJsLiI%2fUh9yksZGFvI%2fAAAAAAAAHCQ%2fi41Qndj_YIs%2fs1600%2fPhoto-Background-Application.jpg&ehk=zmxcqeaoAc21%2bczrHEqfYuNZB%2fS9g6e9XU%2bu8IFu39U%3d&risl=&pid=ImgRaw&r=0"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 25.0,
                        ),
                        Lottie.network(
                          "https://assets9.lottiefiles.com/packages/lf20_nUTP5Vd52q.json",
                          height: 125,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const Text(
                          "SignUp ",
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 1.0, horizontal: 20.0),
                          child: Container(
                            height: 560,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white10,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  TextFormField(
                                    style: const TextStyle(
                                        // color: Colors.black,
                                        ),
                                    textInputAction: TextInputAction.done,
                                    controller: fullnamecontroller,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 2, color: Colors.white),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 3, color: Colors.black12),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      prefixIcon: prefixIcon ??
                                          const Icon(
                                            Icons.person,
                                            color: Colors.black38,
                                          ),
                                      hintText: "Name",
                                      hintStyle: const TextStyle(
                                          // color: Colors.black,
                                          ),
                                      labelText: "Full Name",
                                      labelStyle: const TextStyle(
                                        color: Colors.black38,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Name is Required";
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.name,
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  TextFormField(
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                    textInputAction: TextInputAction.done,
                                    controller: emailcontroller,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 2, color: Colors.white),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 3, color: Colors.black12),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      suffixText: ('email.com'),
                                      prefixIcon: prefixIcon ??
                                          const Icon(
                                            Icons.mail,
                                            color: Colors.black38,
                                          ),
                                      labelText: "E-mail",
                                      labelStyle: const TextStyle(
                                        color: Colors.black38,
                                      ),
                                    ),

                                    // ignore: body_might_complete_normally_nullable
                                    validator: (value) {
                                      bool valid = isValidEmail(value ?? "");

                                      if (!GetUtils.isEmail(value!)) {
                                        return "Email is not valid";
                                      } else {
                                        return null;
                                      }
                                    },

                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),

                                  IntlPhoneField(
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                    dropdownIcon: const Icon(
                                      Icons.phone,
                                      color: Colors.black38,
                                    ),

                                    flagsButtonMargin: const EdgeInsets.only(
                                        left: 3, right: 0),
                                    dropdownIconPosition: IconPosition.leading,
                                    dropdownTextStyle:
                                        const TextStyle(color: Colors.black),
                                    invalidNumberMessage: 'Empty Field',
                                    initialCountryCode: 'IN',

                                    obscureText: false,
                                    textInputAction: TextInputAction.done,
                                    keyboardType: TextInputType.number,
                                    showCountryFlag: false,
                                    flagsButtonPadding:
                                        const EdgeInsets.all(10),
                                    controller: numbercontroller,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 2, color: Colors.white),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            width: 2, color: Colors.black12),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    // validator: (value) {
                                    //   if (value!.isEmpty) {
                                    //     return "Password can not be empty";
                                    //   } else if (value.length < 6) {
                                    //     return "Password length sould be atleast 6";
                                    //   }

                                    //   return null;
                                    // },

                                    onChanged: (phone) {
                                      print(phone.completeNumber);
                                    },
                                    onCountryChanged: (country) {
                                      print('Country changed to: ' +
                                          country.name);
                                    },
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  TextFormField(
                                      style: const TextStyle(
                                          // color: Colors.black,
                                          ),
                                      // focusNode: pwdfocusnode,
                                      // textInputAction: TextInputAction.done,
                                      controller: pwdcontroller,
                                      obscureText: ishiddenpassword,
                                      decoration: InputDecoration(
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 2, color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 3, color: Colors.black12),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        prefixIcon: prefixIcon ??
                                            const Icon(
                                              Icons.lock,
                                              color: Colors.black38,
                                            ),
                                        hintText: "Enter Password ",
                                        hintStyle: const TextStyle(
                                            // color: Colors.black38,
                                            ),
                                        labelText: "Password",
                                        labelStyle: const TextStyle(
                                          color: Colors.black38,
                                        ),
                                        suffixIcon: IconButton(
                                          color: Colors.black38,
                                          padding: const EdgeInsets.all(15),
                                          onPressed: () {
                                            // ignore: avoid_print
                                            print('working');

                                            setState(() {
                                              ishiddenpassword =
                                                  !ishiddenpassword;
                                              // ignore: avoid_print
                                              print(ishiddenpassword);
                                            });
                                          },
                                          icon: Icon(ishiddenpassword
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                        ),
                                      ),
                                      // validator: (value) {
                                      //   if (value!.isEmpty) {
                                      //     return "Password can not be empty";
                                      //   } else if (value.length < 6) {
                                      //     return "Password length sould be atleast 6";
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
                                      keyboardType: TextInputType.text),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (_formkey.currentState!.validate()) {
                                        _saveToShared_Preferences();
                                        Get.snackbar("Welcome", "",
                                            borderRadius: 50,
                                            padding: const EdgeInsets.all(10),
                                            margin: const EdgeInsets.all(10),
                                            backgroundGradient:
                                                const LinearGradient(colors: [
                                              Colors.orange,
                                              Colors.white,
                                              Colors.green
                                            ]));
                                      }
                                      //else if (_saveToShared_Preferences()) {
                                      //   // ignore: avoid_print
                                      //   return;
                                      // }
                                    },
                                    // onDoubleTap: () => _saveToShared_Preferences(),
                                    child: AnimatedContainer(
                                      duration: const Duration(seconds: 1),
                                      child: Container(
                                        width: 150,
                                        height: 40,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color: _isLightTheme
                                                ? Colors.white
                                                : Colors.black38,
                                            borderRadius:
                                                BorderRadius.circular(35)),
                                        child: const Text(
                                          "Sign up",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Already have an account ?",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: _isLightTheme
                                              ? Colors.white
                                              : Colors.black38,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 3.0,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.to(const LoginPage());
                                        },
                                        child: Text(
                                          "Sign in",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: _isLightTheme
                                                ? Colors.white
                                                : Colors.black38,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Text(
                                  //   '$_buttonClick',
                                  //   style: Theme.of(context).textTheme.headline4,
                                  // ),
                                  const SizedBox(
                                    height: 40.0,
                                  ),

                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SignInButton.mini(
                                                buttonSize: ButtonSize.medium,
                                                buttonType: ButtonType.facebook,
                                                onPressed: () {
                                                  // var url =
                                                  //     'https://www.facebook.com/';

                                                  // var launchURL;
                                                  // (url);
                                                }),
                                            InkWell(
                                              child: SignInButton.mini(
                                                buttonSize: ButtonSize.medium,
                                                buttonType: ButtonType.google,
                                                //btnDisabledColor: Colors.grey,
                                                onPressed: () {
                                                  GoogleSignIn().signIn();
                                                },
                                              ),
                                            ),
                                            InkWell(
                                              child: SignInButton.mini(
                                                  buttonSize: ButtonSize.medium,
                                                  buttonType: ButtonType.mail,
                                                  onPressed: () {}

                                                  // btnDisabledColor: Colors.grey,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // disabled mini button
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }

  // void _togglePasswordView() {
  //   // if (ishiddenpassword == true) {
  //   //   ishiddenpassword = false;
  //   // } else {
  //   //   ishiddenpassword = true;
  //   // }
  //   setState(() {
  //     ishiddenpassword = !ishiddenpassword;
  //   });
  // }
}

class Getstorage {}

canlaunch(String url) {}
