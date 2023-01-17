import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'Imagemodel.dart';

List<UserModel> UserModelListFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

List<UserModel> UserModelList(List<dynamic> data) =>
    List<UserModel>.from(data.map((x) => UserModel.fromJson(x)));

String UserModelListToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Map<String, dynamic> UserModelToJson(UserModel data) => data.toJson();

class UserModel {
  String? uname;
  String? umobile;
  String? uemail;
  ImageModel? uphoto;
  String? uaddress;
  String? ucity;
  String? ustate;

  UserModel({
    this.uname,
    this.umobile,
    this.uemail,
    this.uphoto,
    this.uaddress,
    this.ucity,
    this.ustate,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uname: json['uname'].toString(),
      umobile: json['umobile'].toString(),
      uemail: json['uemail'].toString(),
      uphoto: json['uphoto'] == null
          ? ImageModel()
          : ImageModel.fromJson(json['uphoto']),
      uaddress: json['uaddress'].toString(),
      ucity: json['ucity'].toString(),
      ustate: json['ustate'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'uname': uname,
        'umobile': umobile,
        'uemail': uemail,
        'uphoto': uphoto,
        'uaddress': uaddress,
        'ucity': ucity,
        'ustate': ustate,
      };
}
