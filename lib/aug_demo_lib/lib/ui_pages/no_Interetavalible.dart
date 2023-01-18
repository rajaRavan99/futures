// import 'package:flutter/material.dart';

// class Nointernetaccess extends StatelessWidget {
//   const Nointernetaccess({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(),
//         body: Center(
//           child: Column(
//             children: [Text('No Internet Avalible Please Check your Internet')],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Nointernetaccess extends StatefulWidget {
  const Nointernetaccess({Key? key}) : super(key: key);

  @override
  State<Nointernetaccess> createState() => _LoginPageState();
}

class _LoginPageState extends State<Nointernetaccess> {
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
              height: context.height,
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
                child: Column(
                  children: const [
                    SizedBox(
                      height: 100.0,
                    ),
                    Text(
                      "Sign In ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 100.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
