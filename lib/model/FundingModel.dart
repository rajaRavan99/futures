import 'dart:convert';

List<FundingModel> FundingModelFromJson(String str) =>
    List<FundingModel>.from(json.decode(str).map((x) => FundingModel.fromJson(x)));

List<FundingModel> FundingModelList(List<dynamic> data ) =>
    List<FundingModel>.from(data.map((x) => FundingModel.fromJson(x)));

String FundingModelListToJson(List<FundingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Map<String,dynamic> FundingModelToJson(FundingModel data) => data.toJson();



class FundingModel{
  String? sImg;
  String? sName;
  String? sFund;
  String? date;


  FundingModel({
    this.sImg,
    this.sName,
    this.sFund,
    this.date,
  });

  factory FundingModel.fromJson(Map<String, dynamic> json) {
    return FundingModel(
      sImg: json['sImg'],
      sName: json['sName'],
      sFund: json['sFund'],
      date: json['date'],
    );}

  Map<String,dynamic> toJson() => {
    'sImg':sImg,
    'sName':sName,
    'sFund':sFund,
    'date':date,
  };

}