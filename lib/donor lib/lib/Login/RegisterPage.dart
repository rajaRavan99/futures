import 'dart:convert';
import 'package:donor/Library/TextStyle.dart';
import 'package:donor/Library/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../Library/ApiData.dart';
import '../Library/AppColors.dart';
import '../Library/ManageStorage.dart';
import '../Library/MyNavigator.dart';
import '../model/ImageModel.dart';
import '../model/UserModel.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  int utype = 1;

  bool value = false;
  bool isHidden = true;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController phoneController = TextEditingController();

  UserModel userModel = UserModel();
  var pPhoto = "";

  bool imgLoading = false;

  fetchNumber() async {
    phoneController.text = await AppStorage.getData('umobile');
  }

  userRegister() async {
    try {
      var data = {};
      data = {};
      data['fname'] = userModel.fname;
      data['lname'] = userModel.lname;
      data['umobile'] = userModel.umobile;
      data['uemail'] = userModel.uemail;
      data['uphoto'] = json.encode(userModel.uphoto);
      data['utype'] = utype.toString();
      var res = await ApiData().postData('update_profile', data);
      if (res['st'] == 'success') {
        if (!mounted) return;
        Utils().successSnack(context, "You are successfully registered.");
        MyNavigator().goToDashBoard(context);
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

    ImageModel fImage = await Utils().uploadImage(img.toString(), 'profile');
    print('${fImage.h_path}${fImage.imgpath}');
    pPhoto = '${fImage.h_path}${fImage.imgpath}';
    userModel.uphoto = fImage;
    setState(() {
      imgLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white_00,
      appBar: AppBar(
        title: const Text(
          'Registration',
          style: FontStyle.textLabelWhite,
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
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
                                    imageUrl: pPhoto,
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
                        InkWell(
                            onTap: () {
                              uploadProfile();
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
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              utype = 1;
                            });
                          },
                          child: Radio(
                            activeColor: AppColors.primaryColor,
                            value: 1,
                            groupValue: utype,
                            onChanged: (value) {
                              setState(() {
                                utype = value!;
                              });
                            },
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              utype = 1;
                            });
                          },
                          child: const Text(
                            'Student/Parent',
                            style: FontStyle.textLabelPrimaryMedium,
                          ),
                        ),
                        Radio(
                          activeColor: AppColors.primaryColor,
                          value: 2,
                          groupValue: utype,
                          onChanged: (value) {
                            setState(() {
                              utype = value!;
                            });
                          },
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              utype = 2;
                            });
                          },
                          child: const Text(
                            'Donor',
                            style: FontStyle.textLabelPrimaryMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            style: FontStyle.inputform,
                            textInputAction: TextInputAction.next,
                            decoration: Utils().inputDecoration("First Name"),
                            onSaved: (newValue) {
                              setState(() {
                                userModel.fname = newValue;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter First Name';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextFormField(
                            style: FontStyle.inputform,
                            textInputAction: TextInputAction.next,
                            decoration: Utils().inputDecoration("Last Name"),
                            onSaved: (newValue) {
                              setState(() {
                                userModel.lname = newValue;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Last Name';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                        top: 5,
                      ),
                      child: TextFormField(
                        style: FontStyle.inputform,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        decoration: Utils().inputDecoration("Enter Email Id"),
                        onSaved: (newValue) {
                          setState(() {
                            userModel.uemail = newValue;
                          });
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Email ";
                          } else if (!GetUtils.isEmail(value)) {
                            return "Please Enter Valid Email";
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                        top: 5,
                      ),
                      child: TextFormField(
                        controller: phoneController,
                        style: FontStyle.inputform,
                        maxLength: 15,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        readOnly: true,
                        onSaved: (newValue) {
                          setState(() {
                            userModel.umobile = newValue;
                          });
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please Enter Contact Number";
                          }
                          return null;
                        },
                        decoration: Utils().inputDecoration("Contact Number"),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () {
                        final form = _formKey.currentState;
                        if (form!.validate()) {
                          form.save();
                          userRegister();
                        }
                      },
                      child: Utils().primaryButton(
                          'Save', MediaQuery.of(context).size.width),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
