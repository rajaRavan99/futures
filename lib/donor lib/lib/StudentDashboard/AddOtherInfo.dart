import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:donor/Library/TextStyle.dart';
import 'package:donor/Library/Utils.dart';
import 'package:donor/StudentDashboard/StudentProfile.dart';
import 'package:donor/model/UserDetailModel.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import '../Library/ApiData.dart';
import '../Library/AppColors.dart';
import '../Library/MyNavigator.dart';
import '../model/DocModel.dart';
import '../model/ImageModel.dart';

class AddOtherInfo extends StatefulWidget {
  final bool isRegister;
  const AddOtherInfo({super.key, this.userDetailModel, required this.isRegister});
  final UserDetailModel? userDetailModel;

  @override
  State<AddOtherInfo> createState() => _AddOtherInfoState();
}

class _AddOtherInfoState extends State<AddOtherInfo> {
  final _formKey = GlobalKey<FormState>();

  UserDetailModel uData = UserDetailModel();
  bool imgLoading = false;

  List<DocModel> docList = [];

  bool docLoading = false;

  ScrollController controller = ScrollController();

  uploadDocument() async {
    setState(() {
      docLoading = true;
    });
    var img = await Utils().pickImage(ImageSource.gallery);

    try {
      ImageModel fImage = await Utils().uploadImage(img.toString(), 'edu');
      DocModel dData = DocModel(
          doc_type: 'edu_doc',
          doc_name: 'edu_doc',
          doc_path: fImage.imgpath.toString(),
          is_require: false,
          show_path: '${fImage.h_path}${fImage.imgpath}');
      controller.animateTo(controller.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn);
      docList.add(dData);
    } catch (e) {}
    docLoading = false;
    setState(() {});
  }

