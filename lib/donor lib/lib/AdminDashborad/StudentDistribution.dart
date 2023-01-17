import 'package:donor/Library/TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import '../Library/ApiData.dart';
import '../Library/AppColors.dart';
import '../Library/Utils.dart';
import '../model/RaisedFundingModel.dart';

import 'SelectDonor.dart';

class StudentDistribution extends StatefulWidget {
  const StudentDistribution({Key? key}) : super(key: key);

  @override
  State<StudentDistribution> createState() => _StudentDistributionState();
}

class _StudentDistributionState extends State<StudentDistribution> {
  List<RaisedFundingModel> rList = [];
  RaisedFundingModel fdata = RaisedFundingModel();
  late Future fetchRaisedFund;
  final _formKey = GlobalKey<FormState>();

  getRaisedList() async {
    try {
      var data = {};
      data['status'] = "1";

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

  studentCard(RaisedFundingModel sData, index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Checkbox(
                        value: false,
                        onChanged: (value) {},
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sData.student_name.toString(),
                      style: FontStyle.textCardTitle
                          .copyWith(fontFamily: 'Bold', fontSize: 14),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    // height: 50,
                    width: MediaQuery.of(context).size.width * 0.30,
                    child: TextFormField(
                      style: FontStyle.textInput,
                      initialValue: double.parse(sData.approved_amt.toString())
                          .round()
                          .toString(),
                      onSaved: (newValue) {
                        sData.pay_amt = newValue;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: Utils().inputDecoration('0').copyWith(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10)),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter Remark";
                        } else if (double.parse(value) < 1) {
                          return "Amount must be more than 0";
                        } else if (double.parse(value) >
                            double.parse(sData.approved_amt.toString())) {
                          return "Amount is more than asking amount";
                        } else {
                          return null;
                        }
                      },
                    ),
                  )
                ],
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
          'Select Student',
          style: FontStyle.textLabelWhite,
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SelectDonor(),
              ));
        },
        child: Utils()
            .primaryButton('Next', MediaQuery.of(context).size.width * 0.7),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: FutureBuilder(
        future: fetchRaisedFund,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          } else {
            if (rList.isNotEmpty) {
              return ListView.builder(
                itemCount: rList.length,
                itemBuilder: (context, index) {
                  return studentCard(rList[index], index);
                },
              );
            } else {
              return Utils().noItem('No Data Found');
            }
          }
        },
      ),
    );
  }
}
