import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import 'AppColors.dart';

import 'TextStyle.dart';

class Utils extends GetxController implements GetxService {
  String logo = "assets/image/logo2.png";

  String get gelLogo => logo;
  bool auth = false;

  bool get authData => auth;

  void showPicker(
    context,
    Function pickedImage,
    bool isNeedToShowRemoveProfilePhoto,
  ) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(13),
            topRight: Radius.circular(13),
          ),
        ),
        // enableDrag: true,
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),

              // color: Colors.pink,
              child: Wrap(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Icon(
                                Icons.photo_library,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Choose image",
                              ),
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Icon(
                                Icons.photo_camera,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Take a photo",
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (isNeedToShowRemoveProfilePhoto)
                    GestureDetector(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Icon(
                              Icons.delete,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Remove photo",
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        });
  }

  Decoration dropdownDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      border: Border.all(color: AppColors.primaryColor, width: 1.5),
    );
  }

  primaryButton(btnText, width) {
    return Container(
      height: 45,
      width: width,
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.transparent,
              offset: Offset(
                5.0,
                5.0,
              ),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ), //BoxShadow
            BoxShadow(
              color: Colors.transparent,
              offset: Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ), //BoxShadow
          ],
          borderRadius: BorderRadius.circular(16),
          color: AppColors.primaryColor),
      child: Center(
        child: Text(
          btnText,
          style: FontStyle.buttonTextWhite,
        ),
      ),
    );
  }

  primaryIconButton(IconData icon, btnText, width) {
    return Container(
      height: 45,
      width: width,
      decoration: BoxDecoration(
          // boxShadow: const [
          //   BoxShadow(
          //     color: AppColors.white_00,
          //     offset: Offset(
          //       5.0,
          //       5.0,
          //     ),
          //     blurRadius: 10.0,
          //     spreadRadius: 2.0,
          //   ), //BoxShadow
          //   BoxShadow(
          //     color: AppColors.black,
          //     offset: Offset(0.0, 0.0),
          //     blurRadius: 0.0,
          //     spreadRadius: 0.0,
          //   ), //BoxShadow
          // ],
          borderRadius: BorderRadius.circular(16),
          color: AppColors.primaryColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: AppColors.white_00,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            btnText,
            style: FontStyle.buttonTextWhite,
          ),
        ],
      ),
    );
  }

  loadingButton(width) {
    return Container(
      height: 45,
      width: width,
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: AppColors.white_00,
              offset: Offset(
                5.0,
                5.0,
              ),
              blurRadius: 10.0,
              spreadRadius: 2.0,
            ), //BoxShadow
            BoxShadow(
              color: AppColors.black,
              offset: Offset(0.0, 0.0),
              blurRadius: 0.0,
              spreadRadius: 0.0,
            ), //BoxShadow
          ],
          borderRadius: BorderRadius.circular(10),
          color: AppColors.primaryColor),
      child: const Center(
          child: SpinKitThreeBounce(
        size: 30,
        color: AppColors.white_00,
      )),
    );
  }

  InputDecoration loginFormDecoration(String msg) {
    return InputDecoration(
      contentPadding: EdgeInsets.zero,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.white_00, width: 2)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.white_00, width: 2)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.white_00, width: 1.5)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.white_00, width: 1.5)),
      filled: true,
      fillColor: AppColors.primaryColor,
      errorStyle: FontStyle.textError.copyWith(color: AppColors.white_00),
      hintText: msg,
      hintStyle:
          FontStyle.textHint.copyWith(color: AppColors.primaryColorLight),
    );
  }

  InputDecoration inputDecoration(String msg,bool isLabel) {
    return InputDecoration(
      errorStyle: FontStyle.textError,
      hintText: msg,
      hintStyle: FontStyle.textHintform,
      counterText: "",
      labelText: isLabel?msg:null,
      // labelStyle: FontStyle.textHeaderBB,
      isDense: true,
      contentPadding:
          const EdgeInsets.only(top: 0, bottom: 0, left: 10, right: 10),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          width: 2,
          color: AppColors.grey_10,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.grey_10,
          width: 2,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.grey_10,
          width: 2,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: AppColors.grey_10,
          width: 2,
        ),
      ),
    );
  }

  // InputDecoration inputDecoration(
  //   String msg,
  // ) {
  //   return InputDecoration(
  //     errorStyle: FontStyle.textError,
  //     hintText: msg,
  //     hintStyle: FontStyle.textHintform,
  //     counterText: "",
  //     // label: Text(labelmsg),
  //     // labelStyle: FontStyle.textHeader.copyWith(fontSize: 14),
  //     isDense: true,
  //     contentPadding:
  //         const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 10),
  //     focusedBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(10),
  //       borderSide: const BorderSide(
  //         width: 2,
  //         color: AppColors.grey_10,
  //       ),
  //     ),
  //     enabledBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(10),
  //       borderSide: const BorderSide(
  //         color: AppColors.grey_10,
  //         width: 2,
  //       ),
  //     ),
  //     border: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(10),
  //       borderSide: const BorderSide(
  //         color: AppColors.grey_10,
  //         width: 2,
  //       ),
  //     ),
  //     focusedErrorBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(10),
  //       borderSide: const BorderSide(
  //         color: AppColors.grey_10,
  //         width: 2,
  //       ),
  //     ),
  //   );
  // }

  InputDecoration inputSmallDecoration(String msg) {
    return InputDecoration(
      hintStyle: FontStyle.textHint,
      errorStyle: FontStyle.textError,
      hintText: msg,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
      ),
      filled: true,
      fillColor: AppColors.white_00,
    );
  }

  errorSnack(context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white_00,
                  ),
                  child: const Center(
                      child: Icon(
                    Icons.close_rounded,
                    color: AppColors.red_55,
                  ))),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * .7,
                child: Text(
                  msg,
                  style: FontStyle.snackText,
                )),
          ],
        ),
        duration: const Duration(milliseconds: 3500),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        backgroundColor: AppColors.red_55,
        width: MediaQuery.of(context).size.width * .9,
      ),
    );
  }

  successSnack(context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white_00,
                  ),
                  child: const Center(
                      child: Icon(
                    Icons.done,
                    color: AppColors.green_45,
                  ))),
            ),
            SizedBox(
                width: MediaQuery.of(context).size.width * .7,
                child: Text(
                  msg,
                  style: FontStyle.snackText,
                )),
          ],
        ),
        duration: const Duration(milliseconds: 3500),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        backgroundColor: AppColors.green_45,
        width: MediaQuery.of(context).size.width * .9,
      ),
    );
  }

  defaultSnack(context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width * .7,
                child: Text(
                  msg,
                  style: FontStyle.snackText,
                )),
          ],
        ),
        duration: const Duration(milliseconds: 3500),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        backgroundColor: AppColors.black,
        width: MediaQuery.of(context).size.width * .9,
      ),
    );
  }

  // loadingWidget(){
  //   return const Center(
  //     child: SpinKitThreeBounce(
  //       color: AppColors.primaryColor,
  //       size: 30.0,
  //     ),
  //   );
  // }

  noBack() {}

  loading(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {
              return noBack();
            },
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              content: Container(
                color: AppColors.white_00,
                height: 50,
                child: Center(
                  child: Row(
                    children: const [
                      SpinKitThreeBounce(
                        color: AppColors.primaryColor,
                        size: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Loading",
                        style: FontStyle.textLabel,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  onWillPop(BuildContext context) async {
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
                      'Add Category',
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
                              SystemNavigator.pop();
                            },
                            child: Text("Quit",
                                style: FontStyle.textButtonPrimary
                                    .copyWith(color: AppColors.white_00)),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 8.0),
                              child: Text("Cancel",
                                  style: FontStyle.textButtonPrimary),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  messagePop(BuildContext context, msg) async {
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
                    Text(
                      msg.toString(),
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
                            },
                            child: Text("Okay",
                                style: FontStyle.textButtonPrimary
                                    .copyWith(color: AppColors.white_00)),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
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

  noItem(text) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: FontStyle.noItemFoundText,
          )
        ],
      ),
    );
  }

  deletePop(context, onPressed, title, isWarning) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: FontStyle.textLabel.copyWith(fontSize: 15),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: isWarning
                            ? AppColors.red_55
                            : AppColors.primaryColor,
                        fixedSize: Size(MediaQuery.of(context).size.width, 30),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100))),
                    onPressed: () {
                      Navigator.pop(context);
                      onPressed();
                    },
                    child: Text(
                      "Delete",
                      style: FontStyle.textLabelWhite
                          .copyWith(fontFamily: 'SemiBold', letterSpacing: 0.8),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    borderRadius: BorderRadius.circular(100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 10.0),
                          child: Text(
                            "Cancel",
                            style: FontStyle.textLabelWhite.copyWith(
                                color: isWarning
                                    ? AppColors.red_55
                                    : AppColors.primaryColor,
                                fontFamily: 'SemiBold',
                                letterSpacing: 0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            alignment: Alignment.center,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          );
        });
  }
}
