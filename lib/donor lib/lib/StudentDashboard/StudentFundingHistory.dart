import 'package:donor/Library/AppColors.dart';
import 'package:donor/Library/TextStyle.dart';
import 'package:flutter/material.dart';

import '../Library/ApiData.dart';
import '../Library/ManageStorage.dart';
import '../Library/Utils.dart';
import '../model/RaisedFundingModel.dart';

class StudentFundingHistory extends StatefulWidget {
  const StudentFundingHistory({Key? key}) : super(key: key);

  @override
  State<StudentFundingHistory> createState() => _StudentFundingHistoryState();
}

class _StudentFundingHistoryState extends State<StudentFundingHistory> {
  List<RaisedFundingModel> rList = [];
  late Future fetchRaisedFund;

  getRaisedFund() async {
    /*try {
      var data = {};
      data['aaid'] = await AppStorage.getData('aaid') ?? "";

      var res = await ApiData().postData('donation_raise_list', data);
      if (res['st'] == 'success') {
        if (!mounted) return;
        rList = RaisedFundingModelList(res['data'] ?? []);
      } else {
        if (!mounted) return;
        Utils().errorSnack(context, res["msg"]);
      }
    } catch (e) {
      print('print error: $e');
      Utils().errorSnack(context, "Internal Server Error");
    }*/
    return rList;
  }

  @override
  void initState() {
    fetchRaisedFund = getRaisedFund();
    super.initState();
  }

  fundCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
      child: SizedBox(
        // height: 80,
        child: Stack(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(width: 1.5, color: AppColors.grey_09),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/image/person.png',
                          width: 70,
                          height: 70,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mark Zukerbuck',
                              style: FontStyle.textHint.copyWith(
                                  fontSize: 15, color: AppColors.black),
                            ),
                            Text(
                              'Funded by 21-11-2022',
                              style: FontStyle.textHint.copyWith(
                                  fontSize: 12, color: AppColors.grey_90),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Funding History', style: FontStyle.textLabelWhite),
      ),
      body: FutureBuilder(
        future: fetchRaisedFund,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (rList.isNotEmpty) {
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: 10,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return fundCard();
                },
              );
            } else {
              return Utils().noItem('No Data Found');
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          }
        },
      ),
    );
  }
}
