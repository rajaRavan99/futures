import 'dart:convert';

import 'ImageModel.dart';

List<UserModel> UserModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

List<UserModel> UserModelList(List<dynamic> data) =>
    List<UserModel>.from(data.map((x) => UserModel.fromJson(x)));

String UserModelListToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Map<dynamic, dynamic> UserModelToJson(UserModel data) => data.toJson();

class UserModel {
  String? uid;
  String? utype;
  String? uname;
  String? fname;
  String? lname;
  String? uemail;
  String? umobile;
  ImageModel? uphoto;

  UserModel({
    this.uid,
    this.utype,
    this.uname,
    this.fname,
    this.lname,
    this.uemail,
    this.umobile,
    this.uphoto,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: (json["uid"] ?? "").toString(),
        utype: (json["utype"] ?? "").toString(),
        uname: (json["uname"] ?? "").toString(),
        fname: (json["fname"] ?? "").toString(),
        lname: (json["lname"] ?? "").toString(),
        uemail: (json["uemail"] ?? "").toString(),
        umobile: (json["umobile"] ?? "").toString(),
        uphoto: (json["uphoto"] == null
            ? ImageModel()
            : ImageModel.fromJson(json["uphoto"])),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "utype": utype,
        "fname": fname,
        "lname": lname,
        "uemail": uemail,
        "umobile": umobile,
        "uphoto": uphoto,
      };
}
