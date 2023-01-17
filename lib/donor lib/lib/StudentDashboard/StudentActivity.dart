import 'package:donor/Library/AppColors.dart';
import 'package:donor/Library/TextStyle.dart';
import 'package:donor/model/ActivityModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../Library/ApiData.dart';
import '../Library/Utils.dart';

class StudentActivity extends StatefulWidget {
  const StudentActivity({Key? key}) : super(key: key);

  @override
  State<StudentActivity> createState() => _StudentActivityState();
}

class _StudentActivityState extends State<StudentActivity> {
  ActivityModel aData = ActivityModel();
  List<ActivityModel> aList = [];
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  late Future fActivity;

  addActivity(aId, ActivityModel activityData) async {
    setState(() {
      isLoading = true;
    });
    try {
      var data = {};

      data['aid'] = aId;
      data['atitle'] = activityData.atitle;
      data['adetail'] = activityData.adetail;

      var res = await ApiData().postData('add_activity', data);
      if (res['st'] == 'success') {
        if (!mounted) return;
        fActivity = getActivityList();
        Utils().successSnack(context, "Activity added Successfully.");
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

  getActivityList() async {
    setState(() {
      isLoading = true;
    });
    try {
      var data = {};

      var res = await ApiData().postData('activity_list', data);
      if (res['st'] == 'success') {
        if (!mounted) return;
        aList = ActivityModelList(res['data'] ?? []);
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
    return aList;
  }

  deleteActivity(aId) async {
    Utils().loading(context);
    try {
      var data = {};

      data['aid'] = aId;
      var res = await ApiData().postData('delete_activity', data);
      if (res['st'] == 'success') {
        if (!mounted) return;
        fActivity = getActivityList();
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
    fActivity = getActivityList();
  }

  activityForm(ActivityModel aData) {
    return showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (context) {
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/image/notes.png',
                      scale: 5,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Text(
                      'Add New Activity',
                      style: FontStyle.textBold,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Is simply dummy text of the printing and typesetting industry.',
                      style: FontStyle.greyTextSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        initialValue: aData.atitle,
                        onSaved: (newValue) {
                          setState(() {
                            aData.atitle = newValue;
                          });
                        },
                        validator: (value) {
                          if ((value ?? "") == "") {
                            return 'Please enter title';
                          }
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: Utils().inputDecoration('Title')),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      initialValue: aData.adetail,
                      onSaved: (newValue) {
                        setState(() {
                          aData.adetail = newValue;
                        });
                      },
                      validator: (value) {
                        if ((value ?? "") == "") {
                          return 'Please enter description';
                        }
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: Utils().inputDecoration('Description'),
                      maxLines: 3,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        isLoading
                            ? Utils().loadingButton(
                                MediaQuery.of(context).size.width * 0.5)
                            : InkWell(
                                onTap: () {
                                  final form = _formKey.currentState;
                                  if (form!.validate()) {
                                    form.save();
                                    addActivity(aData.aid ?? "", aData);
                                    Navigator.pop(context);
                                  }
                                },
                                child: Utils().primaryButton('Submit',
                                    MediaQuery.of(context).size.width * 0.5),
                              ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  activityCard(ActivityModel aData) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 2,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      aData.atitle.toString(),
                      style: FontStyle.textCardValue,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      aData.adetail.toString(),
                      style: FontStyle.textCardTitle,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
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
                      activityForm(aData);
                    }
                    if (value == "delete") {
                      Utils().deletePop(context, () {
                        deleteActivity(aData.aid);
                      }, 'Are you sure? You Want to delete this activity.',
                          true);
                    }
                  }),
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
        title: const Text(
          'Activity',
          style: FontStyle.textLabelWhite,
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          activityForm(ActivityModel(adetail: "", atitle: ""));
        },
        child: Utils().primaryIconButton(
            Icons.add, 'Add Activity', MediaQuery.of(context).size.width * 0.7),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: FutureBuilder(
          future: fActivity,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: SpinKitThreeBounce(
                  size: 30,
                  color: AppColors.primaryColor,
                ),
              );
            } else {
              List<ActivityModel> aList = snapshot.data as List<ActivityModel>;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: aList.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return activityCard(aList[index]);
                },
              );
            }
          }),
    );
  }
}
