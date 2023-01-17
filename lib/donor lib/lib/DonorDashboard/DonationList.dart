import 'package:cached_network_image/cached_network_image.dart';
import 'package:donor/DonorDashboard/MakeDonation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'DStudentDetail.dart';

class DonationList extends StatefulWidget {
  const DonationList({Key? key}) : super(key: key);

  @override
  State<DonationList> createState() => _DonationListState();
}

class _DonationListState extends State<DonationList> {
  List<DonationTransModel> uList = [];
  late Future transactionListPage;

  transaction() async {
    try {
      var data = {};

      var res = await ApiData().postData('my_donation_list', data);
      if (res['st'] == 'success') {
        if (!mounted) return;
        uList = DonationTransModelList(res['data'] ?? []);
      } else {
        if (!mounted) return;
        Utils().errorSnack(context, res["msg"]);
      }
    } catch (e) {
      print('print error: $e');
      Utils().errorSnack(context, "Internal Catch Error");
    }
    return uList;
  }

  @override
  void initState() {
    transactionListPage = transaction();
    super.initState();
  }

  transactionCard(DonationTransModel uData, index) {
    var date = DateTime.parse('${uData.tdate.toString()}');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      uData.credit.toString(),
                      style: FontStyle.textBold,
                    ),
                    Text(
                      DateFormat('dd-MM-yyyy').format(date),
                      style: FontStyle.dateGrey.copyWith(fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'View History',
        style: FontStyle.textLabelWhite,
      )),
      body: FutureBuilder(
          future: transactionListPage,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: CircularProgressIndicator(color: Colors.black),
              );
            } else {
              if (uList.isNotEmpty) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: uList.length,
                    itemBuilder: (context, index) {
                      return transactionCard(uList[index], index);
                    },
                  ),
                );
              } else {
                return Utils().noItem('No History Found');
              }
            }
          }),
    );
  }
}
