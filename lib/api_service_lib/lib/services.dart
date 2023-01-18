import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class services {
  // late final String email, password;
//Get call Function and  with paramter both :-
  static var client = http.Client();

  static Future<dynamic> getCall(
    Uri url,
    bool isHeader,
    Map<String, String> headerData,
  ) async {
    try {
      final response = isHeader
          ? await http.get(url, headers: headerData)
          : await http.get(url);
      print(response.body);
      // return response;
    } on HttpException catch (error) {
      print(error);
    } catch (error) {
      print(error);
    }
    //Get call Function and  with paramter both :-
  }

//post call Function and  with paramter both :-
  static Future<void> postcall(
    Uri url,
    bool isHeader,
    Map<String, String> headerdata,
    Map<String, dynamic> bodydata,

    // Map<String, String> headerData,
  ) async {
    try {
      final response = isHeader
          ? await http.post(url, headers: headerdata, body: bodydata)
          : await http.post(url);

      // ignore: avoid_print
      print(response.body);
    } on HttpException catch (error) {
      print(error);
    } catch (done) {
      print(done);
    }
  }
//post call Function and  with paramter both :-

  // ignore: non_constant_identifier_names
  static Future<dynamic> MultipartFile(
      Uri uri,
      // bool isheader,
      // // Map<String, dynamic> header,
      // Map<String, String> bodydata,
      String image) async {
    var request = http.MultipartRequest(
      "POST",
      uri,
    );
    request.fields["firstname"] = 'Arvind';
    request.fields["lastname"] = 'Gondaliya';
    request.fields["email"] = 'arvind.gondaliya@aipxperts.com';
    request.fields["contact_number"] = '84QcmEC4ebpLbqfqdmMoYg==';
    request.fields["country_id"] = '101';
    request.fields["city_id"] = '57606';
    request.fields["password"] = 'aipX@1234';
    request.fields["facebook_id"] = '';
    request.fields["google_id"] = '';
    request.fields["apple_id"] = '';
    request.fields["login_type"] = 'normal';
    request.fields["dialing_code"] = '+91';
    request.fields["device_name"] = 'android';

    var multipartFile = await http.MultipartFile.fromPath(
      'avatar',
      image,
    );
    request.files.add(multipartFile);
    var response = await request.send();
    var responsed = await http.Response.fromStream(response);
    final responseData = json.decode(responsed.body);
    print(response.statusCode);
  }
}
