import 'dart:convert';

List<DonationTransModel> DonationTransModelFromJson(String str) =>
    List<DonationTransModel>.from(
        json.decode(str).map((x) => DonationTransModel.fromJson(x)));

List<DonationTransModel> DonationTransModelList(List<dynamic> data) =>
    List<DonationTransModel>.from(data.map((x) => DonationTransModel.fromJson(x)));

String DonationTransModelListToJson(List<DonationTransModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

Map<String, dynamic> DonationTransModelToJson(DonationTransModel data) => data.toJson();

class DonationTransModel {
  String? tid;
  String? uid;
  String? ref_id;
  String? credit;
  String? debit;
  String? amount;
  String? tdate;

  DonationTransModel({
    this.tid,
    this.uid,
    this.ref_id,
    this.credit,
    this.debit,
    this.amount,
    this.tdate,
  });

  factory DonationTransModel.fromJson(Map<String, dynamic> json) {
    return DonationTransModel(
      tid: json['tid'],
      uid: json['uid'],
      ref_id: json['ref_id'],
      credit: json['credit'],
      debit: json['debit'],
      amount: json['amount'],
      tdate: json['tdate'],
    );
  }

  Map<String, dynamic> toJson() => {
        'tid': tid,
        'uid': uid,
        'ref_id': ref_id,
        'credit': credit,
        'debit': debit,
        'amount': amount,
        'tdate': tdate,
      };
}
