// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

List<DocModel> DocModelFromJson(String str) =>
    List<DocModel>.from(json.decode(str).map((x) => DocModel.fromJson(x)));

List<DocModel> DocModelList(List<dynamic> data) =>
    List<DocModel>.from(data.map((x) => DocModel.fromJson(x)));

String DocModelListToJson(List<DocModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Map<String, dynamic> DocModelToJson(DocModel data) => data.toJson();

class DocModel {
  String? doc_type;
  String? doc_name;
  bool? is_require;
  String? h_path;
  String? doc_path;
  String? show_path;

  DocModel({
    this.doc_type,
    this.doc_name,
    this.is_require,
    this.h_path,
    this.doc_path,
    this.show_path,
  });

  factory DocModel.fromJson(Map<String, dynamic> json) {
    return DocModel(
      doc_type: (json['doc_type'] ?? "").toString(),
      doc_name: (json['doc_name'] ?? "").toString(),
      is_require: json['is_require'],
      h_path: (json['h_path'] ?? "").toString(),
      doc_path: (json['doc_path'] ?? "").toString(),
      show_path: (json['h_path'] ?? "").toString() +
          (json['doc_path'] ?? "").toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'doc_type': doc_type,
        'doc_name': doc_name,
        'is_require': is_require,
        'h_path': h_path,
        'doc_path': doc_path,
      };
}
