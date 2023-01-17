import 'dart:convert';

List<ActivityModel> ActivityModelFromJson(String str) =>
    List<ActivityModel>.from(
        json.decode(str).map((x) => ActivityModel.fromJson(x)));

List<ActivityModel> ActivityModelList(List<dynamic> data) =>
    List<ActivityModel>.from(data.map((x) => ActivityModel.fromJson(x)));

String ActivityModelListToJson(List<ActivityModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Map<String, dynamic> ActivityModelToJson(ActivityModel data) => data.toJson();

class ActivityModel {
  String? aid;
  String? atitle;
  String? adetail;

  ActivityModel({
    this.aid,
    this.atitle,
    this.adetail,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      aid: json['aid'],
      atitle: json['atitle'],
      adetail: json['adetail'],
    );
  }

  Map<String, dynamic> toJson() => {
        'aid': aid,
        'atitle': atitle,
        'adetail': adetail,
      };
}
