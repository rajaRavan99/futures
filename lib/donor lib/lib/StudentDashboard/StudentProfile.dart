import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:donor/Library/PhotoView.dart';
import 'package:donor/Library/TextStyle.dart';
import 'package:donor/StudentDashboard/AddOtherInfo.dart';
import 'package:donor/StudentDashboard/AddPersonalInfo.dart';
import 'package:donor/model/UserDetailModel.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../Library/ApiData.dart';
import '../Library/AppColors.dart';
import '../Library/ManageStorage.dart';
import '../Library/Utils.dart';
import '../model/ImageModel.dart';

class StudentProfile extends StatefulWidget {
  const StudentProfile({super.key});

  @override
  State<StudentProfile> createState() => _StudentProfileState();
}

enum Pet { currentYear, previousyear }

class _StudentProfileState extends State<StudentProfile> {
  Pet? petvalue = Pet.currentYear;
  File? _image;
  String? imagepath;

  UserDetailModel uDetail = UserDetailModel();

  late Future fetchStudentProfile;

  getStudentProfile() async {
    try {
      String aaid = await AppStorage.getData('aaid') ?? "";

      var data = {};
      data['aaid'] = aaid;

      var res = await ApiData().postData('get_student_profile', data);
      if (res['st'] == 'success') {
        uDetail = UserDetailModel.fromJson(res['data']);
      } else {
        if (!mounted) return;
        Utils().errorSnack(context, res["msg"]);
      }
    } catch (e) {
      print('print error: $e');
      Utils().errorSnack(context, "Internal Server Error");
    }
    return uDetail;
  }

