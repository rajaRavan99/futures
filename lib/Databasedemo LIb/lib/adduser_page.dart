import 'package:flutter/material.dart';

import 'db_helper.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final ageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextFormField(
                controller: usernameController,
                style: const TextStyle(
                    // color: Colors.black,
                    ),
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
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  // prefixIcon: prefixIcon ??
                  //     Icon(
                  //       Icons.person,
                  //       color: Colors.black38,
                  //     ),
                  hintText: "Enter Name",
                  hintStyle: const TextStyle(
                      // color: Colors.black,
                      ),
                  labelText: "Username",
                  labelStyle: const TextStyle(
                      // color: Colors.black38,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: TextFormField(
                  controller: emailController,
                  style: const TextStyle(
                      // color: Colors.black,
                      ),
                  decoration: InputDecoration(
                    // filled: true,-
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
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    // prefixIcon: prefixIcon ??
                    //     Icon(
                    //       Icons.person,
                    //       color: Colors.black38,
                    //     ),
                    hintText: "Email",
                    hintStyle: const TextStyle(
                        // color: Colors.black,
                        ),
                    labelText: "Email",
                    labelStyle: const TextStyle(
                        // color: Colors.black38,
                        ),
                  ),
                ),
              ),
              TextFormField(
                controller: phoneController,
                style: const TextStyle(
                    // color: Colors.black,
                    ),
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
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  // prefixIcon: prefixIcon ??
                  //     Icon(
                  //       Icons.person,
                  //       color: Colors.black38,
                  //     ),
                  hintText: "Contact Number",
                  hintStyle: const TextStyle(
                      // color: Colors.black,
                      ),
                  labelText: "Contact Number",
                  labelStyle: const TextStyle(
                      // color: Colors.black38,
                      ),
                ),
                maxLength: 10,
              ),
              TextFormField(
                controller: ageController,
                style: const TextStyle(
                    // color: Colors.black,
                    ),
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
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  // prefixIcon: prefixIcon ??
                  //     Icon(
                  //       Icons.person,
                  //       color: Colors.black38,
                  //     ),
                  hintText: "Age",
                  hintStyle: const TextStyle(
                      // color: Colors.black,
                      ),
                  labelText: "Age",
                  labelStyle: const TextStyle(
                      // color: Colors.black38,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: ElevatedButton(
                  onPressed: () {
                    DBHelper.insertData(
                      usernameController.text.trim(),
                      emailController.text.trim(),
                      int.parse(phoneController.text.trim()),
                      // phoneController.text.trim(),
                      int.parse(ageController.text.trim()),
                    );
                  },
                  child: const Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
