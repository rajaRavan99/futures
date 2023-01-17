import 'dart:io';
import 'package:donor/Library/TextStyle.dart';
import 'package:donor/Library/Utils.dart';
import 'package:donor/StudentDashboard/StudentProfile.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../Library/AppColors.dart';
import '../singletone.dart';

class UpdateStudentProfile extends StatefulWidget {
  const UpdateStudentProfile({super.key});

  @override
  State<UpdateStudentProfile> createState() => _UpdateStudentProfileState();
}

enum Pet { yes, no }

class _UpdateStudentProfileState extends State<UpdateStudentProfile> {
  File? _image;
  String? imagepath;

  String? selectedvalue;
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6',
    'Item 7',
    'Item 8',
    'Item 9',
    'Item 10'
  ];

  Pet? petvalue;
  Pet? petvalue2;

  TextEditingController parentdetail = TextEditingController(text: '');
  TextEditingController mother = TextEditingController(text: '');
  TextEditingController father = TextEditingController(text: '');
  TextEditingController legal = TextEditingController(text: '');
  TextEditingController home = TextEditingController(text: '');
  TextEditingController grade = TextEditingController(text: '');
  TextEditingController school = TextEditingController(text: '');
  TextEditingController curriculam = TextEditingController(text: '');
  TextEditingController familyincome = TextEditingController(text: '');
  TextEditingController support = TextEditingController(text: '');
  TextEditingController psupport = TextEditingController(text: '');

  void pickedImage(ImageSource imageSource) {
    Singleton.instance.pickImage(imageSource).then(
          (value) => setState(
            () {
              if (value == null) {
              } else {
                _image = value;
                print(_image.toString());
                setState(() {});
              }
            },
          ),
        );
  }

  BasicInformation() {
    return ExpandableNotifier(
        initialExpanded: true,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Card(
            elevation: 2.0,
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
                      iconColor: AppColors.black,
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToCollapse: true,
                    ),
                    header: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Basic Information",
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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Parent Detail:',
                                  style: FontStyle.primarySmallBold,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(
                                      top: 1, left: 0, right: 10, bottom: 10),
                                  child: TextFormField(
                                      style: FontStyle.inputform,
                                      controller: parentdetail,
                                      decoration: Utils()
                                          .inputDecoration(
                                            'Enter Parent Detail',
                                          )
                                          .copyWith()),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Mother:',
                                  style: FontStyle.primarySmallBold,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(
                                      top: 1, left: 0, right: 10, bottom: 10),
                                  child: TextFormField(
                                      controller: mother,
                                      style: FontStyle.inputform,
                                      decoration: Utils().inputDecoration(
                                          'Enter Mother Name')),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Father:',
                                  style: FontStyle.primarySmallBold,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(
                                      top: 1, left: 0, right: 10, bottom: 10),
                                  child: TextFormField(
                                      controller: father,
                                      style: FontStyle.inputform,
                                      decoration: Utils().inputDecoration(
                                          'Enter Father Name')),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Legal Guarduan:',
                                  style: FontStyle.primarySmallBold,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(
                                      top: 1, left: 0, right: 10, bottom: 10),
                                  child: TextFormField(
                                      controller: legal,
                                      style: FontStyle.inputform,
                                      decoration: Utils().inputDecoration(
                                          'Enter Legal Guarduan Name')),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Home Address:',
                                  style: FontStyle.primarySmallBold,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(
                                      top: 1, left: 0, right: 10, bottom: 10),
                                  child: TextFormField(
                                    controller: home,
                                    style: FontStyle.inputform,
                                    decoration: Utils()
                                        .inputDecoration('Enter Home Address'),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Grade:',
                                  style: FontStyle.primarySmallBold,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(
                                      top: 1, left: 0, right: 10, bottom: 10),
                                  child: TextFormField(
                                    controller: grade,
                                    style: FontStyle.inputform,
                                    decoration:
                                        Utils().inputDecoration('Enter Grade'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'School:',
                                  style: FontStyle.primarySmallBold,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(
                                      top: 1, left: 0, right: 10, bottom: 10),
                                  child: TextFormField(
                                      controller: school,
                                      style: FontStyle.inputform,
                                      decoration: Utils().inputDecoration(
                                          'Enter School Name')),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Curriculam:',
                                  style: FontStyle.primarySmallBold,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(
                                      top: 1, left: 0, right: 10, bottom: 10),
                                  child: TextFormField(
                                      controller: curriculam,
                                      style: FontStyle.inputform,
                                      decoration: Utils()
                                          .inputDecoration('Enter Curriculam')),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Family Income:',
                                  style: FontStyle.primarySmallBold,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(
                                      top: 1, left: 0, right: 10, bottom: 10),
                                  child: TextFormField(
                                      controller: familyincome,
                                      style: FontStyle.inputform,
                                      decoration: Utils().inputDecoration(
                                          'Enter Family Income')),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Institutional Support ?(Y/N),If Yes How Much:',
                                  style: FontStyle.primarySmallBold,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 2),
                                  child: Row(
                                    children: [
                                      Radio(
                                        activeColor:
                                            AppColors.black.withOpacity(0.6),
                                        value: Pet.yes,
                                        groupValue: petvalue,
                                        onChanged: (value) {
                                          setState(() {
                                            petvalue = value;
                                          });
                                        },
                                      ),
                                      Text(
                                        'Yes',
                                        style: FontStyle.inputform,
                                      ),
                                      Radio(
                                        activeColor:
                                            AppColors.black.withOpacity(0.6),
                                        value: Pet.no,
                                        groupValue: petvalue,
                                        onChanged: (value) {
                                          setState(() {
                                            petvalue = value;
                                          });
                                        },
                                      ),
                                      const Text(
                                        'No',
                                        style: FontStyle.primarySmallBold,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Visibility(
                            visible: petvalue == Pet.yes,
                            child: Column(
                              children: [
                                Container(
                                  width: double.infinity,
                                  margin: const EdgeInsets.only(
                                      top: 1, left: 0, right: 10, bottom: 10),
                                  child: TextFormField(
                                    controller: support,
                                    style: const TextStyle(fontSize: 15),
                                    decoration:
                                        Utils().inputDecoration("Enter Answer"),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Private Support? (Y/N),If yes how much:',
                                  style: FontStyle.inputform,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 2),
                                  child: Row(
                                    children: [
                                      Radio(
                                        activeColor:
                                            AppColors.black.withOpacity(0.6),
                                        value: Pet.yes,
                                        groupValue: petvalue2,
                                        onChanged: (value) {
                                          setState(() {
                                            petvalue2 = value;
                                          });
                                        },
                                      ),
                                      const Text(
                                        'Yes',
                                        style: FontStyle.primarySmallBold,
                                      ),
                                      Radio(
                                        activeColor:
                                            AppColors.black.withOpacity(0.6),
                                        value: Pet.no,
                                        groupValue: petvalue2,
                                        onChanged: (value) {
                                          setState(() {
                                            petvalue2 = value;
                                          });
                                        },
                                      ),
                                      const Text(
                                        'No',
                                        style: FontStyle.primarySmallBold,
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: petvalue2 == Pet.yes,
                                  child: Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        margin: const EdgeInsets.only(
                                            top: 1,
                                            left: 0,
                                            right: 10,
                                            bottom: 10),
                                        child: TextFormField(
                                          controller: psupport,
                                          style: const TextStyle(fontSize: 15),
                                          decoration: Utils()
                                              .inputDecoration("Enter Answer"),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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

  schoolreport() {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(5),
      child: Card(
        elevation: 2.0,
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
                        "School Report",
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.orange_90,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 40,
                              width: 100,
                              child: DropdownButton(
                                menuMaxHeight: 200,
                                borderRadius: BorderRadius.circular(20),
                                value: selectedvalue,
                                hint: const Text(
                                  "Select Year",
                                  style: FontStyle.primarySmallBold,
                                ),
                                underline: Container(),
                                isExpanded: true,
                                iconEnabledColor: Colors.black,
                                dropdownColor: Colors.white,
                                focusColor: Colors.black,
                                items: items.map((String items) {
                                  return DropdownMenuItem(
                                      value: items,
                                      child: Text(
                                        items,
                                        style: FontStyle.primarySmallBold,
                                      ));
                                }).toList(),
                                onChanged: (Value) {
                                  setState(() {
                                    selectedvalue = Value;
                                    print(selectedvalue);
                                  });
                                },
                              ),
                            ),
                            Container(
                                height: 40,
                                width: 100,
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                decoration: BoxDecoration(
                                  color: AppColors.white_90,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Center(
                                  child: Text(
                                    "Upload File",
                                    style: FontStyle.primarySmallBold,
                                  ),
                                ))
                          ],
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

  addition() {
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Card(
          elevation: 2.0,
          color: AppColors.white_90,
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
                  ),
                  header: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Additional skills and Interest",
                        style: FontStyle.primarySmallBold,
                      )),
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
                        const Text(
                          'abc:',
                          style: FontStyle.primarySmallBold,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        const Text(
                          'def:',
                          style: FontStyle.primarySmallBold,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  carrerpath() {
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Card(
          elevation: 2.0,
          color: AppColors.white_90,
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
                  ),
                  header: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Carrer Path",
                        style: FontStyle.primarySmallBold,
                      )),
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
                        const Text(
                          'abc:',
                          style: FontStyle.primarySmallBold,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  otherInfo() {
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Card(
          elevation: 2.0,
          color: AppColors.white_90,
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
                  ),
                  header: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Other Information and comments",
                        style: FontStyle.primarySmallBold,
                      )),
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
                        const Text(
                          'abc:',
                          style: FontStyle.primarySmallBold,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  fundigProfile() {
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Card(
          elevation: 2.0,
          color: AppColors.white_90,
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
                  ),
                  header: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Funding Profile",
                        style: FontStyle.primarySmallBold,
                      )),
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
                        const Text(
                          'abc:',
                          style: FontStyle.primarySmallBold,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  totalfund() {
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Card(
          elevation: 2.0,
          color: AppColors.white_90,
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
                  ),
                  header: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Total Funding to date",
                        style: FontStyle.primarySmallBold,
                      )),
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
                              'Amount:',
                              style: FontStyle.primarySmallBold,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            ),
                            const Text(
                              '10000:',
                              style: FontStyle.primarySmallBold,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  currentYear() {
    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Card(
          elevation: 2.0,
          color: AppColors.orange_90,
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
                  ),
                  header: const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Current Year Details",
                        style: FontStyle.primarySmallBold,
                      )),
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
                              '2022:',
                              style: FontStyle.primarySmallBold,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              '10000:',
                              style: FontStyle.textHeader,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              '2021:',
                              style: FontStyle.textHeader,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              '10000:',
                              style: FontStyle.textHeader,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
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
        centerTitle: false,
        backgroundColor: AppColors.primaryColor,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      height: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.orange_90,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 0),
                      child: const Text(
                        'Update Profile',
                        style: FontStyle.textButton2,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Singleton.instance
                                  .showPicker(context, pickedImage, false);
                            },
                            child: Container(
                              height: 152,
                              width: 140,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.grey_90),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              margin: const EdgeInsets.only(
                                  bottom: 10, left: 0, right: 5, top: 10),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _image != null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.file(
                                              _image!,
                                              width: 125,
                                              height: 125,
                                              fit: BoxFit.fill,
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              Singleton.instance.showPicker(
                                                  context, pickedImage, false);
                                            },
                                            child: const Icon(
                                              Icons.camera_alt_rounded,
                                              color: AppColors.black,
                                              size: 25,
                                            ),
                                          ),
                                    _image != null
                                        ? GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _image = null;
                                              });
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: const [
                                                Icon(
                                                  Icons.delete,
                                                  color: Colors.black45,
                                                  size: 15,
                                                ),
                                              ],
                                            ))
                                        : GestureDetector(
                                            onTap: () {
                                              Singleton.instance.showPicker(
                                                  context, pickedImage, false);
                                            },
                                            child: Text(
                                              'Add',
                                              style: FontStyle.textHint
                                                  .copyWith(
                                                      color: AppColors.black),
                                            )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 200,
                            padding: const EdgeInsets.only(left: 15),
                            margin: const EdgeInsets.only(bottom: 5, left: 10),
                            decoration: BoxDecoration(
                              color: AppColors.orange_90,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Prinyanka Yadav',
                                  style: FontStyle.textHint2,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.edit,
                                    size: 15,
                                    color: AppColors.green_00,
                                  ),
                                )
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
                  ],
                ),
                BasicInformation(),
                schoolreport(),
                Container(
                  height: 40,
                  width: double.infinity,
                  alignment: Alignment.bottomRight,
                  margin: const EdgeInsets.only(
                      top: 10, left: 10, right: 10, bottom: 15),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.off(const StudentProfile());
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.orange_90),
                    child: const Text(
                      'Submit',
                      style: FontStyle.textButton2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
