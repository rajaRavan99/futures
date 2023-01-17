// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

List<RaisedFundingModel> RaisedFundingModelFromJson(String str) =>
    List<RaisedFundingModel>.from(
        json.decode(str).map((x) => RaisedFundingModel.fromJson(x)));

List<RaisedFundingModel> RaisedFundingModelList(List<dynamic> data) =>
    List<RaisedFundingModel>.from(
        data.map((x) => RaisedFundingModel.fromJson(x)));

String RaisedFundingModelListToJson(List<RaisedFundingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Map<String, dynamic> RaisedFundingModelToJson(RaisedFundingModel data) =>
    data.toJson();

class RaisedFundingModel {
  String? id;
  String? uid;
  String? student_name;
  String? demand_amt;
  String? approved_amt;
  String? pay_amt;
  String? course_year;
  String? course_month;
  String? other_detail;
  String? remark;
  String? status;

  RaisedFundingModel({
    this.id,
    this.uid,
    this.student_name,
    this.demand_amt,
    this.approved_amt,
    this.pay_amt,
    this.course_year,
    this.course_month,
    this.other_detail,
    this.remark,
    this.status,
  });

  factory RaisedFundingModel.fromJson(Map<String, dynamic> json) {
    return RaisedFundingModel(
      id: json['id'],
      uid: json['uid'],
      student_name: json['student_name'],
      demand_amt: json['demand_amt'],
      approved_amt: json['approved_amt'],
      pay_amt: json['pay_amt'],
      course_year: json['course_year'],
      course_month: json['course_month'],
      other_detail: json['other_detail'],
      remark: json['remark'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'uid': uid,
        'student_name': student_name,
        'demand_amt': demand_amt,
        'approved_amt': approved_amt,
        'pay_amt': pay_amt,
        'course_year': course_year,
        'course_month': course_month,
        'other_detail': other_detail,
        'remark': remark,
        'status': status,
      };
}
