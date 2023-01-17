// To parse this JSON data, do
//
//     final SearchModel = SearchModelFromJson(jsonString);

import 'dart:convert';

// ignore: non_constant_identifier_names
List<SearchModel> SearchModelFromJson(String str) => List<SearchModel>.from(
    json.decode(str).map((x) => SearchModel.fromJson(x)));

// ignore: non_constant_identifier_names
List<SearchModel> SearchModelList(List<dynamic> data) =>
    List<SearchModel>.from(data.map((x) => SearchModel.fromJson(x)));

// ignore: non_constant_identifier_names
String SearchModelListToJson(List<SearchModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// ignore: non_constant_identifier_names
Map<String, dynamic> SearchModelToJson(SearchModel data) => data.toJson();

class SearchModel {
  SearchModel({
    this.id,
    this.shape,
    this.clarity,
    this.color,
    this.fromcts,
    this.tocts,
    this.price,
  });

  String? id;
  Shape? shape;
  Clarity? clarity;
  Color? color;
  String? fromcts;
  String? tocts;
  String? price;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        id: json["ID"],
        shape: shapeValues.map![json["Shape"]],
        clarity: clarityValues.map![json["Clarity"]],
        color: colorValues.map![json["Color"]],
        fromcts: json["Fromcts"],
        tocts: json["Tocts"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Shape": shapeValues.reverse[shape],
        "Clarity": clarityValues.reverse[clarity],
        "Color": colorValues.reverse[color],
        "Fromcts": fromcts,
        "Tocts": tocts,
        "price": price,
      };
}

enum Clarity { IF, VVS1, VVS2, VS1, VS2, SI1, SI2, SI3, I1, I2, I3 }

final clarityValues = EnumValues({
  "I1": Clarity.I1,
  "I2": Clarity.I2,
  "I3": Clarity.I3,
  "IF": Clarity.IF,
  "SI1": Clarity.SI1,
  "SI2": Clarity.SI2,
  "SI3": Clarity.SI3,
  "VS1": Clarity.VS1,
  "VS2": Clarity.VS2,
  "VVS1": Clarity.VVS1,
  "VVS2": Clarity.VVS2
});

enum Color { D, E, F, G, H, I, J, K, L, M, N }

final colorValues = EnumValues({
  "D": Color.D,
  "E": Color.E,
  "F": Color.F,
  "G": Color.G,
  "H": Color.H,
  "I": Color.I,
  "J": Color.J,
  "K": Color.K,
  "L": Color.L,
  "M": Color.M,
  "N": Color.N
});

enum Shape { RD, FNY }

final shapeValues = EnumValues({"FNY": Shape.FNY, "RD": Shape.RD});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
