import 'dart:async';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/ApiModel.dart';
import 'controller.dart';

// ignore: camel_case_types
class services {
  static var controller = Get.lazyPut(() => dataController());
  static var client = http.Client();
  static var listofdata = <Datum>[];

  static Future<dynamic> fetchProducts() async {
    var response =
        await client.get(Uri.parse('https://reqres.in/api/users?page=1'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      print(response.body);
      return itemFromJson(jsonString);
    } else {
      //show error message
      return [];
    }
  }
}
