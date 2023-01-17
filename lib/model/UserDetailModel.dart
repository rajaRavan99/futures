import 'dart:convert';

import 'DocModel.dart';
import 'ImageModel.dart';

List<UserDetailModel> UserDetailModelFromJson(String str) =>
    List<UserDetailModel>.from(
        json.decode(str).map((x) => UserDetailModel.fromJson(x)));

List<UserDetailModel> UserDetailModelList(List<dynamic> data) =>
    List<UserDetailModel>.from(data.map((x) => UserDetailModel.fromJson(x)));

String UserDetailModelListToJson(List<UserDetailModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Map<String, dynamic> UserDetailModelToJson(UserDetailModel data) =>
    data.toJson();

class UserDetailModel {
  String? id;
  String? uid;
  ImageModel? uphoto;
  String? uname;
  String? uemail;
  String? umobile;

  List<DocModel>? document;
  String? address;
  String? family_income;
  String? father_name;
  String? mother_name;
  String? legal_guardian;
  String? institute_name;
  String? current_course;
  String? admission_year;
  String? last_year;
  String? grade;
  List<DocModel>? edu_document;
  String? is_kys;

  UserDetailModel(
      {this.id,
      this.uid,
      this.uphoto,
      this.uname,
      this.uemail,
      this.umobile,
      this.document,
      this.address,
      this.family_income,
      this.father_name,
      this.mother_name,
      this.legal_guardian,
      this.institute_name,
      this.current_course,
      this.admission_year,
      this.last_year,
      this.grade,
      this.edu_document,
      this.is_kys});

  factory UserDetailModel.fromJson(Map<String, dynamic> json) {
    return UserDetailModel(
      id: (json['id'] ?? "").toString(),
      uid: (json['uid'] ?? "").toString(),
      uphoto: json['uphoto'] == null
          ? ImageModel()
          : ImageModel.fromJson(json['uphoto']),
      uname: (json['uname'] ?? "").toString(),
      uemail: (json['uemail'] ?? "").toString(),
      umobile: (json['umobile'] ?? "").toString(),
      document: json['document'] == null ? [] : DocModelList(json['document']),
      address: (json['address'] ?? "").toString(),
      family_income: (json['family_income'] ?? "").toString(),
      father_name: (json['father_name'] ?? "").toString(),
      mother_name: (json['mother_name'] ?? "").toString(),
      legal_guardian: (json['legal_guardian'] ?? "").toString(),
      institute_name: (json['institute_name'] ?? "").toString(),
      current_course: (json['current_course'] ?? "").toString(),
      admission_year: (json['admission_year'] ?? "").toString(),
      last_year: (json['last_year'] ?? "").toString(),
      grade: (json['grade'] ?? "").toString(),
      edu_document: json['edu_document'] == null
          ? []
          : DocModelList(json['edu_document']),
      is_kys: (json['is_kys'] ?? "").toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'uid': uid,
        'uphoto': uphoto,
        'uname': uname,
        'uemail': uemail,
        'umobile': umobile,
        'document': document,
        'address': address,
        'family_income': family_income,
        'father_name': father_name,
        'mother_name': mother_name,
        'legal_guardian': legal_guardian,
        'institute_name': institute_name,
        'current_course': current_course,
        'admission_year': admission_year,
        'last_year': last_year,
        'grade': grade,
        'edu_document': edu_document,
        'is_kys': is_kys,
      };
}
