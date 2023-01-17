import 'package:donor/Library/AppColors.dart';
import 'package:donor/Library/TextStyle.dart';
import 'package:donor/StudentDashboard/AddRaisedFund.dart';
import 'package:donor/model/RaisedFundingModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../Library/ApiData.dart';
import '../Library/ManageStorage.dart';
import '../Library/Utils.dart';

class AFundRequestList extends StatefulWidget {
  const AFundRequestList({Key? key}) : super(key: key);

  @override
  State<AFundRequestList> createState() => _AFundRequestListState();
}

class _AFundRequestListState extends State<AFundRequestList> {
  List<RaisedFundingModel> rList = [];
  late Future fetchRaisedFund;
  final _formKey = GlobalKey<FormState>();

  TextEditingController remarkController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  getRaisedList() async {
    try {
      var data = {};
      data['status'] = "0";

      var res = await ApiData().postData('admin_donation_request_list', data);
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

  @override
  void initState() {
    super.initState();
    fetchRaisedFund = getRaisedList();
  }

  taskApproveReject(id, status) async {
    try {
      var data = {};
      if (status.toString() == "1") {
        remarkController.clear();
      } else {
        amountController.clear();
      }
      data['id'] = id;
      data['status'] = status;
      data['remark'] = remarkController.text;
      data['approved_amt'] = amountController.text;
      var res = await ApiData().postData('update_request_status', data);
      print("------------------>$res");
      if (res['st'] == 'success') {
        fetchRaisedFund = getRaisedList();
        setState(() {});
        Utils().successSnack(
            context,
            status.toString() == "2"
                ? "Rejected Successfully"
                : "Approved Successfully");
      } else {
        //Navigator.pop(context);
        Utils().errorSnack(context, res["msg"]);
      }
    } catch (e) {
      print('print error: $e');
      Utils().errorSnack(context, "Catch Error!");
    }
    remarkController.clear();
  }

  remarkPop(BuildContext context, uniqueId) async {
    return (await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width - 200,
            child: AlertDialog(
              insetPadding: const EdgeInsets.all(60.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              title: const Text(
                "Remark",
                style: FontStyle.buttonBoldBlack,
              ),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: remarkController,
                    textInputAction: TextInputAction.next,
                    style: FontStyle.textInput,
                    cursorColor: AppColors.black,
                    maxLines: 5,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: Utils().inputDecoration('Enter Remark'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Remark";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.text,
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 42,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0),
                            )),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              AppColors.red_00,
                            ),
                          ),
                          onPressed: () async {
                            taskApproveReject(uniqueId, "2");
                            Navigator.pop(context);
                          },
                          child:
                              Text("Reject", style: FontStyle.buttonBoldWhite),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Cancel",
                              style: FontStyle.textHeaderBold
                                  .copyWith(color: AppColors.red_00))),
                    ],
                  ),
                ],
              ),
            ),
          );
        }));
  }

  approvePop(BuildContext context, RaisedFundingModel dData, index) async {
    return (await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width - 200,
            child: AlertDialog(
              insetPadding: const EdgeInsets.all(60.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Amount : ',
                          style: FontStyle.textCardTitle,
                        ),
                        Expanded(
                          child: Text(
                            dData.demand_amt.toString(),
                            style: FontStyle.textCardValue,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Course Duration : ',
                          style: FontStyle.textCardTitle,
                        ),
                        Expanded(
                          child: Text(
                            '${dData.course_year.toString()} Year ${dData.course_month.toString()} Month',
                            style: FontStyle.textCardValue,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Other Detail : ',
                          style: FontStyle.textCardTitle,
                        ),
                        Text(
                          dData.other_detail.toString(),
                          style: FontStyle.textCardValue,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: amountController,
                      textInputAction: TextInputAction.next,
                      style: FontStyle.textInput,
                      cursorColor: AppColors.black,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: Utils().inputDecoration('Enter Remark'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Remark";
                        } else if (double.parse(value) < 1) {
                          return "Amount must be more than 0";
                        } else if (double.parse(value) >
                            double.parse(dData.demand_amt.toString())) {
                          return "Amount is more than asking amount";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.text,
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 42,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0),
                              )),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.primaryColor,
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                taskApproveReject(dData.id, "1");
                                Navigator.pop(context);
                              }
                            },
                            child: Text("Approve",
                                style: FontStyle.buttonBoldWhite),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("Cancel",
                                style: FontStyle.textHeaderBold
                                    .copyWith(color: AppColors.primaryColor))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                        dData.demand_amt.toString(),
                        style: FontStyle.textCardValue,
                      ),
                    ],
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          approvePop(context, dData, index);
                          amountController.text =
                              double.parse(dData.demand_amt.toString())
                                  .round()
                                  .toString();
                        },
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
                      const SizedBox(
                        width: 5,
                      ),
                      InkWell(
                        onTap: () {
                          remarkPop(context, dData.id);
                        },
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
