import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roadapp/Dashboard/ProfilePage.dart';
import 'package:roadapp/Library/ManageStorage.dart';
import 'package:roadapp/Library/TextStyle.dart';
import '../Library/ApiData.dart';
import '../Library/AppColors.dart';
import '../Library/MyNavigator.dart';
import '../Library/Utils.dart';
import '../Model/Imagemodel.dart';
import '../Model/ProfileModel.dart';
import 'otp.dart';

class ProfileUpdate extends StatefulWidget {
  const ProfileUpdate({Key? key}) : super(key: key);

  @override
  _ProfileUpdateState createState() => _ProfileUpdateState();
}

class _ProfileUpdateState extends State<ProfileUpdate> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var pPhoto = "";

  var udata = UserModel();
  bool imgLoading = false;
  late Future fetchProfile;
  final _formKey = GlobalKey<FormState>();
  TextEditingController mobileController = TextEditingController();

  uploadProfile() async {
    setState(() {
      imgLoading = true;
    });
    var img = await Utils().pickImage(ImageSource.gallery);
    ImageModel fImage = await Utils().uploadImage(img.toString(), 'profile');
    print('${fImage.h_path}${fImage.imgpath}');
    pPhoto = '${fImage.h_path}${fImage.imgpath}';
    print(pPhoto);
    udata.uphoto = fImage;
    setState(() {
      imgLoading = false;
    });
  }

  imageUpload(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width - 200,
            child: AlertDialog(
              insetPadding: const EdgeInsets.all(60.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              content: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Upload Image',
                      textAlign: TextAlign.center,
                      style: FontStyle.popText,
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 42,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.primaryColor,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              uploadProfile();
                            },
                            child: Text("Gallery",
                                style: FontStyle.textButtonPrimary
                                    .copyWith(color: AppColors.white_00)),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 42,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100.0),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.primaryColor,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              Utils().pickImage(ImageSource.camera);
                            },
                            child: Text("Camera",
                                style: FontStyle.textButtonPrimary
                                    .copyWith(color: AppColors.white_00)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  updateProfile() async {
    try {
      var data = {};
      data['utype'] = 'student';
      data['fname'] = udata.uname;
      data['lname'] = 'lastname';
      data['umobile'] = udata.umobile;
      data['uemail'] = udata.uemail;
      data['address'] = udata.uaddress;
      data['city'] = udata.ucity;
      data['uphoto'] = json.encode(udata.uphoto);
      data['state'] = udata.ustate;
      data['country_code'] = '91';
      print(data);
      var res = await ApiData().postData('update_profile', data);
      print(res);
      if (res['st'] == 'success') {
        if (!mounted) return;
        Utils().successSnack(context, "You are successfully registered.");
        Navigator.of(context).pop();
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => const ProfilePage(),
        //     ),
        //     );
        // MyNavigator.goToDashBoard(context);
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
    fetchProfile = updateProfile();
    AppStorage.getData('aaid');
    print((AppStorage.getData('aaid')));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          titleSpacing: 5,
          title: Text("Profile Update", style: FontStyle.textHeader),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_rounded,
                color: AppColors.white_00, size: 20),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
        ),
        body: FutureBuilder(
            future: fetchProfile,
            builder: (context, snapshot) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                : InkWell(
                                    onTap: () {
                                      uploadProfile();
                                    },
                                    child: Container(
                                      height: 125,
                                      width: 125,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: AppColors.grey_09,
                                              width: 1.5)),
                                      child: ClipOval(
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              (udata.uphoto ?? ImageModel())
                                                  .showpath
                                                  .toString(),
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
                                  ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            uploadProfile();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                                pPhoto != "" ? 'Change Photo' : "Upload Photo",
                                style: FontStyle.textHint.copyWith(
                                    color: AppColors.black, fontSize: 14)),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Row(
                                children: const [
                                  Expanded(
                                      child: Text(
                                    "Name",
                                    style: FontStyle.textLabel,
                                  )),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              maxLines: 1,
                              style: FontStyle.textInput,
                              initialValue: (udata.uname ?? "").toString(),
                              decoration: Utils().inputDecoration('Name'),
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              onSaved: (val) {
                                setState(() {
                                  udata.uname = val;
                                  print(val);
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return " Filed can't be Empty";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Row(
                                children: const [
                                  Expanded(
                                      child: Text("Mobile Number",
                                          style: FontStyle.textLabel)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              maxLength: 10,
                              initialValue: (udata.umobile ?? "").toString(),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textInputAction: TextInputAction.next,
                              style: FontStyle.textInput,
                              decoration: Utils()
                                  .mobile_decoration('Mobile Number')
                                  .copyWith(
                                    prefixIcon: SizedBox(
                                      width: 60,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: const [
                                          Text("+91",
                                              style: FontStyle.textInput),
                                          SizedBox(
                                            height: 15,
                                            child: VerticalDivider(
                                              color: Colors.grey,
                                              thickness: 1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              validator: (value) {
                                if (value!.isEmpty || value.length != 10) {
                                  return " Mobile Number invalid";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.number,
                              onSaved: (val) {
                                setState(() {
                                  udata.umobile = val;
                                  print(val);
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Row(
                                children: const [
                                  Expanded(
                                      child: Text("Email",
                                          style: FontStyle.textLabel)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              style: FontStyle.textInput,
                              initialValue: (udata.uemail ?? "").toString(),
                              textInputAction: TextInputAction.next,
                              decoration:
                                  Utils().inputDecoration('Email Address'),
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (val) {
                                setState(() {
                                  udata.uemail = val;
                                  print(val);
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return " Filed can't be Empty";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Row(
                                children: const [
                                  Expanded(
                                      child: Text("Address",
                                          style: FontStyle.textLabel)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              style: FontStyle.textInput,
                              initialValue: (udata.uaddress ?? "").toString(),
                              decoration: Utils().inputDecoration('Address'),
                              keyboardType: TextInputType.streetAddress,
                              textInputAction: TextInputAction.next,
                              onSaved: (val) {
                                setState(() {
                                  udata.uaddress = val;
                                  print(val);
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return " Filed can't be Empty";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Row(
                                children: const [
                                  Expanded(
                                      child: Text("City",
                                          style: FontStyle.textLabel)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              style: FontStyle.textInput,
                              textInputAction: TextInputAction.next,
                              initialValue: (udata.ucity ?? "").toString(),
                              decoration: Utils().inputDecoration('City'),
                              keyboardType: TextInputType.text,
                              onSaved: (val) {
                                setState(() {
                                  udata.ucity = val;
                                  print(val);
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return " Filed can't be Empty";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Row(
                                children: const [
                                  Expanded(
                                      child: Text("State",
                                          style: FontStyle.textLabel)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            TextFormField(
                              style: FontStyle.textInput,
                              textInputAction: TextInputAction.done,
                              initialValue: (udata.ustate ?? "").toString(),
                              decoration: Utils().inputDecoration('State'),
                              keyboardType: TextInputType.text,
                              onSaved: (val) {
                                setState(() {
                                  udata.ustate = val;
                                  print(val);
                                });
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return " Filed can't be Empty";
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            final form = _formKey.currentState;
                            if (form!.validate()) {
                              form.save();
                              updateProfile();
                            }
                          },
                          child: Utils().primaryButton("Profile Update",
                              MediaQuery.of(context).size.width * 0.7),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
