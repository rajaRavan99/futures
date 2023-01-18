import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';

import 'loginpage.dart';

class Signuppage extends StatelessWidget {
  Signuppage({super.key});

  var itemlist = [
    'Select State',
    ' Andaman and Nicobar (UT)',
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chandigarh (UT)',
    'Chhattisgarh',
    'Dadra and Nagar Haveli (UT)',
    'Daman and Diu (UT)',
    'Delhi',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jammu and Kashmir',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Lakshadweep (UT)',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Orissa',
    'Puducherry (UT)',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          reverse: false,
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                width: context.width,
                height: context.height,
                // color: Colors.redAccent,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://th.bing.com/th/id/OIP.h5vKARX7HIese4kXH2KKNAHaFj?pid=ImgDet&rs=1"),
                      fit: BoxFit.cover),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.only(
                          bottom: 20, top: 40, right: 10, left: 10),
                      width: context.width,
                      height: context.height,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            // Image.asset("assets/Logo.png"),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 40,
                              margin: const EdgeInsets.only(
                                  left: 15, right: 5, top: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    textAlign: TextAlign.left,
                                    "Sign Up",
                                    style: TextStyle(
                                      fontSize: 25,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 40,
                              width: context.width,
                              margin: const EdgeInsets.only(
                                  top: 20, left: 10, right: 10),
                              child: TextFormField(
                                // validator: (value) {
                                //   if (!controller.isEmail(value!) && !controller.isPhone(value)) {
                                //     return 'Please enter a valid email or phone number.';
                                //   }

                                //   return null;
                                // },
                                style: const TextStyle(fontSize: 15),
                                // controller: controller.loginTypeController,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                          width: 1.0),
                                      borderRadius: BorderRadius.circular(8)),
                                  isDense: true,
                                  contentPadding: const EdgeInsets.all(12),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                          width: 1.2),
                                      borderRadius: BorderRadius.circular(8)),
                                  hintText: 'Sponsor code',
                                  hintStyle: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey.shade500),
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              width: double.infinity,
                              margin: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10, bottom: 10),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const Text('Verify'),
                                style: ElevatedButton.styleFrom(
                                    // fixedSize: const Size(240, 80),
                                    backgroundColor: Colors.deepOrange),
                              ),
                            ),
                            Container(
                              height: 40,
                              margin: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10),
                              child: TextFormField(
                                // validator: (value) {
                                //   if (!controller.isEmail(value!) && !controller.isPhone(value)) {
                                //     return 'Please enter a valid email or phone number.';
                                //   }

                                //   return null;
                                // },
                                style: const TextStyle(fontSize: 15),
                                // controller: controller.loginTypeController,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                          width: 1.0),
                                      borderRadius: BorderRadius.circular(8)),
                                  isDense: true,
                                  contentPadding: const EdgeInsets.all(12),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                          width: 1.2),
                                      borderRadius: BorderRadius.circular(8)),
                                  hintText: 'Username',
                                  hintStyle: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey.shade500),
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              width: context.width,
                              margin: const EdgeInsets.only(
                                  top: 20, left: 10, right: 10),
                              child: TextFormField(
                                // validator: (value) {
                                //   if (!controller.isEmail(value!) && !controller.isPhone(value)) {
                                //     return 'Please enter a valid email or phone number.';
                                //   }

                                //   return null;
                                // },
                                style: const TextStyle(fontSize: 15),
                                // controller: controller.loginTypeController,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                          width: 1.0),
                                      borderRadius: BorderRadius.circular(8)),
                                  isDense: true,
                                  contentPadding: const EdgeInsets.all(12),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                          width: 1.2),
                                      borderRadius: BorderRadius.circular(8)),
                                  hintText: 'Phone Number',
                                  hintStyle: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey.shade500),
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              width: context.width,
                              margin: const EdgeInsets.only(
                                  top: 20, left: 10, right: 10),
                              child: TextFormField(
                                // validator: (value) {
                                //   if (!controller.isEmail(value!) && !controller.isPhone(value)) {
                                //     return 'Please enter a valid email or phone number.';
                                //   }

                                //   return null;
                                // },
                                style: const TextStyle(fontSize: 15),
                                // controller: controller.loginTypeController,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                          width: 1.0),
                                      borderRadius: BorderRadius.circular(8)),
                                  isDense: true,
                                  contentPadding: const EdgeInsets.all(12),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                          width: 1.2),
                                      borderRadius: BorderRadius.circular(8)),
                                  hintText: 'Email Address',
                                  hintStyle: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey.shade500),
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              width: context.width,
                              margin: const EdgeInsets.only(
                                top: 20,
                                left: 9,
                                right: 9,
                              ),
                              padding:
                                  const EdgeInsets.only(right: 10, left: 10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1.0,
                                  color: Colors.grey.shade300,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: DropdownButton(
                                hint: Text(
                                  "Select State",
                                  style: TextStyle(
                                      color: Colors.black38, fontSize: 13),
                                ),
                                underline: Container(),
                                isExpanded: true,
                                iconEnabledColor: Colors.black,
                                dropdownColor: Colors.white,
                                focusColor: Colors.black,
                                items: itemlist.map((String items) {
                                  return DropdownMenuItem(
                                      value: items, child: Text(items));
                                }).toList(),
                                onChanged: (
                                  String,
                                ) {
                                  // setState(() {
                                  //   initialValue = newValue;
                                  // });
                                },
                              ),
                            ),
                            Container(
                              height: 40,
                              width: context.width,
                              margin: const EdgeInsets.only(
                                  top: 20, left: 10, right: 10, bottom: 10),
                              child: TextFormField(
                                // validator: (value) {
                                //   if (!controller.isEmail(value!) && !controller.isPhone(value)) {
                                //     return 'Please enter a valid email or phone number.';
                                //   }

                                //   return null;
                                // },
                                style: const TextStyle(fontSize: 15),
                                // controller: controller.loginTypeController,
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                          width: 1.0),
                                      borderRadius: BorderRadius.circular(8)),
                                  isDense: true,
                                  contentPadding: const EdgeInsets.all(12),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade300,
                                          width: 1.2),
                                      borderRadius: BorderRadius.circular(8)),
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey.shade500),
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              width: double.infinity,
                              margin: const EdgeInsets.only(
                                  top: 10, left: 10, right: 10, bottom: 20),
                              child: ElevatedButton(
                                onPressed: () {},
                                child: const Text('Sign Up'),
                                style: ElevatedButton.styleFrom(
                                    // fixedSize: const Size(240, 80),
                                    backgroundColor: Colors.deepOrange),
                              ),
                            ),
                            Container(
                              height: 40,
                              width: context.width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: RichText(
                                      text: TextSpan(
                                        // Note: Styles for TextSpans must be explicitly defined.
                                        // Child text spans will inherit styles from parent
                                        style: const TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                        ),
                                        children: <TextSpan>[
                                          const TextSpan(
                                              text:
                                                  "By signing up , you agree to Maxshop's"),
                                          TextSpan(
                                              recognizer:
                                                  TapGestureRecognizer(),
                                              // ..onTap = () => Get.to(WebViewPage(
                                              //     'Terms & Conditions',
                                              //     'https://www.whatsapp.com/legal/')),
                                              text: ' Terms Of Service',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.pink)),
                                          const TextSpan(text: ' and'),
                                          TextSpan(
                                              recognizer:
                                                  TapGestureRecognizer(),
                                              // ..onTap = () => Get.to(WebViewPage(
                                              //     'Privacy Policy',
                                              //     'https://www.whatsapp.com/legal/')),
                                              text: ' Privacy Policy',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.pink)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: RichText(
                                    text: TextSpan(
                                      // Note: Styles for TextSpans must be explicitly defined.
                                      // Child text spans will inherit styles from parent
                                      style: const TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black38,
                                      ),
                                      children: <TextSpan>[
                                        const TextSpan(
                                            text: "Have an account?"),
                                        TextSpan(
                                            recognizer: TapGestureRecognizer()
                                              ..onTap =
                                                  () => Get.to(Loginpage()),
                                            text: ' Log In',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.pink)),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
