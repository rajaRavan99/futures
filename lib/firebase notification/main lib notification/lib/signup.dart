// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebasedatareleted/loginpage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:get/get.dart';

// class signup extends StatefulWidget {
//   signup({super.key});

//   // var email = "";
//   // var Password = "";

//   @override
//   State<signup> createState() => _loginpageState();
// }

// class _loginpageState extends State<signup> {
//   final emailcontroller = TextEditingController(text: "");
//   final passwordcontroller = TextEditingController(text: "");

//   @override
//   void dispose() {
//     emailcontroller.dispose();
//     passwordcontroller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text("Firebase Auth"),
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const SizedBox(
//                   height: 150,
//                 ),
//                 TextFormField(
//                   style: const TextStyle(
//                       // color: Colors.black,
//                       ),
//                   controller: emailcontroller,
//                   decoration: InputDecoration(
//                     // filled: true,
//                     // fillColor: Colors.black,
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: const BorderSide(
//                         width: 2,
//                         color: Colors.white,
//                       ),
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: const BorderSide(
//                         width: 3,
//                         color: Colors.black12,
//                       ),
//                       borderRadius: BorderRadius.circular(15),
//                     ),

//                     hintText: "Enter E-mail",
//                     hintStyle: const TextStyle(
//                       color: Colors.black38,
//                     ),
//                     labelText: "E-mail",
//                     labelStyle: const TextStyle(
//                       color: Colors.black38,
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   style: const TextStyle(
//                       // color: Colors.black,
//                       ),
//                   controller: passwordcontroller,
//                   decoration: InputDecoration(
//                     // filled: true,
//                     // fillColor: Colors.black,
//                     enabledBorder: OutlineInputBorder(
//                       borderSide: const BorderSide(
//                         width: 2,
//                         color: Colors.white,
//                       ),
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: const BorderSide(
//                         width: 3,
//                         color: Colors.black12,
//                       ),
//                       borderRadius: BorderRadius.circular(15),
//                     ),

//                     hintText: "Password",
//                     hintStyle: const TextStyle(
//                       color: Colors.black38,
//                     ),
//                     labelText: "Password",
//                     labelStyle: const TextStyle(
//                       color: Colors.black38,
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     signup();
//                   },
//                   child: const Text("signup"),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     Get.to(loginwidget());
//                   },
//                   child: const Text("Login"),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future signup() async {
//     try {
//       await FirebaseAuth.instance.createUserWithEmailAndPassword(
//         email: emailcontroller.text.trim(),
//         password: passwordcontroller.text.trim(),
//       );
//     } on FirebaseAuthException catch (e) {
//       print(e);
//     }
//   }
// }
