import 'dart:io';
import 'package:cfsys/colors.dart';
import 'package:cfsys/singletoneclass.dart';
import 'package:cfsys/stylepage/textstyles.dart';
import 'package:cfsys/user.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

typedef OnDelete();

class UserForm extends StatefulWidget {
  final User user;
  final int index;
  final state = _UserFormState();
  final OnDelete onDelete;

  UserForm({
    Key? key,
    required this.user,
    required this.index,
    required this.onDelete,
  }) : super(key: key);
  @override
  _UserFormState createState() => state;

  bool isValid() => state.validate();
}

class _UserFormState extends State<UserForm> {
  File? _image;
  String? imagepath;

  List<UserForm> users = [];
  var itemlist = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];

  int _itemcount = 0;
  void _incrementCounter() {
    setState(() {
      _itemcount++;
    });
  }

  TextEditingController oty = TextEditingController(text: '');
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      // clipBehavior: Clip.antiAlias,
      // borderRadius: BorderRadius.circular(8),
      child: SingleChildScrollView(
        child: Form(
          key: form,
          child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              centerTitle: true,
              actions: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 7),
                  child: Row(
                    children: [
                      Container(
                        height: 2,
                        width: context.width * 0.7,
                        margin: const EdgeInsets.only(
                            top: 10, left: 0, right: 2, bottom: 10),
                        color: AppColors.grey_20,
                      ),
                      Container(
                        height: 40,
                        width: 40,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: AppColors.red_50,
                          borderRadius: BorderRadius.circular(50),
                          // border: Border.all(width: 2, color: AppColors.red_00),
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            size: 20,
                            color: AppColors.white,
                          ),
                          onPressed: widget.onDelete,
                        ),
                      ),
                      Container(
                        height: 2,
                        width: context.width * 0.1,
                        margin: const EdgeInsets.only(
                            top: 10, left: 0, right: 4, bottom: 10),
                        color: AppColors.grey_20,
                      ),
                    ],
                  ),
                )
              ],
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
            const SizedBox(
              height: 20,
            )
          ]),
        ),
      ),
    );
  }

  ///form validator
  bool validate() {
    var valid = form.currentState!.validate();
    if (valid) form.currentState!.save();
    return valid;
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