  personalInfo() {
    return ExpandableNotifier(
        initialExpanded: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Card(
            elevation: 5.0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: <Widget>[
                ScrollOnExpand(
                  scrollOnExpand: true,
                  scrollOnCollapse: false,
                  child: ExpandablePanel(
                    theme: const ExpandableThemeData(
                      iconColor: AppColors.black,
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      hasIcon: false,
                      tapBodyToCollapse: false,
                    ),
                    header: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Personal Information",
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
                        children: <Widget>[
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Name : ',
                                style: FontStyle.textsmallregular,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              ),
                              Expanded(
                                child: Text(
                                  uDetail.uname!,
                                  style: FontStyle.textCardValue,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Mobile Number : ',
                                style: FontStyle.textsmallregular,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              ),
                              Expanded(
                                child: Text(
                                  uDetail.umobile!,
                                  style: FontStyle.textCardValue,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Email : ',
                                style: FontStyle.textsmallregular,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              ),
                              Expanded(
                                child: Text(
                                  uDetail.uemail!,
                                  style: FontStyle.textCardValue,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Address : ',
                                style: FontStyle.textsmallregular,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              ),
                              Expanded(
                                child: Text(
                                  uDetail.address!,
                                  style: FontStyle.textCardValue,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Family Income : ',
                                style: FontStyle.textsmallregular,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                              ),
                              Expanded(
                                child: Text(
                                  uDetail.family_income!,
                                  style: FontStyle.textCardValue,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Documents : ',
                            style: FontStyle.inputform.copyWith(
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 200,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: uDetail.document!.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PhotoView(
                                                        docList:
                                                            uDetail.document ??
                                                                [],
                                                        index: index,
                                                      )));
                                        },
                                        child: Container(
                                          height: 150,
                                          width: 120,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.grey_90),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: uDetail
                                                .document![index].show_path
                                                .toString(),
                                            errorWidget: (context, url, error) {
                                              return Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                    Icons.close,
                                                    color: AppColors.grey_09,
                                                    size: 35,
                                                  ),
                                                  Text(
                                                    'No\nDocument',
                                                    textAlign: TextAlign.center,
                                                    style: FontStyle.textHint
                                                        .copyWith(
                                                            fontSize: 14,
                                                            color: AppColors
                                                                .grey_09),
                                                  ),
                                                ],
                                              );
                                            },
                                            placeholder: (context, url) {
                                              return const Center(
                                                  child: SpinKitCircle(
                                                color: AppColors.primaryColor,
                                                size: 35,
                                              ));
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        width: 120,
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            child: RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(
                                                text: uDetail
                                                    .document![index].doc_name
                                                    .toString(),
                                                style:
                                                    FontStyle.primarySmallBlack,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
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

  otherInfo() {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                  hasIcon: false,
                ),
                header: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Other Information",
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
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Parent Detail :',
                            style: FontStyle.textCardTitle,
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 5, right: 5, top: 2),
                              height: 1,
                              width: double.infinity,
                              color: AppColors.black.withOpacity(0.5),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Father Name : ',
                            style: FontStyle.textCardTitle,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                          Expanded(
                            child: Text(
                              uDetail.father_name!,
                              style: FontStyle.textCardValue,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Mother Name : ',
                            style: FontStyle.textCardTitle,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                          Expanded(
                            child: Text(
                              uDetail.mother_name!,
                              style: FontStyle.textCardValue,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Visibility(
                        visible: uDetail.legal_guardian!.isNotEmpty,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  'Legal Guardian : ',
                                  style: FontStyle.textCardTitle,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                Expanded(
                                  child: Text(
                                    uDetail.legal_guardian!,
                                    style: FontStyle.textCardValue,
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Educational : ',
                            style: FontStyle.textHeaderBlack,
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 5, right: 5, top: 2),
                              height: 1,
                              width: double.infinity,
                              color: AppColors.black.withOpacity(0.5),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Institute Name : ',
                            style: FontStyle.textCardTitle,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                          Expanded(
                            child: Text(
                              uDetail.institute_name!,
                              style: FontStyle.textCardValue,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Current Course : ',
                            style: FontStyle.textCardTitle,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                          Text(
                            uDetail.current_course!,
                            style: FontStyle.textCardValue,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Admission Year : ',
                            style: FontStyle.textCardTitle,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                          Text(
                            uDetail.admission_year!,
                            style: FontStyle.textCardValue,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Expected Last Year : ',
                            style: FontStyle.textCardTitle,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                          Expanded(
                            child: Text(
                              uDetail.last_year!,
                              style: FontStyle.textCardValue,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Last Year Grade : ',
                            style: FontStyle.textCardTitle,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                          Expanded(
                            child: Text(
                              uDetail.grade!,
                              style: FontStyle.textCardValue,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            'Educational Document : ',
                            style: FontStyle.inputform.copyWith(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: uDetail.edu_document!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => PhotoView(
                                                    docList:
                                                        uDetail.document ?? [],
                                                    index: index,
                                                  )));
                                    },
                                    child: Container(
                                      height: 150,
                                      width: 120,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.grey_90),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: uDetail
                                            .edu_document![index].show_path
                                            .toString(),
                                        errorWidget: (context, url, error) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.close,
                                                color: AppColors.grey_09,
                                                size: 35,
                                              ),
                                              Text(
                                                'No\nDocument',
                                                textAlign: TextAlign.center,
                                                style: FontStyle.textHint
                                                    .copyWith(
                                                        fontSize: 14,
                                                        color:
                                                            AppColors.grey_09),
                                              ),
                                            ],
                                          );
                                        },
                                        placeholder: (context, url) {
                                          return const Center(
                                              child: SpinKitCircle(
                                            color: AppColors.primaryColor,
                                            size: 35,
                                          ));
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
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

  @override
  void initState() {
    fetchStudentProfile = getStudentProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student Profile',
          style: FontStyle.appBarText,
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: FutureBuilder(
        future: fetchStudentProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: SpinKitThreeBounce(
                size: 30,
                color: AppColors.primaryColor,
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Container(
                              height: 125,
                              width: 125,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: AppColors.grey_09, width: 1.5)),
                              child: ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: (uDetail.uphoto ?? ImageModel())
                                          .h_path
                                          .toString() +
                                      (uDetail.uphoto ?? ImageModel())
                                          .imgpath
                                          .toString(),
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                    child: SpinKitCircle(
                                      color: AppColors.primaryColor,
                                      size: 30.0,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      ClipOval(
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
                            Container(
                              height: 20,
                              margin: const EdgeInsets.only(bottom: 5, left: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    uDetail.uname!,
                                    style: FontStyle.textHint2,
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              uDetail.uid!,
                              style: FontStyle.textHint2.copyWith(fontSize: 14),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppColors.green_45,
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddPersonalInfo(
                                        userDetailModel: uDetail, isRegister: false),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: AppColors.white_00,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      personalInfo(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: AppColors.green_45,
                            ),
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AddOtherInfo(userDetailModel: uDetail, isRegister: false),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: AppColors.white_00,
                                size: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      otherInfo(),
                    ],
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
