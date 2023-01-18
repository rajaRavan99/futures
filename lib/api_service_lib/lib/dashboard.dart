import 'dart:io';
import 'package:apiservicesdemo/services.dart';
import 'package:apiservicesdemo/singleton.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class apiServices extends StatefulWidget {
  @override
  State<apiServices> createState() => _apiServicesState();
}

class _apiServicesState extends State<apiServices> {
  File? _image;

  String? imagepath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Map<String, String> headerData = {};
                    services.getCall(
                        Uri.parse(
                            'http://makeup-api.herokuapp.com/api/v1/products.json'),
                        false,
                        headerData);
                  },
                  child: const Text("Get"),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Map<String, String> headerData = {
                      "Authorization":
                          "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZGFzaGJvYXJkLnFpa3RlbGwuY29tXC9hcGlcL2xvZ2luIiwiaWF0IjoxNjYyNjQxNTc2LCJleHAiOjE5MzIzMjE5MjkzNiwibmJmIjoxNjYyNjQxNTc2LCJqdGkiOiJLWExHelZ3NW9RMm5hMVRqIiwic3ViIjo0LCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.0Iu77csZ7JRjGGDAoup61ckalHlt2qMz0VmTe_peIa0"
                    };
                    services.getCall(
                        Uri.parse(
                            'https://dashboard.qiktell.com/api/get-profile'),
                        true,
                        headerData);
                  },
                  child: const Text("Get With Header"),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Map<String, String> header = {
                      "Authorization":
                          "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiI5MTNhMDc3NS1lYzFmLTQ5MjMtODEwOS00MTJkOGVmNTFkMzAiLCJqdGkiOiIwMjAwOTFjNjc1MDQzMDIyMmM0NjZjOGJhMGNiYTViZDYwMDZhZjY1NzhmN2VjZTQ1OGQwMzBkOWI2MWZhMmQ5MTFiYWIxYWRlY2IyMzIwNCIsImlhdCI6MTY2MjcxMTU3NSwibmJmIjoxNjYyNzExNTc1LCJleHAiOjE2OTQyNDc1NzUsInN1YiI6IjQiLCJzY29wZXMiOltdfQ.HkAtYG7fcoLncN1vqtiTAEEL_CYwJeZ5mh06vH_pLq6ypbUVVyYjZBBpddIQx6FqkvaoAitamg2bcz5c0WgTS4U-VuMm8gWsSjDxPhB-iP0QF79WTmqyn4qspS1HBjqGg5oe4gap4UAHIDRy2ly1t2ZOb1AoQ6Z4TKGoyererMjGiwD3PM_0Eidh82Zj_p_q1RJsqveclSKlsjCBoIGZYdwLryrn60J7nuxDRcqK0gIQvBPPHEgt-3KXEDXPK6mSM3a-j6dI3kJL5lZfdUz-tz3JNqodhqHJe_o_xMJUyBGzqyey32I012WfWvxRJWddfEdlMAPS_oARXyvzNDtATe0mJg5WKx4A9AUamtXUCR6KUasaokKfSUmn3spwVqfNfPHuoTTIdR3f5Y4GPneqEUbe3osXkJeJHkeoiuQWTExyoQf4T_kfZFi0yzh61AN7j2XQbYRxJJKgWlkUULvzMbSjeGcOa_XP5jsAgusO27XW27v_M9OiXMcskGmCWyALfCJTY63eNlqv2nswv55-xBo_iC6hxVqqTy50LiV9hlLvjkWr_DVddrOuDFqe9ZVJ-xD-NPjZt1xljR1F1mjGOTsaYuJ2wKK6nQ3PdvUXGWZWFE_QS_KHHhZCu9M4sTai6shkMw59TgSQyBmPjT8nU-haKWBHRMW3t2Ny3NeSs_E",
                    };
                    Map<String, String> bodydata = {
                      "searchStatus": "1",
                      "limit": "30",
                      "offset": "0"
                    };
                    services.postcall(
                        Uri.parse(
                          'http://tract.aipxperts.com:8080/api/v1/company/employee-list',
                        ),
                        true,
                        header,
                        bodydata);
                  },
                  child: const Text("Postcall"),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Singleton.instance.showPicker(context, pickedImage, false);
                  },
                  child: const Text("choose photo"),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    services.MultipartFile(
                        Uri.parse(
                            "http://tellme.aipxperts.com:8080/api/register"),
                        _image!.absolute.path);
                  },
                  child: const Text('Call Multipart'),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void pickedImage(ImageSource imageSource) {
    Singleton.instance.pickImage(imageSource).then(
          (value) => setState(
            () {
              if (value == null) {
              } else {
                _image = value;
                setState(() {});
              }
            },
          ),
        );
  }
}
