// To parse this JSON data, do
//
//     final item = itemFromJson(jsonString);

import 'dart:convert';

Item itemFromJson(String str) => Item.fromJson(json.decode(str));

String itemToJson(Item data) => json.encode(data.toJson());

class Item {
  Item({
    this.page,
    this.perPage,
    this.total,
    this.totalPages,
    this.data,
    this.support,
  });

  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<Datum>? data;
  Support? support;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        page: json["page"] ?? null,
        perPage: json["per_page"] ?? null,
        total: json["total"] ?? null,
        totalPages: json["total_pages"] ?? null,
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        support:
            json["support"] == null ? null : Support.fromJson(json["support"]),
      );

  Map<String, dynamic> toJson() => {
        "page": page ?? null,
        "per_page": perPage ?? null,
        "total": total ?? null,
        "total_pages": totalPages ?? null,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "support": support == null ? null : support!.toJson(),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ?? null,
        email: json["email"] ?? null,
        firstName: json["first_name"] ?? null,
        lastName: json["last_name"] ?? null,
        avatar: json["avatar"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? null,
        "email": email ?? null,
        "first_name": firstName ?? null,
        "last_name": lastName ?? null,
        "avatar": avatar ?? null,
      };
}

class Support {
  Support({
    this.url,
    this.text,
  });

  String? url;
  String? text;

  factory Support.fromJson(Map<String, dynamic> json) => Support(
        url: json["url"] ?? null,
        text: json["text"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "url": url ?? null,
        "text": text ?? null,
      };
}
