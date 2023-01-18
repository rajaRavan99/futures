// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:cfsys/singletoneclass.dart';
import 'package:cfsys/stylepage/textstyles.dart';
import 'package:cfsys/userform.dart';

import 'colors.dart';
import 'user.dart';

class EmptyState extends StatefulWidget {
  final String title, message;
  final String index;
  EmptyState({
    Key? key,
    required this.message,
    required this.index,
    required this.title,
  }) : super(key: key);

  @override
  State<EmptyState> createState() => _EmptyStateState();
}

class _EmptyStateState extends State<EmptyState> {
  File? _image;
  String? imagepath;
  var itemlist = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];

  TextEditingController oty = TextEditingController(text: '');
  TextEditingController invoicedate = TextEditingController(text: '');

  int itemcount = 1;
  // ignore: unused_element
  void _incrementCounter() {
    setState(() {
      itemcount++;
    });
  }

  List<UserForm> users = [];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                      top: 20, bottom: 5, left: 25, right: 15),
                  padding: const EdgeInsets.all(4),
                  // height: 40,
                  width: double.infinity,
                  child: TextFormField(
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    controller: invoicedate,
                    decoration: InputDecoration(
                      labelText: "Invoice No",
                      labelStyle: CustomTextStyle.style1,
                    ),
                  ),
                ),
              ),

              // date selection form :-
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(
                      top: 20, bottom: 5, left: 0, right: 15),

                  width: double.infinity,
                  // color: Colors.black,
                  child: DateTimePicker(
                    type: DateTimePickerType.date,
                    dateMask: 'd MMM, yyyy',
                    // initialValue: DateTime.now().toString(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    icon: const Icon(
                      Icons.event,
                      color: Colors.black54,
                    ),
                    dateLabelText: 'Date', style: CustomTextStyle.style1,

                    // timeLabelText: "Hour",
                    selectableDayPredicate: (date) {
                      // Disable weekend days to select from the calendar
                      if (date.weekday == 6 || date.weekday == 7) {
                        return false;
                      }

                      return true;
                    },
                    onChanged: (val) => print(val),
                    validator: (val) {
                      print(val);
                      return null;
                    },
                    onSaved: (val) => print(val),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin:
                const EdgeInsets.only(top: 10, bottom: 5, left: 25, right: 15),
            padding: const EdgeInsets.all(4),
            height: 40,
            width: double.infinity,
            child: DropdownButton(
              // value: selecteddata,
              hint: Text(
                "Select Party",
                style: CustomTextStyle.style1,
              ),
              underline: Container(),
              isExpanded: true,
              iconEnabledColor: Colors.black,
              dropdownColor: Colors.white,
              focusColor: Colors.black,
              items: itemlist.map((String items) {
                return DropdownMenuItem(value: items, child: Text(items));
              }).toList(),
              onChanged: (
                selecteddata,
              ) {
                // setState(() {
                //   initialValue = Text;
                // });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 30),
                child: Column(
                  children: [
                    Container(
                        height: 150,
                        width: 125,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.grey_90),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.only(
                            bottom: 20, left: 0, right: 5, top: 10),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _image != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        _image!,
                                        width: 125,
                                        height: 148,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        Singleton.instance.showPicker(
                                            context, pickedImage, false);
                                      },
                                      child: Icon(Icons.add_a_photo),
                                    ),
                              // Text(
                              //   'Click Here',
                              //   style: CustomTextStyle.bigtextblack,
                              // ),
                            ],
                          ),
                        )),
                    GestureDetector(
                      onTap: () {
                        Singleton.instance
                            .showPicker(context, pickedImage, false);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.grey_90,
                        ),
                        height: 35,
                        width: 100,
                        child: Center(
                          child: Text(
                            "+ Add Photo",
                            style: CustomTextStyle.style4444,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          bottom: 10, left: 60, right: 5, top: 10),
                      child: Text(
                        widget.index.toString(),
                        style: CustomTextStyle.bigtextblack,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          top: 5, bottom: 5, left: 0, right: 0),
                      width: 150,
                      child: TextFormField(
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                        controller: oty,
                        decoration: InputDecoration(
                          labelText: "Oty",
                          labelStyle: CustomTextStyle.style111,
                          // enabledBorder: OutlineInputBorder(
                          //   borderSide: const BorderSide(
                          //     width: 2,
                          //     color: Colors.red,
                          //   ),
                          //   borderRadius: BorderRadius.circular(15),
                          // ),
                        ),
                      ),
                    ),
                    Container(
                      // margin: const EdgeInsets.only(
                      //     top: 20, bottom: 5, left: 15, right: 15),
                      width: 150,
                      child: DateTimePicker(
                        type: DateTimePickerType.date,
                        dateMask: 'd MMM, yyyy',
                        // initialValue: DateTime.now().toString(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        // icon: Icon(
                        //   Icons.event,
                        //   color: Colors.black54,
                        // ),
                        dateLabelText: 'Date',
                        style: CustomTextStyle.style111,
                        // timeLabelText: "Hour",
                        selectableDayPredicate: (date) {
                          // Disable weekend days to select from the calendar
                          if (date.weekday == 6 || date.weekday == 7) {
                            return false;
                          }

                          return true;
                        },
                        onChanged: (val) => print(val),
                        validator: (val) {
                          print(val);
                          return '';
                        },
                        onSaved: (val) => print(val),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void onAddForm(index) {
    setState(() {
      var _user = User();
      users.add(UserForm(
        user: _user,
        onDelete: () => onDelete(_user),
        index: index,
      ));
    });
  }

  void onDelete(User _user) {
    setState(() {
      var find = users.firstWhere(
        (it) => it.user == _user,
        orElse: () => null!,
      );
      if (find != null) users.removeAt(users.indexOf(find));
    });
  }

  void pickedImage(ImageSource imageSource) {
    Singleton.instance.pickImage(imageSource).then(
          (value) => setState(
            () {
              if (value == null) {
              } else {
                _image = value;
                setState(() {});
              }
            },
          ),
        );
  }
}
