import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dashboard.dart';

class Service extends GetConnect {
  Future<dynamic> postdata(username, password) async {
    Map<String, String> headerData = {'Content-Type': 'application/json'};

    Map<String, String> bodydata = {
      "userid": username,
      "password": password,
      "device_id": "a91dec2903cd013d",
      "device_detail": "{\"version.securityPatch\":\"2022-07-01\"}"
    };

    final response = await post(
        "https://erp.cfsys.xyz/api/V1/get_access_code", bodydata,
        headers: headerData);
    if (response.status.hasError) {
      return Future.error(response.statusText!);
    } else {
      print(response.body);

      var newdata = response.body;

      if (newdata != null || newdata['st'] == 'success') {
        Get.to(dashboard());
      } else {
        Get.snackbar("ssdsdsdsdsdsdsd", "",
            backgroundColor: Colors.black45, colorText: Colors.white);
      }
      return response.body;
    }
  }
}