  educationalDetail() {
    return ExpandableNotifier(
        initialExpanded: true,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Card(
            elevation: 5.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            color: AppColors.white_00,
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    theme: const ExpandableThemeData(
                      hasIcon: false,
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                    ),
                    header: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Parent Detail",
                            style: FontStyle.textHeaderBlack,
                          ),
                          Icon(Icons.arrow_drop_down,
                              size: 30, color: AppColors.black),
                        ],
                      ),
                    ),
                    collapsed: const Text(
                      '',
                      softWrap: true,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    expanded: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(
                                top: 1, left: 0, right: 0, bottom: 10),
                            child: TextFormField(
                                initialValue: uData.father_name,
                                style: FontStyle.inputform,
                                onSaved: (value) {
                                  uData.father_name = value;
                                },
                                decoration: Utils()
                                    .inputDecoration(
                                      'Enter Father Name',
                                    )
                                    .copyWith()),
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(
                                top: 1, left: 0, right: 0, bottom: 10),
                            child: TextFormField(
                                initialValue: uData.mother_name,
                                onSaved: (value) {
                                  uData.mother_name = value;
                                },
                                style: FontStyle.inputform,
                                decoration: Utils()
                                    .inputDecoration(
                                      'Enter Mother Number',
                                    )
                                    .copyWith()),
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(
                                top: 1, left: 0, right: 0, bottom: 10),
                            child: TextFormField(
                                initialValue: uData.legal_guardian,
                                style: FontStyle.inputform,
                                onSaved: (value) {
                                  uData.legal_guardian = value;
                                },
                                decoration: Utils()
                                    .inputDecoration(
                                      'Enter Legal Guardian',
                                    )
                                    .copyWith()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  prentDetail() {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: AppColors.white_00,
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  hasIcon: false,
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Educational",
                        style: FontStyle.textHeaderBlack,
                      ),
                      Icon(Icons.arrow_drop_down,
                          size: 30, color: AppColors.black),
                    ],
                  ),
                ),
                collapsed: const Text(
                  '',
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                expanded: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                            top: 1, left: 0, right: 0, bottom: 10),
                        child: TextFormField(
                            initialValue: uData.institute_name,
                            onSaved: (value) {
                              uData.institute_name = value;
                            },
                            style: FontStyle.inputform,
                            decoration: Utils()
                                .inputDecoration(
                                  'Enter Institute Name',
                                )
                                .copyWith()),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                            top: 1, left: 0, right: 0, bottom: 10),
                        child: TextFormField(
                            initialValue: uData.current_course,
                            style: FontStyle.inputform,
                            onSaved: (value) {
                              uData.current_course = value;
                            },
                            decoration: Utils()
                                .inputDecoration(
                                  'Enter Current Course',
                                )
                                .copyWith()),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                            top: 1, left: 0, right: 0, bottom: 10),
                        child: TextFormField(
                            initialValue: uData.admission_year,
                            style: FontStyle.inputform,
                            onSaved: (value) {
                              uData.admission_year = value;
                            },
                            decoration: Utils()
                                .inputDecoration(
                                  'Enter Admission Year',
                                )
                                .copyWith()),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                            top: 1, left: 0, right: 0, bottom: 10),
                        child: TextFormField(
                            initialValue: uData.last_year,
                            onSaved: (value) {
                              uData.last_year = value;
                            },
                            style: FontStyle.inputform,
                            decoration: Utils()
                                .inputDecoration(
                                  'Enter Last Year',
                                )
                                .copyWith()),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                            top: 1, left: 0, right: 0, bottom: 10),
                        child: TextFormField(
                            initialValue: uData.grade,
                            style: FontStyle.inputform,
                            onSaved: (value) {
                              uData.grade = value;
                            },
                            decoration: Utils()
                                .inputDecoration(
                                  'Enter Grade ',
                                )
                                .copyWith()),
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              uploadDocument();
                            },
                            child: Container(
                              height: 150,
                              width: 120,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.grey_90),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.add_circle_outlined,
                                      color: AppColors.grey_09,
                                      size: 35,
                                    ),
                                    Text(
                                      'Add\nDocument',
                                      textAlign: TextAlign.center,
                                      style: FontStyle.textHint.copyWith(
                                          fontSize: 14,
                                          color: AppColors.grey_09),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 200,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                controller: controller,
                                child: Row(
                                  children: [
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: docList.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              right: 10.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Stack(
                                                children: [
                                                  Container(
                                                    // padding: const EdgeInsets.only(top: 5.0,right: 10),
                                                    height: 150,
                                                    width: 120,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: AppColors
                                                              .grey_90),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: CachedNetworkImage(
                                                      imageUrl: docList[index]
                                                          .show_path
                                                          .toString(),
                                                      errorWidget: (context,
                                                          url, error) {
                                                        return Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Icon(
                                                              Icons.close,
                                                              color: AppColors
                                                                  .grey_09,
                                                              size: 35,
                                                            ),
                                                            Text(
                                                              'No\nDocument',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: FontStyle
                                                                  .textHint
                                                                  .copyWith(
                                                                      fontSize:
                                                                          14,
                                                                      color: AppColors
                                                                          .grey_09),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                      placeholder:
                                                          (context, url) {
                                                        return const Center(
                                                            child:
                                                                SpinKitCircle(
                                                          color: AppColors
                                                              .primaryColor,
                                                          size: 35,
                                                        ));
                                                      },
                                                    ),
                                                  ),
                                                  Positioned(
                                                    bottom: 0,
                                                    right: 0,
                                                    child: InkWell(
                                                      onTap: () {
                                                        docList.removeAt(index);
                                                        setState(() {});
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                          color:
                                                              AppColors.red_55,
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          15),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          10)),
                                                        ),
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5),
                                                        child: const Icon(
                                                          Icons.close,
                                                          color: AppColors
                                                              .white_00,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    docLoading
                                        ? Container(
                                            height: 150,
                                            width: 120,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: AppColors.grey_90),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: const Center(
                                              child: SpinKitCircle(
                                                size: 30,
                                                color: AppColors.primaryColor,
                                              ),
                                            ),
                                          )
                                        : const SizedBox()
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Future uploadOtherDetail() async {
    try {
      var data = {};
      data['edu_document'] = json.encode(docList);
      data['father_name'] = uData.father_name;
      data['mother_name'] = uData.mother_name;
      data['legal_guardian'] = uData.legal_guardian;
      data['institute_name'] = uData.institute_name;
      data['current_course'] = uData.current_course;
      data['admission_year'] = uData.admission_year;
      data['last_year'] = uData.last_year;
      data['grade'] = uData.grade;

      var res = await ApiData().postData('update_other_detail', data);
      if (res['st'] == 'success') {
        if (!mounted) return;
        if(!widget.isRegister){
          Navigator.pushAndRemoveUntil<void>(
            context,
            MaterialPageRoute<void>(
                builder: (BuildContext context) => const StudentProfile()),
            ModalRoute.withName('/StudentDashboard'),
          );
        }else{
          MyNavigator().goToDashBoard(context);
        }
      } else {
        if (!mounted) return;
        Utils().errorSnack(context, res["msg"]);
      }
    } catch (e) {
      print('print error: $e');
      Utils().errorSnack(context, "Internal Server Error");
    }
  }

  @override
  void initState() {
    if (widget.userDetailModel != null) {
      uData = widget.userDetailModel!;
      docList = widget.userDetailModel!.edu_document!;
      setState(() {});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Other Information",
          style: FontStyle.appBarText,
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              educationalDetail(),
              prentDetail(),
              const SizedBox(height: 50),
              InkWell(
                onTap: () {
                  final form = _formKey.currentState;
                  if (form!.validate()) {
                    form.save();
                    uploadOtherDetail();
                  }
                },
                child: Utils().primaryButton(
                    'Submit', MediaQuery.of(context).size.width * 0.7),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
