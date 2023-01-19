import 'package:flutter/material.dart';

class Utils {
  // final messengerKey = GlobalKey<ScaffoldMessengerState>();
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text) {
    if (text == null) return;

    final snackBar =
        SnackBar(content: Text(text), backgroundColor: Colors.transparent);

    messengerKey.currentState!
      // ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
