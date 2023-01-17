import 'dart:convert';

List<NewSearchModel> NewSearchModelFromJson(String str) =>
    List<NewSearchModel>.from(json.decode(str).map((x) => NewSearchModel.fromJson(x)));

List<NewSearchModel> NewSearchModelList(List<dynamic> data) => List<NewSearchModel>.from(data.map((x) => NewSearchModel.fromJson(x)));

String NewSearchModelListToJson(List<NewSearchModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Map<String, dynamic> NewSearchModelToJson(NewSearchModel data) => data.toJson();


class NewSearchModel {
  String? ID;
  String? Shape;
  String? Clarity;
  String? Color;
  String? Fromcts;
  String? Tocts;
  String? price;

  NewSearchModel({
    this.ID,
    this.Shape,
    this.Clarity,
    this.Color,
    this.Fromcts,
    this.Tocts,
    this.price,
  });

  factory NewSearchModel.fromJson(Map<String, dynamic> json) {
    return NewSearchModel(
      ID: (json['ID']??"").toString(),
      Shape: (json['Shape']??"").toString(),
      Clarity: (json['Clarity']??"").toString(),
      Color: (json['Color']??"").toString(),
      Fromcts: (json['Fromcts']??"").toString(),
      Tocts: (json['Tocts']??"").toString(),
      price: (json['price']??"").toString(),
    );
  }

  Map<String, dynamic> toJson() => {
    'ID': ID,
    'Shape': Shape,
    'Clarity': Clarity,
    'Color': Color,
    'Fromcts': Fromcts,
    'Tocts': Tocts,
    'price': price,
  };
}
