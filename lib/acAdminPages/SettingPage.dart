import 'dart:async';
import 'dart:io';
import 'package:acadmin/Tushar/CameraPage.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:acadmin/Library/AppColors.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'SingletoneClass.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  TextEditingController controller = TextEditingController();
  String result = 'Scaned Data';
  String? _currentAddress;
  Position? _currentPosition;
  CameraController? cameraController;

  File? _image;
  String? imagepath;

  messagePop(BuildContext context, msg, msg2) async {
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
                      style: tStyle.textBlack,
                    ),
                    Text(
                      msg2.toString(),
                      textAlign: TextAlign.center,
                      style: tStyle.textBlack,
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SettingPage()),
                              );
                            },
                            child: Text("Okay",
                                style: tStyle.textBlack
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

  Future qrScanner() async {
    String barcodeScanRes;
    try {
      var barcodeScanRes = await Permission.camera.status;
      if (barcodeScanRes.isGranted) {
        String? barcodeScanRes = await scanner.scan();
        print(barcodeScanRes);
        setState(() {
          result = barcodeScanRes!;
        });
        Navigator.pop(context);
        messagePop(context, barcodeScanRes, '');
      } else {
        var isGrant = Permission.camera.request();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);

      messagePop(context, _currentPosition, _currentAddress);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  choicePop(context, onPressed, title, isWarning) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: tStyle.text_bold.copyWith(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: isWarning
                                    ? AppColors.red_55
                                    : AppColors.primaryColor,
                                fixedSize:
                                    Size(MediaQuery.of(context).size.width, 30),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100))),
                            onPressed: () {
                              qrScanner();
                              onPressed();
                            },
                            child: Text(
                              "Qr",
                              style: tStyle.white_big
                                  .copyWith(fontSize: 12, letterSpacing: 0.8),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: isWarning
                                    ? AppColors.red_55
                                    : AppColors.primaryColor,
                                fixedSize:
                                    Size(MediaQuery.of(context).size.width, 30),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100))),
                            onPressed: () {
                              _getCurrentPosition();
                              onPressed();
                            },
                            child: Text(
                              "Location",
                              style: tStyle.white_big
                                  .copyWith(fontSize: 12, letterSpacing: 0.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            alignment: Alignment.center,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.30,
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.darkBlue,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: AppColors.white_00,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: AppColors.white_00)),
                            child: Image.asset(
                              "assets/img/scanner.png",
                              height: MediaQuery.of(context).size.height / 12,
                              color: AppColors.white_00,
                              width: MediaQuery.of(context).size.width * 0.20,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Hi & Welcome!',
                                style: tStyle.white_big
                                    .copyWith(letterSpacing: 0.5, fontSize: 20),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Attendance with OR Code',
                                style: tStyle.white_big.copyWith(
                                    letterSpacing: 0.5,
                                    fontSize: 15,
                                    fontFamily: 'MONTSERRAT-MEDIUM'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: InkWell(
                    onTap: () {
                      choicePop(
                          context, SettingPage(), 'Attendance With', false);
                    },
                    child: Card(
                      color: AppColors.blue_01,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 25, horizontal: 15),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  size: 32,
                                  color: AppColors.white_00,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Check-In',
                                      style: tStyle.white_big.copyWith(
                                          letterSpacing: 0.5, fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      // result,
                                      'Check-In for your attendance',
                                      style: tStyle.textHint.copyWith(
                                          letterSpacing: 0.5,
                                          color: AppColors.white_00,
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: InkWell(
                    onTap: () {
                      Singleton.instance
                          .showPicker(context, pickedImage, false);
                    },
                    child: Card(
                      color: AppColors.green,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 25, horizontal: 15),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.logout_rounded,
                                  size: 32,
                                  color: AppColors.white_00,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Check-Out',
                                      style: tStyle.white_big.copyWith(
                                          letterSpacing: 0.5, fontSize: 20),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'Check-Out to complete your attendance',
                                      style: tStyle.textHint.copyWith(
                                          letterSpacing: 0.5,
                                          color: AppColors.white_00,
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: InkWell(
                    onTap: () async {
                      await availableCameras().then(
                        (value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CameraPage(
                              cameras: value,
                            ),
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: AppColors.green_01,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.settings_suggest_outlined,
                              size: 32,
                              color: AppColors.white_00,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Settings',
                                    style: tStyle.white_big.copyWith(
                                        letterSpacing: 0.5, fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Application setting,URL and KEY with QR code',
                                    style: tStyle.textHint.copyWith(
                                        letterSpacing: 0.5,
                                        color: AppColors.white_00,
                                        fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: Card(
                    color: AppColors.pink,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 25, horizontal: 15),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_month,
                                size: 32,
                                color: AppColors.white_00,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Report',
                                    style: tStyle.white_big.copyWith(
                                        letterSpacing: 0.5, fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'View your attendance report',
                                    style: tStyle.textHint.copyWith(
                                        letterSpacing: 0.5,
                                        color: AppColors.white_00,
                                        fontSize: 13),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                  child: Card(
                    color: AppColors.LightPink,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 25, horizontal: 15),
                          child: Row(
                            children: [
                              Icon(
                                Icons.logout_rounded,
                                size: 32,
                                color: AppColors.white_00,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'About',
                                    style: tStyle.white_big.copyWith(
                                        letterSpacing: 0.5, fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'About This App',
                                    style: tStyle.textHint.copyWith(
                                        letterSpacing: 0.5,
                                        color: AppColors.white_00,
                                        fontSize: 13),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

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
}
