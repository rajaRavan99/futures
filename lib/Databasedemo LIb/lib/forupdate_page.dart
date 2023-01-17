import 'package:flutter/material.dart';

import 'db_helper.dart';

class ForUpdatePage extends StatefulWidget {
  final Map<String, dynamic> user;
  ForUpdatePage({super.key, required this.user});

  @override
  State<ForUpdatePage> createState() => _ForUpdatePageState();
}

class _ForUpdatePageState extends State<ForUpdatePage> {
  TextEditingController usernameController = TextEditingController(text: "");
  TextEditingController emailController = TextEditingController(text: "");
  TextEditingController phoneController = TextEditingController(text: "");
  TextEditingController ageController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    //show users data in form field :-

    usernameController.text = widget.user["username"].toString();
    emailController.text = widget.user["email"].toString();
    phoneController.text = widget.user["phone"].toString();
    ageController.text = widget.user["age"].toString();

    //show users data in form field :-

    print(widget.user);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: usernameController,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: TextFormField(
                  controller: emailController,
                ),
              ),
              TextFormField(
                controller: phoneController,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: ageController,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: ElevatedButton(
                  onPressed: () {
                    DBHelper.update(
                      usernameController.text.trim(),
                      emailController.text.trim(),
                      int.parse(phoneController.text.trim()),
                      // phoneController.text.trim(),
                      int.parse(ageController.text.trim()),
                    );
                  },
                  child: const Text("Update Data"),
                ),
              ),
              // ClipOval(
              //   child: IconButton(
              //     onPressed: () {},
              //     icon: const Icon(
              //       size: 25,
              //       Icons.delete,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      )),
    );
  }
}
