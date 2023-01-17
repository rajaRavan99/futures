import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:roadapp/Library/TextStyle.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:open_filex/open_filex.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Model/Imagemodel.dart';
import 'ApiData.dart';
import 'AppColors.dart';
import 'AppConstant.dart';
import 'ManageStorage.dart';
import 'TextStyle.dart';

class Utils extends GetxController implements GetxService {
  String logo = "assets/image/logo2.png";
  String get gelLogo => logo;
  bool auth = false;
  bool get authData => auth;

  void checkMode() async {
    var mode1 = await AppStorage.getData("mode") ?? "0";
    var auth1 = await AppStorage.getData("auth") ?? "0";
    print(mode1);
    if (mode1 == '1') {
      logo = 'assets/image/logo2.png';
    } else {
      logo = 'assets/image/logo.png';
    }

    print("auth $auth1");
    if (auth1 == "1") {
      auth = true;
    } else {
      auth = false;
    }
    update();
  }

  Decoration dropdownDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      border: Border.all(color: AppColors.primaryColor, width: 1.5),
    );
  }

  InputDecoration mobile_decoration(String msg) {
    return InputDecoration(
      errorStyle: FontStyle.textError,
      counterText: "",
      filled: true,
      fillColor: Colors.white,
      hintText: msg,
      hintStyle: FontStyle.textHint,
      isDense: true,
      //contentPadding: const EdgeInsets.only(left: 14.0, bottom: 15.0, top: 1.0,right: 10),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          width: 1.5,
          color: AppColors.black,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: AppColors.grey_09,
          width: 1.5,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: AppColors.red_55,
          width: 1.5,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: AppColors.red_55,
          width: 1.5,
        ),
      ),
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

  InputDecoration inputDecoration(String msg) {
    return InputDecoration(
      errorStyle: FontStyle.textError,
      hintText: msg,
      hintStyle: FontStyle.textHint,
      counterText: "",
      isDense: true,
      contentPadding:
          const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 10),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          width: 1.5,
          color: AppColors.black,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: AppColors.grey_09,
          width: 1.5,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: AppColors.red_55,
          width: 1.5,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: AppColors.red_55,
          width: 1.5,
        ),
      ),
    );
  }

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

  pickImage(ImageSource pickImage) async {
    var imagePicker = ImagePicker();
    dynamic pickedFile;
    try {
      pickedFile = await imagePicker.pickImage(
          source: pickImage, imageQuality: 60, maxHeight: 150, maxWidth: 150);
    } catch (e) {
      if (kDebugMode) {
        print('aaaaaaaaaaaaaaaaaaaaaa');
        print(e.toString());
      }
    }
    return pickedFile != null ? pickedFile!.path : "";
  }

  Future uploadImage(file, module) async {
    var user_data = {};
    user_data['module'] = module;
    ImageModel img = ImageModel();
    var res = await ApiData().upload_data(user_data, 'upload_img', file);
    if (res['st'] == "success") {
      print(res);
      print('UploadImageutilsfunction');
      img = ImageModel.fromJson(res['image']);
      print(img);
      print(res['image']);
    }
    return img;
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

  primaryButton(String txt, width) {
    return Container(
      height: 50,
      width: width,
      decoration: const ShapeDecoration(
          color: AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          )),
      child: Center(
        child: Text(
          txt,
          style: FontStyle.textButton,
        ),
      ),
    );
  }

  loadingWidget() {
    return const Center(
      child: SpinKitThreeBounce(
        color: AppColors.primaryColor,
        size: 30.0,
      ),
    );
  }

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
                      CircularProgressIndicator(color: AppColors.primaryColor),
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
                      'Are you sure you want to quit this app?',
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

  bottomBar(context) {
    return Container(
      height: 90,
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () {},
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .20,
                height: 85,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/image/payment.png",
                      height: 22.0,
                      width: 22.0,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "Payment Instructions",
                      style: FontStyle.textLabelSmall
                          .copyWith(color: AppColors.white_00),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const VerticalDivider(
              width: 5.0,
              color: AppColors.primaryColorLight,
              thickness: 0.5,
            ),
            InkWell(
              onTap: () {},
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .20,
                height: 85,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/image/about.png",
                      height: 22.0,
                      width: 22.0,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "About Kavir Diamonds",
                      style: FontStyle.textLabelSmall
                          .copyWith(color: AppColors.white_00),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const VerticalDivider(
              width: 5.0,
              color: AppColors.primaryColorLight,
              thickness: 0.5,
            ),
            InkWell(
              onTap: () {},
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .20,
                height: 85,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/image/contact.png",
                      height: 22.0,
                      width: 22.0,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "Contact Us",
                      style: FontStyle.textLabelSmall
                          .copyWith(color: AppColors.white_00),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const VerticalDivider(
              width: 5.0,
              color: AppColors.primaryColorLight,
              thickness: 0.5,
            ),
            InkWell(
              onTap: () {},
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .20,
                height: 85,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/image/feedback.png",
                      height: 22.0,
                      width: 22.0,
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Text(
                      "Feedback",
                      style: FontStyle.textLabelSmall
                          .copyWith(color: AppColors.white_00),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  commonBottom(context, bool cart, bool wish, bool inq, bool confirm, pcsList,
      allStone) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: const BoxDecoration(
        color: AppColors.white_00,
        boxShadow: [
          BoxShadow(
            color: Colors.grey, //New
            blurRadius: 5,
            offset: Offset(0, -0),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Visibility(
                    visible: cart,
                    child: InkWell(
                      onTap: () {
                        if (pcsList.isNotEmpty) {
                          ApiData().addToCart(context, pcsList.join(","));
                        } else {
                          Utils().errorSnack(context, "No stone selected.");
                        }
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey, //New
                              blurRadius: 5,
                              offset: Offset(0, 0),
                            )
                          ],
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.add_shopping_cart_rounded,
                            color: AppColors.white_00,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: wish,
                    child: InkWell(
                      onTap: () {
                        if (pcsList.isNotEmpty) {
                          ApiData().addToWatchList(context, pcsList.join(","));
                        } else {
                          Utils().errorSnack(context, "No stone selected.");
                        }
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey, //New
                              blurRadius: 5,
                              offset: Offset(0, 0),
                            )
                          ],
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.bookmark_add_rounded,
                            color: AppColors.white_00,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: inq,
                    child: InkWell(
                      onTap: () async {
                        if (pcsList.isNotEmpty) {
                          var fText = "";
                          List<String> dataList = [];
                          for (var pcsId in pcsList) {
                            print(pcsId);
                            var dd = allStone
                                .where((element) =>
                                    element.PcsID.toString() ==
                                    pcsId.toString())
                                .first;
                            print(dd.PcsID);
                            var sText =
                                "${dd.Shape}  ${dd.Cts}  ${dd.Color}  ${dd.Clarity}  ${dd.Cut}-${dd.Polish}-${dd.Sym}-${dd.fluo} (${dd.PcsID})";
                            dataList.add(sText);
                            fText = dataList.join("\n\n");
                          }
                          var link =
                              "whatsapp://send?phone=${AppConstant.inquiryPhoneNo}&text=$fText";
                          await launchUrl(Uri.parse(link));
                        } else {
                          Utils().errorSnack(context, "No stone selected.");
                        }
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey, //New
                              blurRadius: 5,
                              offset: Offset(0, 0),
                            )
                          ],
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.info_outline_rounded,
                            color: AppColors.white_00,
                            size: 25,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: confirm,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                  onPressed: () {
                    ApiData().confirmOrder(context, pcsList.join(","));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  child: Text(
                    'Confirm Order',
                    style: FontStyle.textButton.copyWith(fontSize: 12),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Future fileDownload(context, url) async {
    var returnPath = "";
    loading(context);
    try {
      String? imgPath = url;
      var bytes = (await NetworkAssetBundle(Uri.parse(imgPath!)).load(imgPath))
          .buffer
          .asUint8List();
      var path = "/storage/emulated/0/Download/";
      var filename = imgPath.split('/');
      var savePath = '$path/${filename[filename.length - 1]}';
      final file = File(savePath);
      var fileSave = await file.writeAsBytes(bytes);
      returnPath = fileSave.path;
      OpenFilex.open(savePath);
    } catch (e) {
      print("Download Error : $e");
      errorSnack(context, "Download Failed !");
    }
    Navigator.pop(context);
    return returnPath;
  }
}
