import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:donor/Library/MyNavigator.dart';
import 'package:donor/Library/TextStyle.dart';
import 'package:donor/Library/Utils.dart';
import 'package:donor/model/DocModel.dart';
import 'package:donor/model/UserDetailModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import '../Library/ApiData.dart';
import '../Library/AppColors.dart';
import '../Library/ManageStorage.dart';
import '../model/ImageModel.dart';
import 'StudentProfile.dart';

class AddPersonalInfo extends StatefulWidget {
  final bool isRegister;
  const AddPersonalInfo({super.key, this.userDetailModel,required this.isRegister});

  final UserDetailModel? userDetailModel;

  @override
  State<AddPersonalInfo> createState() => _AddPersonalInfoState();
}

class _AddPersonalInfoState extends State<AddPersonalInfo> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();

  late Future fetchDocList;

  List<DocModel> docList = [];

  UserDetailModel uData = UserDetailModel();

  bool imgLoading = false;

  var docIndex = "";

  String? emptyValidator(value) {
    if (value.isEmpty) {
      return 'Field is Required';
    }
    return null;
  }

  fetchMobileNumber() async {
    phoneController.text = await AppStorage.getData('umobile')??"";
    setState(() {});
  }

  Future getDocList() async {
    try {
      var data = {};
      data['aaid'] = await AppStorage.getData('aaid') ?? "";

      var res = await ApiData().postData('get_doc_list', data);
      if (res['st'] == 'success') {
        if (!mounted) return;
        setState(() {
          docList = DocModelList(res['doc_list']);
          if (widget.userDetailModel != null) {
            if (docList.isNotEmpty) {
              for (var el1 in docList) {
                for (var el2 in widget.userDetailModel!.document!) {
                  if (el1.doc_type == el2.doc_type) {
                    el1.doc_type = el2.doc_type;
                    el1.doc_name = el2.doc_name;
                    el1.doc_path = el2.doc_path;
                    el1.show_path =
                        el2.h_path.toString() + el2.doc_path.toString();
                  }
                }
              }
            }
          }
          setState(() {});
        });
      } else {
        if (!mounted) return;
        Utils().errorSnack(context, res["msg"]);
      }
    } catch (e) {
      print('print error: $e');
      Utils().errorSnack(context, "Internal Server Error");
    }
    return docList;
  }

  Future uploadPersonalDetail() async {
    try {
      var data = {};
      data['uname'] = uData.uname;
      data['umobile'] = uData.umobile;
      data['uemail'] = uData.uemail;
      data['document'] = json.encode(docList);
      data['address'] = uData.address;
      data['family_income'] = uData.family_income;
      data['uphoto'] = json.encode(uData.uphoto);

      var res = await ApiData().postData('update_kys', data);
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

  uploadProfile() async {
    setState(() {
      imgLoading = true;
    });
    var img = await Utils().pickImage(ImageSource.gallery);

    try {
      ImageModel fImage = await Utils().uploadImage(img.toString(), 'profile');
      print('${fImage.h_path}${fImage.imgpath}');
      uData.uphoto = fImage;
    } catch (e) {}
    imgLoading = false;
    setState(() {});
  }

  uploadDocument(int index) async {
    setState(() {
      docIndex = index.toString();
    });
    var img = await Utils().pickImage(ImageSource.gallery);

    try {
      ImageModel fImage = await Utils().uploadImage(img.toString(), 'kys');
      print('${fImage.h_path}${fImage.imgpath}');
      docList[index].doc_path = '${fImage.imgpath}';
      docList[index].show_path = '${fImage.h_path}${fImage.imgpath}';
    } catch (e) {}

    docIndex = "";
    print(docIndex);
    setState(() {});
  }

  @override
  void initState() {
    fetchDocList = getDocList();
    fetchMobileNumber();

    if (widget.userDetailModel != null) {
      uData = widget.userDetailModel!;
      print(widget.userDetailModel!.uphoto!.imgpath);
      setState(() {});
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Personal Info',
          style: FontStyle.appBarText,
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Visibility(
                  visible: !widget.isRegister,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      imgLoading
                          ? Container(
                              height: 125,
                              width: 125,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: AppColors.grey_09, width: 1.5)),
                              child: const Center(
                                child: SpinKitCircle(
                                  color: AppColors.primaryColor,
                                  size: 30.0,
                                ),
                              ),
                            )
                          : Container(
                              height: 125,
                              width: 125,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: AppColors.grey_09, width: 1.5)),
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: (uData.uphoto ?? ImageModel())
                                          .h_path
                                          .toString() +
                                      (uData.uphoto ?? ImageModel())
                                          .imgpath
                                          .toString(),
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                    child: SpinKitCircle(
                                      color: AppColors.primaryColor,
                                      size: 30.0,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => ClipOval(
                                    child: Image.asset(
                                      'assets/image/person.png',
                                      width: 125,
                                      height: 125,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                      InkWell(
                          onTap: () {
                            uploadProfile();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                                ((uData.uphoto ?? ImageModel()).imgpath ?? "") !=
                                        ""
                                    ? 'Change Photo'
                                    : "Upload Photo",
                                style: FontStyle.textHint.copyWith(
                                    color: AppColors.black, fontSize: 14)),
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                            top: 1, left: 0, right: 0, bottom: 10),
                        child: TextFormField(
                            initialValue: uData.uname,
                            style: FontStyle.inputform,
                            onSaved: (newValue) {
                              setState(() {
                                uData.uname = newValue;
                              });
                            },
                            validator: emptyValidator,
                            decoration: Utils()
                                .inputDecoration(
                                  'Enter Name',
                                )
                                .copyWith()),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                            top: 1, left: 0, right: 0, bottom: 10),
                        child: TextFormField(
                            style: FontStyle.inputform,
                            keyboardType: TextInputType.number,
                            controller: phoneController,
                            readOnly: true,
                            onSaved: (newValue) {
                              setState(() {
                                uData.umobile = newValue;
                              });
                            },
                            validator: emptyValidator,
                            decoration: Utils()
                                .inputDecoration(
                                  'Enter Mobile Number',
                                )
                                .copyWith()),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                            top: 1, left: 0, right: 0, bottom: 10),
                        child: TextFormField(
                            initialValue: uData.uemail,
                            style: FontStyle.inputform,
                            onSaved: (newValue) {
                              setState(() {
                                uData.uemail = newValue;
                              });
                            },
                            validator: emptyValidator,
                            decoration: Utils()
                                .inputDecoration(
                                  'Enter Email ',
                                )
                                .copyWith()),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                            top: 1, left: 0, right: 0, bottom: 10),
                        child: TextFormField(
                            initialValue: uData.address,
                            style: FontStyle.inputform,
                            onSaved: (newValue) {
                              setState(() {
                                uData.address = newValue;
                              });
                            },
                            maxLines: 2,
                            decoration: Utils()
                                .inputDecoration(
                                  'Enter Address',
                                )
                                .copyWith()),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                            top: 1, left: 0, right: 0, bottom: 10),
                        child: TextFormField(
                            initialValue: uData.family_income,
                            style: FontStyle.inputform,
                            onSaved: (newValue) {
                              setState(() {
                                uData.family_income = newValue;
                              });
                            },
                            validator: emptyValidator,
                            keyboardType: TextInputType.number,
                            decoration: Utils()
                                .inputDecoration(
                                  'Enter Family Income',
                                )
                                .copyWith()),
                      ),
                      FutureBuilder(
                        future: fetchDocList,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return const Center(
                              child: SpinKitThreeBounce(
                                size: 30,
                                color: AppColors.primaryColor,
                              ),
                            );
                          } else {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 50,
                                  width: double.infinity,
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    'Required Document',
                                    style: FontStyle.inputform.copyWith(
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 200,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: docList.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              width: 120,
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 5.0),
                                                  child: RichText(
                                                    textAlign: TextAlign.center,
                                                    text: TextSpan(
                                                      text: docList[index]
                                                          .doc_name
                                                          .toString(),
                                                      style: FontStyle
                                                          .primarySmallBlack,
                                                      children: const <
                                                          TextSpan>[
                                                        TextSpan(
                                                            text: ' *',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: AppColors
                                                                    .red_00)),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            (docList[index].show_path ?? "") !=
                                                    ""
                                                ? Stack(
                                                    children: [
                                                      Container(
                                                        // padding: const EdgeInsets.only(top: 5.0,right: 10),
                                                        height: 150,
                                                        width: 120,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .grey_90),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl:
                                                              docList[index]
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
                                                                          color:
                                                                              AppColors.grey_09),
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
                                                            docList[index]
                                                                .show_path = "";
                                                            docList[index]
                                                                .doc_path = "";
                                                            setState(() {});
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: AppColors
                                                                  .red_55,
                                                              borderRadius: BorderRadius.only(
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
                                                : InkWell(
                                                    onTap: () {
                                                      uploadDocument(index);
                                                    },
                                                    child: Container(
                                                      height: 150,
                                                      width: 120,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: AppColors
                                                                .grey_90),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Center(
                                                        child: docIndex
                                                                    .toString() !=
                                                                index.toString()
                                                            ? Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  const Icon(
                                                                    Icons
                                                                        .add_circle_outlined,
                                                                    color: AppColors
                                                                        .grey_09,
                                                                    size: 35,
                                                                  ),
                                                                  Text(
                                                                    'Add\nDocument',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: FontStyle
                                                                        .textHint
                                                                        .copyWith(
                                                                            fontSize:
                                                                                14,
                                                                            color:
                                                                                AppColors.grey_09),
                                                                  ),
                                                                ],
                                                              )
                                                            : const SpinKitCircle(
                                                                color: AppColors
                                                                    .primaryColor,
                                                                size: 35,
                                                              ),
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                )
                              ],
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {
                    var check =
                        docList.where((element) => element.is_require == true);
                    var check2 = check
                        .where((element) => (element.doc_path ?? "") == "");
                    if (check2.isNotEmpty) {
                      Utils().errorSnack(
                          context, "${check2.first.doc_name} is require");
                    } else {
                      final form = _formKey.currentState;
                      if (form!.validate()) {
                        form.save();
                        uploadPersonalDetail();
                      }
                    }
                  },
                  child: Utils().primaryButton(
                      'Submit', MediaQuery.of(context).size.width * 0.7),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
