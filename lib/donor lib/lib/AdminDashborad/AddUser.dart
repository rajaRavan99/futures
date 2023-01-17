import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:donor/Library/TextStyle.dart';
import 'package:donor/model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import '../Library/ApiData.dart';
import '../Library/AppColors.dart';
import '../Library/Utils.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key, this.userModel, this.uId}) : super(key: key);
  final UserModel? userModel;
  final String? uId;

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final _formKey = GlobalKey<FormState>();
  UserModel uData = UserModel();
  List<UserModel> aList = [];

  String? emptyValidator(value) {
    if (value.isEmpty) {
      return 'Field is Required';
    }
    return null;
  }

  int utype = 3;

  Future addUser() async {
    Utils().loading(context);
    try {
      var data = {};
      data['uid'] = widget.uId;
      data['utype'] = uData.utype.toString();
      data['fname'] = uData.fname;
      data['lname'] = uData.lname;
      data['uemail'] = uData.uemail;
      data['umobile'] = "+${countryData.phoneCode}${uData.umobile}";

      var res = await ApiData().postData('add_user', data);
      if (res['st'] == 'success') {
        if (!mounted) return;
        Utils().successSnack(context, "User Added Successfully");
      } else {
        if (!mounted) return;
        Utils().errorSnack(context, res["msg"]);
      }
    } catch (e) {
      print('print error: $e');
      Utils().errorSnack(context, "Internal Server Error");
    }
  }

  Country countryData = CountryPickerUtils.getCountryByPhoneCode('91');

  void openCountryPickerDialog() => showDialog(
      context: context,
      builder: (context) {
        return Theme(
          data:
              Theme.of(context).copyWith(primaryColor: AppColors.primaryColor),
          child: CountryPickerDialog(
            searchCursorColor: Colors.black,
            divider: const Divider(
              height: 5,
              color: AppColors.grey_10,
              thickness: 0.1,
            ),
            searchInputDecoration:
                Utils().inputSmallDecoration("Search Country").copyWith(
                      suffixIcon: const Icon(
                        Icons.search_rounded,
                        color: AppColors.black,
                      ),
                    ),
            isSearchable: true,
            title: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Select your phone code',
                style: FontStyle.textBold,
              ),
            ),
            onValuePicked: (Country country) =>
                setState(() => countryData = country),
            itemBuilder: (Country country) {
              return Row(
                children: <Widget>[
                  const SizedBox(width: 8.0),
                  Text(
                    "+${country.phoneCode}",
                    style: FontStyle.textBold,
                  ),
                  const SizedBox(width: 8.0),
                  Flexible(
                      child: Text(country.name, style: FontStyle.textLabel)),
                ],
              );
            },
            priorityList: [
              CountryPickerUtils.getCountryByIsoCode('IN'),
              CountryPickerUtils.getCountryByIsoCode('DE'),
            ],
          ),
        );
      });

  @override
  void initState() {
    super.initState();
    if (widget.userModel != null) {
      uData = widget.userModel!;
    } else {
      uData.utype = '3';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add User',
          style: FontStyle.appBarText,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User Type',
                        style: FontStyle.inputform,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Radio(
                                activeColor: AppColors.primaryColor,
                                value: '3',
                                groupValue: uData.utype,
                                onChanged: (value) {
                                  setState(() {
                                    uData.utype = value.toString();
                                  });
                                },
                              ),
                              Text(
                                'Sub Admin',
                                style: FontStyle.inputform,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                activeColor: AppColors.primaryColor,
                                value: '4',
                                groupValue: uData.utype,
                                onChanged: (value) {
                                  setState(() {
                                    uData.utype = value.toString();
                                  });
                                },
                              ),
                              Text(
                                'Teacher',
                                style: FontStyle.inputform,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'First Name',
                        style: FontStyle.inputform,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                            top: 1, left: 0, right: 0, bottom: 10),
                        child: TextFormField(
                            initialValue: uData.fname,
                            textInputAction: TextInputAction.next,
                            style: FontStyle.inputform,
                            onSaved: (newValue) {
                              setState(() {
                                uData.fname = newValue;
                              });
                            },
                            validator: emptyValidator,
                            decoration: Utils()
                                .inputDecoration(
                                  'Enter First Name',
                                )
                                .copyWith()),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Last Name',
                        style: FontStyle.inputform,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                            top: 1, left: 0, right: 0, bottom: 10),
                        child: TextFormField(
                            initialValue: uData.lname,
                            textInputAction: TextInputAction.next,
                            style: FontStyle.inputform,
                            onSaved: (newValue) {
                              setState(() {
                                uData.lname = newValue;
                              });
                            },
                            validator: emptyValidator,
                            decoration: Utils()
                                .inputDecoration(
                                  'Enter Last Name',
                                )
                                .copyWith()),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Email',
                        style: FontStyle.inputform,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                          top: 5,
                        ),
                        child: TextFormField(
                          style: FontStyle.inputform,
                          initialValue: uData.uemail,
                          textInputAction: TextInputAction.next,
                          decoration: Utils().inputDecoration("Enter Email"),
                          onSaved: (newValue) {
                            setState(() {
                              uData.uemail = newValue;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Enter Email ";
                            } else if (!GetUtils.isEmail(value)) {
                              return "Please Enter Valid Email";
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Mobile Number',
                        style: FontStyle.inputform,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                          top: 10,
                        ),
                        child: TextFormField(
                          style: FontStyle.inputform,
                          initialValue: uData.umobile,
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if ((value ?? "") == "") {
                              return "Please Mobile No";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (newValue) {
                            setState(() {
                              uData.umobile = newValue;
                            });
                          },
                          decoration: Utils()
                              .inputDecoration("Enter Mobile No")
                              .copyWith(
                                prefixIcon: GestureDetector(
                                  onTap: () {
                                    openCountryPickerDialog();
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        child: Center(
                                            child: Text(
                                                "+${countryData.phoneCode}",
                                                style: FontStyle.textInput
                                                    .copyWith())),
                                      ),
                                      const SizedBox(
                                        height: 45.0,
                                        child: VerticalDivider(
                                          color: AppColors.black,
                                          indent: 10,
                                          endIndent: 10,
                                          thickness: 1,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                InkWell(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    final form = _formKey.currentState;
                    if (form!.validate()) {
                      form.save();
                      addUser();
                      Navigator.of(context).pop;
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
