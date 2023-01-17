import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'AppStorage.dart';

class CallApi {
  static const String _url = 'https://status.cfsys.xyz/';

  void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    print(fullUrl);
    printWrapped(jsonEncode(data));
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  uploadData(data, apiUrl, filename) async {
    var fullUrl = _url + apiUrl;
    var request = http.MultipartRequest('POST', Uri.parse(fullUrl));

    request.fields['aaid'] = data['aaid'];
    request.fields['module'] = data['module'];
    request.files.add(await http.MultipartFile.fromPath('file', filename));

    var res = await http.Response.fromStream(await request.send());
    ApiData().pdata(res.body);

    return res;
  }

  uploadMultiData(data, apiUrl, filename) async {
    var fullUrl = _url + apiUrl;
    //print(fullUrl);
    //print(jsonEncode(data));
    var request = http.MultipartRequest('POST', Uri.parse(fullUrl));

    request.fields['aaid'] = data['aaid'] ?? "123";
    request.fields['module'] = data['module'];
    for (int i = 0; i < filename.length; i++) {
      //List<int> imageData = (await File(filename[i]).readAsBytesSync()).buffer.asUint8List();
      List<int> imgdata = [];
      imgdata.addAll(filename[i]);

      request.files.add(await http.MultipartFile.fromBytes(
        'files[]',
        imgdata,
        filename: DateTime.now().millisecondsSinceEpoch.toString() + ".jpg",
      ));
    }

    var res = await http.Response.fromStream(await request.send());
    //   print(res.body);

    return res;
  }

  getData(apiUrl, data) async {
    var fullUrl = _url + apiUrl; // await _getToken();
    return await http.get(Uri.parse(fullUrl), headers: _setHeaders());
  }

  _setHeaders() => {
        // 'Authorization' : '4ccda7514adc0f13595a585205fb9761',
        'Content-type': 'application/json',
        //'Accept' : 'application/json',
      };

  _setHeaders2() => {
        // 'Authorization' : '4ccda7514adc0f13595a585205fb9761',
        'Content-type': 'application/x-www-form-urlencoded; charset=UTF-8',
        //'Accept' : 'application/json',
      };
}

class ApiData {
  pdata(dynamic data) {
    if (kDebugMode) {
      print(data);
    }
  }

  dynamic get_access_code() async {
    // final User? user = auth.currentUser;
    // final device_id = await FirebaseInstallations.instance.getId();

    var data = {};
    // var device_data = await Callcfs().initPlatformState();
    // data["umobile"] = user!.phoneNumber;
    // data["gid"] = user.uid;
    data["acode"] = "1";
    data["gtoken"] = "1";
    // data["device_id"] = device_id;
    // data["device_name"] = device_data["device"];
    data["device_detail"] = "1";
    // data["device_ip"] = device_data["device_id"];
    var return_data = {};
    final response = await CallApi().postData(data, 'get_access_code');
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result['st'] == 'success') {
        print(result);
        print(result["adata"]["atoken"]);
        AppStorage.setData('aaid', result["adata"]["atoken"].toString());
        AppStorage.setData('utype', result["adata"]["utype"].toString());
        AppStorage.setData('is_verify', result["adata"]["is_verify"].toString());
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

  dynamic send_data(dynamic user, String method) async {
    var data = {};
    data = user;

    data["aaid"] = await AppStorage.getData('aaid') ?? '';
    var return_data = {};
    final response = await CallApi().postData(data, method);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result['st'] == 'success') {
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

  dynamic postData(String method, dynamic data) async {
    data["aaid"] = await AppStorage.getData('aaid') ?? "";
    print(await AppStorage.getData('aaid'));
    var return_data = {};
    final response = await CallApi().postData(data, method);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result['st'] == 'success') {
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

  dynamic upload_data(dynamic user, String method, String? filename) async {
    var data = {};
    data = user;

    data["aaid"] =
        await AppStorage.getData('aaid') ?? 'cc9623cc2c8f613bca35be526333aa5e';
    var return_data = {};
    final response = await CallApi().uploadData(data, method, filename);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      if (result['st'] == 'success') {
        return_data = result;
      } else {
        return_data["st"] = result['st'];
        return_data["msg"] = result['msg'];
      }
    } else {
      return_data["st"] = "error";
      return_data["msg"] = "Something Went Wrong ! Please try again later";
    }
    return return_data;
  }

  dynamic upload_multi_data(
      dynamic user, String method, List<dynamic> filename) async {
    var data = {};
    // print(method);
    data = user;

    data["aaid"] = await AppStorage.getData('aaid');
    var return_data = {};
    final response = await CallApi().uploadMultiData(data, method, filename);
    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);

      if (result['st'] == 'success') {
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
}

class CommonList {
  final List<Map<String, String>> type_list = [
    {'id': "N", 'value': 'Plain'},
    {'id': "RF", 'value': 'RF'},
    {'id': "R", 'value': 'Repeat'},
  ];

  String? get_value_byid(List<Map<String, String>> data, String id) =>
      ((data.where((element) => element['id'] == id).first)['value'])
          .toString();
}
