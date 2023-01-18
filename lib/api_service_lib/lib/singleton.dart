import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class Singleton {
  Singleton._privateConstructor();

  static final Singleton _instance = Singleton._privateConstructor();

  static Singleton get instance => _instance;

  Future<File?> pickImage(ImageSource pickImage) async {
    var imagePicker = ImagePicker();

    try {
      final pickedFile = await imagePicker.pickImage(
        source: pickImage,
        imageQuality: 60,
      );

      return File(pickedFile!.path);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      // return File("");
    }
  }

  void showPicker(
    context,
    Function pickedImage,
    bool isNeedToShowRemoveProfilePhoto,
  ) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: Colors.white,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                // color: Colors.pink,
                child: Wrap(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        pickedImage(ImageSource.gallery);
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Icon(
                              Icons.photo_library,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Choose image",
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        pickedImage(ImageSource.camera);
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Icon(
                              Icons.photo_camera,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Take a photo",
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (isNeedToShowRemoveProfilePhoto)
                      GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Icon(
                                Icons.delete,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Remove photo",
                              ),
                            ],
                          ),
                        ),
                      ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Icon(Icons.photo_camera, color: Colors.transparent),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Cancel",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
