import 'dart:convert';

User itemFromJson(String str) => User.fromJson(json.decode(str));

String itemToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.plain,
    this.detail,
    this.design,
    this.qty,
    this.image,
  });

  int? plain;
  int? detail;
  int? design;
  int? qty;
  String? image;

  factory User.fromJson(Map<String, dynamic> json) => User(
        plain: json["page"] ?? "",
        detail: json["per_page"] ?? "",
        design: json["total"] ?? "",
        qty: json["qty"] ?? "",
        image: json["image"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "page": plain ?? "",
        "detail": detail ?? "",
        "total": design ?? "",
        "qty": qty ?? "",
        "image": image ?? "",
      };
}
