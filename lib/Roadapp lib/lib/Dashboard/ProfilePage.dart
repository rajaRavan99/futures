import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roadapp/Library/TextStyle.dart';
import 'package:flutter/material.dart';
import '../Authentication/ProfileUpdate.dart';
import '../Library/ApiData.dart';
import '../Library/AppColors.dart';
import '../Library/ManageStorage.dart';
import '../Library/Utils.dart';
import '../Model/Imagemodel.dart';
import '../Model/ProfileModel.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  UserModel udata = UserModel();
  bool imgLoading = false;
  var pPhoto = "";
  late Future fetchData;

  @override
  void initState() {
    fetchData = getProfile();
    super.initState();
  }

  getProfile() async {
    try {
      String aaid = await AppStorage.getData('aaid') ?? "";
      var data = {};
      data['aaid'] = aaid;
      var res = await ApiData().postData('get_student_profile', data);
      print(res);
      if (res['st'] == 'success') {
        udata = UserModel.fromJson(res['data']);
      } else {
        if (!mounted) return;
        Utils().errorSnack(context, res["msg"]);
      }
    } catch (e) {
      print('print error: $e');
      Utils().errorSnack(context, "Internal Server Error");
    }
    return udata;
  }

  uploadProfile() async {
    setState(() {
      imgLoading = true;
    });
    var img = await Utils().pickImage(ImageSource.gallery);
    // await Utils().pickImage(ImageSource.camera);
    ImageModel fImage = await Utils().uploadImage(img.toString(), 'profile');
    print('${fImage.h_path}${fImage.imgpath}');
    pPhoto = '${fImage.h_path}${fImage.imgpath}';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        titleSpacing: 0,
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Text("Profile Page", style: FontStyle.textHeader),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileUpdate()));
            },
            child: Image.asset(
              "assets/image/profileupdate.png",
              height: 45,
              width: 45,
              color: AppColors.white_00,
            ),
          ),
        ],
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: fetchData,
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
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () async {
                            await imageUpload(context);
                          },
                          child: Container(
                            height: 125,
                            width: 125,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: AppColors.grey_09, width: 1.5)),
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: (udata.uphoto ?? ImageModel())
                                    .h_path
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
                          style: FontStyle.textHint
                              .copyWith(color: AppColors.black, fontSize: 14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Row(
                            children: const [
                              Expanded(
                                child: Text(
                                  "Name",
                                  style: FontStyle.textLabel,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.grey_09,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(((udata.uname) ?? "".toString()),
                                      style: FontStyle.textInput),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Row(
                            children: const [
                              Expanded(
                                child: Text(
                                  "Mobile Number",
                                  style: FontStyle.textLabel,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.grey_09,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                      ((udata.umobile) ?? "".toString()),
                                      style: FontStyle.textInput),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Row(
                            children: const [
                              Expanded(
                                child: Text(
                                  "Email",
                                  style: FontStyle.textLabel,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.grey_09,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(((udata.uemail) ?? "".toString()),
                                      style: FontStyle.textInput),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Row(
                            children: const [
                              Expanded(
                                child: Text(
                                  "Address",
                                  style: FontStyle.textLabel,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.grey_09,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                      ((udata.uaddress) ?? "".toString()),
                                      style: FontStyle.textInput),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Row(
                            children: const [
                              Expanded(
                                child: Text(
                                  "City",
                                  style: FontStyle.textLabel,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.grey_09,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(((udata.ucity) ?? "".toString()),
                                      style: FontStyle.textInput),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Row(
                            children: const [
                              Expanded(
                                child: Text(
                                  "State",
                                  style: FontStyle.textLabel,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.grey_09,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(((udata.ustate) ?? "".toString()),
                                      style: FontStyle.textInput),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
