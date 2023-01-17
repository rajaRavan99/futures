import 'package:cached_network_image/cached_network_image.dart';
import 'package:donor/Library/TextStyle.dart';
import 'package:donor/Library/Utils.dart';
import 'package:donor/StudentDashboard/StudentProfile.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';

import '../Library/AppColors.dart';
import '../model/ImageModel.dart';
import '../model/UserModel.dart';

class VStudentDetail extends StatefulWidget {
  const VStudentDetail({super.key});

  @override
  State<VStudentDetail> createState() => _VStudentDetailState();
}

enum Pet { currentYear, previousyear }

class _VStudentDetailState extends State<VStudentDetail> {
  Pet? petvalue = Pet.currentYear;

  UserModel uData = UserModel();

  var pPhoto = "";

  bool imgLoading = false;

  uploadProfile() async {
    setState(() {
      imgLoading = true;
    });
    var img = await Utils().pickImage(ImageSource.gallery);

    ImageModel fImage = await Utils().uploadImage(img.toString(), 'profile');
    print('${fImage.h_path}${fImage.imgpath}');
    pPhoto = '${fImage.h_path}${fImage.imgpath}';
    uData.uphoto = fImage;
    imgLoading = false;
    setState(() {});
  }

  personalInfo() {
    return ExpandableNotifier(
        initialExpanded: true,
        child: Padding(
          padding: const EdgeInsets.all(5),
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
                        children: const <Widget>[
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            'Parent Detail:',
                            style: FontStyle.textCardValue,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            'Mother:',
                            style: FontStyle.textCardValue,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            'Father:',
                            style: FontStyle.textCardValue,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),

                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            'Legal Guarduan:',
                            style: FontStyle.textCardValue,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            'Home Address:',
                            style: FontStyle.textCardValue,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            'Grade:',
                            style: FontStyle.textCardValue,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            'School:',
                            style: FontStyle.textCardValue,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            'Curriculam:',
                            style: FontStyle.textCardValue,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            'Family Income:',
                            style: FontStyle.textCardValue,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            'Institutional Support ? ',
                            style: FontStyle.textCardValue,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            'Private Support ?',
                            style: FontStyle.textCardValue,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                          ),

                          // for (var _ in Iterable.generate(5))
                          //   const Padding(
                          //       padding: EdgeInsets.only(bottom: 10),
                          //       child: Text(
                          //         'loremIpsum',
                          //         softWrap: true,
                          //         overflow: TextOverflow.fade,
                          //       )),
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
        initialExpanded: true,
        child: Padding(
          padding: const EdgeInsets.all(5),
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
                          Container(
                            margin: const EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Radio(
                                  activeColor: AppColors.black.withOpacity(0.6),
                                  value: Pet.currentYear,
                                  groupValue: petvalue,
                                  onChanged: (value) {
                                    setState(() {
                                      petvalue = value;
                                    });
                                  },
                                ),
                                const Text(
                                  'Current Year',
                                  style: FontStyle.textCardValue,
                                ),
                                Radio(
                                  activeColor: AppColors.black.withOpacity(0.6),
                                  value: Pet.previousyear,
                                  groupValue: petvalue,
                                  onChanged: (value) {
                                    setState(() {
                                      petvalue = value;
                                    });
                                  },
                                ),
                                const Text(
                                  'Previous Year',
                                  style: FontStyle.textCardValue,
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                            visible: petvalue == Pet.currentYear,
                            child: Column(
                              children: const [
                                Text(
                                  '2022',
                                  style: FontStyle.textCardValue,
                                )
                              ],
                            ),
                          ),

                          Visibility(
                            visible: petvalue == Pet.previousyear,
                            child: Column(
                              children: const [
                                Text(
                                  '2021',
                                  style: FontStyle.textCardValue,
                                )
                              ],
                            ),
                          ),

                          // for (var _ in Iterable.generate(5))
                          //   const Padding(
                          //       padding: EdgeInsets.only(bottom: 10),
                          //       child: Text(
                          //         'loremIpsum',
                          //         softWrap: true,
                          //         overflow: TextOverflow.fade,
                          //       )),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
              splashRadius: 20,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const StudentProfile()));
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.orange_90,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                      top: 10, left: 10, right: 10, bottom: 0),
                  child: Text(
                    'Student Profile',
                    style: FontStyle.textButton2.copyWith(fontSize: 18),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          imgLoading
                              ? Container(
                                  height: 125,
                                  width: 125,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: AppColors.grey_09,
                                          width: 1.5)),
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
                                          color: AppColors.grey_09,
                                          width: 1.5)),
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: pPhoto,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const Center(
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
                          InkWell(
                              onTap: () {
                                // uploadProfile();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                    pPhoto != ""
                                        ? 'Change Photo'
                                        : "Upload Photo",
                                    style: FontStyle.textHint.copyWith(
                                        color: AppColors.black, fontSize: 14)),
                              ))
                        ],
                      ),
                      Container(
                        height: 20,
                        margin: const EdgeInsets.only(bottom: 5, left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              'Prinyanka Yadav',
                              style: FontStyle.textHint2,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Unique No',
                        style: FontStyle.textHint2.copyWith(fontSize: 14),
                      )
                    ],
                  ),
                ),
                personalInfo(),
                otherInfo(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
