import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:firebase_app_installations/firebase_app_installations.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ManageStorage.dart';
import 'Utils.dart';
import 'cfs.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;
final FirebaseAuth auth = FirebaseAuth.instance;

class CallApi {
  //Api Url
  static const String _url1 = 'https://';
  static const String _url_get = 'wakeup.cfsys.xyz/api/v1/';
  //static const String _path_get = '/api/V1/';
  //static const String login_path = '/api/';
  static const String _url = '$_url1$_url_get';

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  fUri(auth, path, data) {
    return Uri.http(auth, path, data);
  }

  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    printWrapped(fullUrl);
    printWrapped(jsonEncode(data));
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: setHeaders2());
  }

  postDataFun(apiUrl, data) async {
    print("jjjjjjjjjjjjjjjjjjjjj");
    var returnData = {};
    try {
      var fullUrl = _url + apiUrl;
      var headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Cookie': 'ASP.NET_SessionId=1owoev45agu5on45f5y00ge4'
      };
      print("11111111111111111111111111");
      var request = http.Request('POST', Uri.parse(fullUrl));
      print("22222222222222222");
      request.bodyFields = Map<String, String>.from(data);
      print("33333333333");
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      print("rrrrrrrrrrrrrrr");
      if (response.statusCode == 200) {
        var rr = await response.stream.bytesToString();
        if (rr == "Data not found.") {
          returnData['st'] = "success";
          returnData['data'] = [];
        } else {
          var data = jsonDecode(rr);
          returnData['st'] = "success";
          returnData['data'] = data;
        }
      } else {
        returnData['st'] = "fail";
        returnData['msg'] = "Internal Server Error ${response.statusCode}";
      }
    } catch (e) {
      print("Api Catch Error : $e");
      returnData['st'] = "fail";
      returnData['msg'] = "Internal Catch Error";
    }
    return returnData;
  }

  loginFun(apiUrl, data) async {
    print("jjjjjjjjjjjjjjjjjjjjj");
    var returnData = {};
    try {
      var fullUrl = _url + apiUrl;
      var headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Cookie': 'ASP.NET_SessionId=1owoev45agu5on45f5y00ge4'
      };
      print("11111111111111111111111111");
      var request = http.Request('POST', Uri.parse(fullUrl));
      print("22222222222222222");
      request.bodyFields = Map<String, String>.from(data);
      print("33333333333");
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      print("rrrrrrrrrrrrrrr");
      if (response.statusCode == 200) {
        var rr = await response.stream.bytesToString();
        if (rr == "success") {
          returnData['st'] = "success";
          returnData['msg'] = "Login successful";
        } else {
          returnData['st'] = "fail";
          returnData['msg'] = rr;
        }
      } else {
        returnData['st'] = "fail";
        returnData['msg'] = "Internal Server Error ${response.statusCode}";
      }
    } catch (e) {
      print("Api Catch Error : $e");
      returnData['st'] = "fail";
      returnData['msg'] = "Internal Catch Error";
    }
    return returnData;
  }

  getData(apiUrl, data) async {
    print(data);
    var pdata = Map<String, dynamic>.from(data);
    var fullUrl = fUri(_url_get, /*_path_get+*/ apiUrl, pdata);
    print(fullUrl);
    return await http.get(fullUrl, headers: _setHeaders());
  }

  getDataLogin(apiUrl, data) async {
    print(data);
    var pdata = Map<String, dynamic>.from(data);
    var fullUrl = fUri(_url_get, /*login_path+*/ apiUrl, pdata);
    print(fullUrl);
    return await http.get(fullUrl, headers: _setHeaders());
  }

  getPostData(apiUrl, data) async {
    print(data);
    var pdata = Map<String, dynamic>.from(data);
    var fullUrl = fUri(_url_get, /*_path_get+*/ apiUrl, pdata);
    print(fullUrl);
    return await http.post(fullUrl, headers: _setHeaders());
  }

  uploadData(data, apiUrl) async {
    /* var fullUrl = _url + apiUrl;
    print(fullUrl);
    print(jsonEncode(data));
    var request = http.MultipartRequest('POST', Uri.parse(fullUrl));
    var hb=await http.MultipartFile.fromPath('ImageData', filename);
    request.files.add(await http.MultipartFile.fromPath('ImageData', filename));


    var res = await http.Response.fromStream(await request.send());
    return res; */
    var fullUrl = _url + apiUrl;
    printWrapped(fullUrl);
    printWrapped(jsonEncode(data));

    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  getApiurl(apiUrl) async {
    var fullUrl = _url + apiUrl;
    return fullUrl;
  }

  _setHeaders() => {
        // 'Authorization' : '4ccda7514adc0f13595a585205fb9761',
        //'Content-type' : 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      };

  setHeaders2() => {
        // 'Authorization' : '4ccda7514adc0f13595a585205fb9761',
        //'Content-type' : 'application/json',
        'Content-Type': 'application/json',
      };
}

class ApiData {
  dynamic get_access_code() async {
    final User? user = auth.currentUser;
    final device_id = await FirebaseInstallations.instance.getId();
    var data = {};
    var device_data = await Callcfs().initPlatformState();
    data["umobile"] = user!.phoneNumber;
    data["gid"] = user.uid;
    data["acode"] = "1";
    data["gtoken"] = "1";
    data["device_id"] = device_id;
    data["device_name"] = device_data["device"];
    data["device_detail"] = "1";
    data["device_ip"] = device_data["device_id"];
    var return_data = {};
    final response = await CallApi().postData(data, 'get_access_code');
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result['st'] == 'success') {
        print(result);
        print(result["adata"]["atoken"].toString());
        AppStorage.setData('aaid', result["adata"]["atoken"].toString());
        // AppStorage.setData('utype', result["adata"]["utype"].toString());
        AppStorage.setData(
            'is_verify', result["adata"]["is_verify"].toString());
        return_data = result;
      } else {
        return_data["st"] = result['st'];
        return_data["msg"] = result['msg'];
      }
    } else {
      return_data["st"] = "error";

      return_data["msg"] = "Please Try Again";
    }
    return return_data;
  }

  addToCart(context, pcsId) async {
    dynamic returnData;

    Utils().loading(context);

    try {
      var mainData = {};
      var data = {};
      data = {};
      data['uid'] = await AppStorage.getData("uid") ?? "0";
      data['pcsid'] = pcsId;
      mainData["data"] = data;
      print(data);
      var res = await ApiData().postData('ApiService.asmx/AddToCart', mainData);
      print(res);
      if (res['st'] == 'success') {
        Utils().successSnack(context, res["msg"]);
      } else {
        Utils().errorSnack(context, res["msg"]);
      }
    } catch (e) {
      print('print error: $e');
      Utils().errorSnack(context, "Internal Cache Error");
    }
    Navigator.pop(context);
  }

  addToWatchList(context, pcsId) async {
    dynamic returnData;

    Utils().loading(context);

    try {
      var mainData = {};
      var data = {};
      data = {};
      data['uid'] = await AppStorage.getData("uid") ?? "0";
      data['pcsid'] = pcsId;
      mainData["data"] = data;
      print(data);
      var res = await ApiData().postData('ApiService.asmx/AddToWish', mainData);
      print(res);
      if (res['st'] == 'success') {
        Utils().successSnack(context, res["msg"]);
      } else {
        Utils().errorSnack(context, res["msg"]);
      }
    } catch (e) {
      print('print error: $e');
      Utils().errorSnack(context, "Internal Cache Error");
    }
    Navigator.pop(context);
  }

  confirmOrder(context, pcsId) async {
    dynamic returnData;

    Utils().loading(context);

    try {
      var mainData = {};
      var data = {};
      data = {};
      data['uid'] = await AppStorage.getData("uid") ?? "0";
      data['pcsid'] = pcsId;
      mainData["data"] = data;
      print(data);
      var res =
          await ApiData().postData('ApiService.asmx/ConfirmOrder', mainData);
      print(res);
      if (res['st'] == 'success') {
        Utils().successSnack(context, res["msg"]);
      } else {
        Utils().errorSnack(context, res["msg"]);
      }
    } catch (e) {
      print('print error: $e');
      Utils().errorSnack(context, "Internal Cache Error");
    }
    Navigator.pop(context);
  }

  dynamic get_post_data(String method, dynamic data) async {
    var data = {};
    data["aaid"] = await AppStorage.getData('aaid') ?? "";
    var return_data = {};
    try {
      final response = await CallApi().getPostData(method, data);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Message'].toString() == "Success") {
          return_data = result;
          return_data['st'] = "success";
          return_data['msg'] = result['Message'];
        } else {
          return_data['st'] = "fail";
          return_data['msg'] = result['Message'].toString();
        }
      } else {
        var result = jsonDecode(response.body);
        return_data['st'] = "fail";
        return_data['msg'] = result['Message'];
      }
    } catch (e) {
      print("Catch error : $e");
      return_data['st'] = "fail";
      return_data['msg'] = "Something went wrong!";
    }
    return return_data;
  }

  dynamic postData(String method, dynamic data) async {
    var data2 = {};
    print(data2);

    data["aaid"] = await AppStorage.getData('aaid') ?? "";
    var returnData = {};
    try {
      final response = await CallApi().postData(data, method);
      print('asdasdasdasdasdasdasdasdasdas');
      print(response);
      var result = json.decode(response.body);
      print(result);
      if (response.statusCode == 200) {
        if (result['st'] == "success") {
          returnData = result;
          returnData['st'] = "success";
          returnData['msg'] = result['msg'];
        } else {
          returnData['st'] = "fail";
          returnData['msg'] = result['msg'].toString();
        }
      } else {
        returnData["st"] = "fail";
        returnData["msg"] = result['msg'];
      }
    } catch (e) {
      print("api error $e");
      returnData['st'] = "fail";
      returnData['msg'] = "Internal cache error!";
    }
    return returnData;
  }

  dynamic get_data(String method, dynamic data) async {
    var data = {};
    data["aaid"] = await AppStorage.getData('aaid') ?? "";
    var return_data = {};

    try {
      final response = await CallApi().getData(method, data);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print(result);
        if (result['Message'].toString() == "Success") {
          return_data = result;
          return_data['st'] = "success";
          return_data['msg'] = result['Message'];
        } else {
          return_data['st'] = "fail";
          return_data['msg'] = result['Message'].toString();
        }
      } else {
        var result = jsonDecode(response.body);

        return_data['st'] = "fail";
        return_data['msg'] = result['Message'].toString();
      }
    } catch (e) {
      print("Api catch : $e");
      return_data['st'] = "fail";
      return_data['msg'] = "Something went wrong!";
    }
    return return_data;
  }

  dynamic get_login_data(String method, dynamic data) async {
    var data = {};
    data["aaid"] = await AppStorage.getData('aaid') ?? "";
    var return_data = {};

    final response = await CallApi().getDataLogin(method, data);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      print(result);
      if (result['UserId'] == "0" || result['UserId'] == 0) {
        return_data['st'] = "fail";
        return_data['msg'] = result['Message'].toString();
      } else {
        return_data = result;
        return_data['st'] = "success";
      }
    } else {
      var result = jsonDecode(response.body);
      return_data['st'] = "fail";
      return_data['msg'] = result['Message'].toString();
    }
    return return_data;
  }

  dynamic upload_data(dynamic data, String method, file) async {
    var data = {};
    data["aaid"] = await AppStorage.getData('aaid') ?? "";
    print('uploadDataasdasdadasasdasdas');
    print(data["aaid"]);
    var return_data = {};
    final response = await CallApi().uploadData(data, method);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      return_data = result;
      return_data['st'] = "success";
    } else {
      var result = jsonDecode(response.body);
      return_data['st'] = "fail";
      return_data['msg'] = result['Message'].toString();
    }
    return return_data;
  }
}
