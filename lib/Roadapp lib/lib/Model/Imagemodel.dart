import 'dart:convert';

List<ImageModel> ImageModelListFromJson(String str) =>
    List<ImageModel>.from(json.decode(str).map((x) => ImageModel.fromJson(x)));

List<ImageModel> ImageModelList(List<dynamic> data) =>
    List<ImageModel>.from(data.map((x) => ImageModel.fromJson(x)));

String ImageModelListToJson(List<ImageModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ImageModel {
  String? iid;
  String? h_path;
  String? imgpath;
  String? showpath;

  ImageModel({
    this.iid,
    this.h_path,
    this.imgpath,
    this.showpath,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      iid: (json['iid'] ?? "").toString(),
      h_path: (json['h_path'] ?? "").toString(),
      imgpath: (json['imgpath'] ?? "").toString(),
      showpath: (json['h_path'] ?? "").toString() +
          (json['imgpath'] ?? "").toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'iid': iid,
        'h_path': h_path,
        'imgpath': imgpath,
      };
}
