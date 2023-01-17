import 'package:donor/Library/TextStyle.dart';
import 'package:donor/StudentDashboard/RaisedFundList.dart';
import 'package:donor/model/RaisedFundingModel.dart';
import 'package:flutter/material.dart';
import '../Library/ApiData.dart';
import '../Library/Utils.dart';

class AddRaisedFund extends StatefulWidget {
  const AddRaisedFund({Key? key, this.raisedModel, this.dId}) : super(key: key);
  final RaisedFundingModel? raisedModel;
  final String? dId;

  @override
  State<AddRaisedFund> createState() => _AddRaisedFundState();
}

class _AddRaisedFundState extends State<AddRaisedFund> {
  final _formKey = GlobalKey<FormState>();
  RaisedFundingModel raiseData = RaisedFundingModel();
  List<RaisedFundingModel> aList = [];

  bool isLoading = false;
  late Future fActivity;

  addActivity() async {
    setState(() {
      isLoading = true;
    });
    try {
      var data = {};
      data = {};
      data['id'] = widget.dId;
      data['demand_amt'] = raiseData.demand_amt;
      data['course_year'] = raiseData.course_year;
      data['course_month'] = raiseData.course_month;
      data['other_detail'] = raiseData.other_detail;
      data['status'] = raiseData.status;

      var res = await ApiData().postData('raise_donation', data);
      if (res['st'] == 'success') {
        if (!mounted) return;

        Navigator.pushAndRemoveUntil<void>(
          context,
          MaterialPageRoute<void>(
              builder: (BuildContext context) => const RaisedFundList()),
          ModalRoute.withName('/StudentDashboard'),
        );
      } else {
        if (!mounted) return;
        Utils().errorSnack(context, res["msg"]);
      }
    } catch (e) {
      print('print error: $e');
      Utils().errorSnack(context, "Failed");
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.raisedModel != null) {
      raiseData = widget.raisedModel!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Raised Fund',
          style: FontStyle.textLabelWhite,
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Amount :',
                      style: FontStyle.textCardTitle,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        initialValue: raiseData.demand_amt,
                        style: FontStyle.inputform,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        decoration: Utils().inputDecoration("Enter Amount"),
                        onChanged: (val) => print(val),
                        onSaved: (newValue) {
                          setState(() {
                            raiseData.demand_amt = newValue;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Amount';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Course Time :',
                      style: FontStyle.textCardTitle,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Year :',
                          style: FontStyle.textCardTitle,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: TextFormField(
                            initialValue: raiseData.course_year,
                            style: FontStyle.inputform,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            decoration: Utils().inputDecoration(""),
                            onChanged: (val) => print(val),
                            onSaved: (newValue) {
                              setState(() {
                                raiseData.course_year = newValue;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Amount';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          'Month :',
                          style: FontStyle.textCardTitle,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: TextFormField(
                            initialValue: raiseData.course_month,
                            style: FontStyle.inputform,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            decoration: Utils().inputDecoration(""),
                            onChanged: (val) => print(val),
                            onSaved: (newValue) {
                              setState(() {
                                raiseData.course_month = newValue;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please Enter Amount';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Details :',
                      style: FontStyle.textCardTitle,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: double.infinity,
                      child: TextFormField(
                        initialValue: raiseData.other_detail,
                        style: FontStyle.inputform,
                        textInputAction: TextInputAction.next,
                        maxLines: 5,
                        decoration: Utils().inputDecoration("Other Details"),
                        onChanged: (val) => print(val),
                        onSaved: (newValue) {
                          setState(() {
                            raiseData.other_detail = newValue;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Details';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        final form = _formKey.currentState;
                        if (form!.validate()) {
                          form.save();
                          addActivity();
                        }
                      },
                      child: Utils().primaryButton(
                          'Submit', MediaQuery.of(context).size.width * 0.7),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
