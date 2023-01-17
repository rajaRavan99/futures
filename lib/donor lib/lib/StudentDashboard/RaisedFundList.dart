import 'package:donor/Library/AppColors.dart';
import 'package:donor/Library/TextStyle.dart';
import 'package:donor/StudentDashboard/AddRaisedFund.dart';
import 'package:donor/model/RaisedFundingModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../Library/ApiData.dart';
import '../Library/Utils.dart';

class RaisedFundList extends StatefulWidget {
  const RaisedFundList({Key? key}) : super(key: key);

  @override
  State<RaisedFundList> createState() => _RaisedFundListState();
}

class _RaisedFundListState extends State<RaisedFundList> {
  List<RaisedFundingModel> rList = [];
  late Future fetchRaisedFund;

  getRaisedList() async {
    try {
      var data = {};
      data['status'] = "";
      var res = await ApiData().postData('donation_raise_list', data);
      print(res);
      if (res['st'] == 'success') {
        if (!mounted) return;
        rList = RaisedFundingModelList(res['data'] ?? []);
      } else {
        if (!mounted) return;
        Utils().errorSnack(context, res["msg"]);
      }
    } catch (e) {
      print('print error: $e');
      Utils().errorSnack(context, "Internal Catch Error");
    }
    return rList;
  }

  deleteRaised(aId) async {
    Utils().loading(context);
    try {
      var data = {};
      data = {};
      data['id'] = aId;
      var res = await ApiData().postData('delete_donation_raise', data);
      if (res['st'] == 'success') {
        if (!mounted) return;
        fetchRaisedFund = getRaisedList();
        Utils().successSnack(context, res["msg"]);
      } else {
        if (!mounted) return;
        Utils().errorSnack(context, res["msg"]);
      }
    } catch (e) {
      print('print error: $e');
      Utils().errorSnack(context, "Failed");
    }
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    fetchRaisedFund = getRaisedList();
  }

  fundCard(RaisedFundingModel dData, index) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 2,
            child: Stack(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Amount : ',
                            style: FontStyle.textCardTitle,
                          ),
                          Text(
                            double.parse(dData.demand_amt.toString())
                                .round()
                                .toString(),
                            style: FontStyle.textCardValue,
                          ),
                        ],
                      ),
                      Visibility(
                        visible: double.parse(
                                (dData.approved_amt ?? "0").toString()) >
                            0,
                        child: Row(
                          children: [
                            const Text(
                              'Approved Amount : ',
                              style: FontStyle.textCardTitle,
                            ),
                            Text(
                              double.parse(dData.approved_amt.toString())
                                  .round()
                                  .toString(),
                              style: FontStyle.textCardValue,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            'Course Duration : ',
                            style: FontStyle.textCardTitle,
                          ),
                          Text(
                            '${dData.course_year.toString()} Year ${dData.course_month.toString()} Month',
                            style: FontStyle.textCardValue,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text(
                            'Other Detail : ',
                            style: FontStyle.textCardTitle,
                          ),
                          Text(
                            dData.other_detail.toString(),
                            style: FontStyle.textCardValue,
                          ),
                        ],
                      ),
                      Visibility(
                        visible: (dData.remark ?? "").toString() != "",
                        child: Row(
                          children: [
                            const Text(
                              'Remark : ',
                              style: FontStyle.textCardTitle,
                            ),
                            Text(
                              dData.remark.toString(),
                              style: FontStyle.textCardValue,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Visibility(
                            visible: true,
                            child: Visibility(
                              visible: dData.status.toString() == "1",
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: AppColors.green_09,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 4.0, horizontal: 10.0),
                                  child: Text(
                                    "Approved",
                                    style: FontStyle.statusTextGreen,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: dData.status.toString() == "0",
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: AppColors.yellow_09,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 10.0),
                                child: Text(
                                  "Pending",
                                  style: FontStyle.statusTextYellow,
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: dData.status.toString() == "2",
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: AppColors.red_09,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 10.0),
                                child: Text(
                                  "Rejected",
                                  style: FontStyle.statusTextRed,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: dData.status.toString() == "0",
                  child: Positioned(
                    top: 0,
                    right: 0,
                    child: PopupMenuButton(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                        ),
                        iconSize: 20,
                        icon: const Icon(
                          Icons.more_vert,
                          color: AppColors.black,
                        ),
                        itemBuilder: (context) {
                          return [
                            const PopupMenuItem(
                              value: "edit",
                              child: Text(
                                "Edit",
                                style: FontStyle.primarySmallBlack,
                              ),
                            ),
                            const PopupMenuItem(
                              value: "delete",
                              child: Text(
                                "Delete",
                                style: FontStyle.primarySmallBlack,
                              ),
                            ),
                          ];
                        },
                        onSelected: (value) {
                          if (value == "edit") {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddRaisedFund(
                                  raisedModel: dData,
                                  dId: dData.id,
                                ),
                              ),
                            );
                          }
                          if (value == 'delete') {
                            Utils().deletePop(context, () {
                              deleteRaised(dData.id);
                              fetchRaisedFund = getRaisedList();
                              setState(() {});
                            }, 'Are your sure you want to delete this fund request',
                                true);
                          }
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
            visible: rList.length - 1 == index,
            child: const SizedBox(
              height: 80,
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddRaisedFund()));
        },
        child: Utils().primaryIconButton(Icons.add, 'Add Fund Request',
            MediaQuery.of(context).size.width * 0.7),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      appBar: AppBar(
        title: const Text(
          'Fund Requests',
          style: FontStyle.appBarText,
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
            future: fetchRaisedFund,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: SpinKitThreeBounce(
                    size: 30,
                    color: AppColors.primaryColor,
                  ),
                );
              } else {
                if (rList.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: rList.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return fundCard(rList[index], index);
                    },
                  );
                } else {
                  return Utils().noItem('No Data Found');
                }
              }
            }),
      ),
    );
  }
}
