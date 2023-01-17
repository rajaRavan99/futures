import 'dart:io';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart' as Loc;
import 'package:roadapp/Dashboard/Location.dart';
import 'package:roadapp/Dashboard/NewsDetails.dart';
import 'package:roadapp/Dashboard/NewsList.dart';
import 'package:roadapp/Dashboard/RecentDetails.dart';
import 'package:roadapp/Library/AppDrawer.dart';
import 'package:roadapp/Library/TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:roadapp/Library/Utils.dart';
import 'package:video_player/video_player.dart';
import '../Library/AppColors.dart';
import 'RecentUploadList.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late VideoPlayerController _controller;
  bool isLoading = false;
  String? _currentAddress;
  Position? _currentPosition;
  Location location = new Location();
  Loc.Location locationLoc = Loc.Location();

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  _locationOnOff() async {
    bool _serviceEnabled;
    Loc.PermissionStatus _permissionGranted;
    Loc.LocationData _locationData;

    _serviceEnabled = await locationLoc.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await locationLoc.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await locationLoc.hasPermission();
    if (_permissionGranted == Loc.PermissionStatus.denied) {
      _permissionGranted = await locationLoc.requestPermission();
      if (_permissionGranted != Loc.PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await locationLoc.getLocation();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    await _locationOnOff();

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(Utils().errorSnack(context,
          "Location services are disabled. Please enable the services"));
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
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    _currentPosition = position;

    setState(() {});

    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
    print(_currentPosition?.latitude);
    print(_currentPosition?.longitude);
  }

  recentCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RecentDetails()));
        },
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: AppColors.white_00,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 170,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        color: AppColors.white_00,
                        image: DecorationImage(
                          image: AssetImage('assets/image/news.jpg'),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: const [
                    Expanded(
                      child: Text(
                        "Description jhbjhg jhghu jhgyf hjftf hjftysjandk sabcjsakhc sajcbshc scsuyc hsdygs hdygs hgsdhg nsdbhsg bsvdg bsfdg bshfdysg hfsdg dbsvdg hsfdg bsdgsfd dsfdsgf dsgdgsv dbsvdgsjbsdjbd  bsjhbdj bsjbd bsjbd bsjd nbsjdsjdnajdn hsbadbhdb bvsdhhjsbbd f jguyg jhgyufuf hguh vuhfdivid vbfdhv",
                        style: FontStyle.textLabelSmall,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  newsCard() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewsDetails()));
        },
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: AppColors.white_00,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 8, top: 8, bottom: 14),
              child: Column(
                children: [
                  SizedBox(
                    height: 170,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: AppColors.white_00,
                          image: DecorationImage(
                            image: AssetImage('assets/image/news.jpg'),
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: const [
                      Text(
                        "Description",
                        style: FontStyle.textLabel,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  const Expanded(
                    child: Text(
                      "nxjskanjkjkahd sadkaj sbdhs cdsbhcbdh ghj hvhg hgvfvh hgvh hvh hftf hgfh hfhf hftf fygyh hfhfth hfhtfdhbvhdb shbdhb shdbbdys dshbdsbuh shdbshdbs dshbdhbsb sdbdysb bshdhsgd shgdgdsv vdsdvg sdvycv svhcvgsv gvsgvhsdbcd shjb jhssjhb sbjsh sdxhsc sbakdhuiasd njkb kjbk",
                      style: FontStyle.textLabelSmall,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  chooseoption(BuildContext context) {
    showDialog(
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
                      'Choose Option',
                      textAlign: TextAlign.center,
                      style: FontStyle.popText,
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            imageUpload(context);
                          },
                          child: Image.asset("assets/image/photo.png",
                              height: 60, width: 60),
                        ),
                        SizedBox(width: 15),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            videoUpload(context);
                          },
                          child: Image.asset("assets/image/video.png",
                              height: 55, width: 55),
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
                              _getImageFromGallery();
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
                              _getImageFromCamera();
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

  videoUpload(BuildContext context) async {
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
                      'Upload Video',
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
                              _getVideoFromGallery();
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
                              _getVideoFromCamera();
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

  Future<void> _getImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    print("1111111111111111111111");
    print(pickedFile?.path);
    print("222222222222222222222");
    File file = File(pickedFile!.path);

    (pickedFile != null)
        ? showDialog(
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
                        Text(_currentPosition != null
                            ? _currentPosition!.latitude.toString()
                            : ""),
                        Text(_currentPosition != null
                            ? _currentPosition!.longitude.toString()
                            : ""),
                        SizedBox(height: 5),
                        SizedBox(
                          height: 100,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(file),
                                fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            // child: Image.file(file),
                          ),
                        ),
                        SizedBox(height: 5),
                        const Text(
                          'Image Upload Succesfully',
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
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    AppColors.primaryColor,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Utils().successSnack(context,
                                      "Your Photo Uploaded Succesfully");
                                },
                                child: Text("Ok",
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
            })
        : showDialog(
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
                          'Image is Not Upload Succesfully',
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
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    AppColors.primaryColor,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Utils().errorSnack(context,
                                      "Your Photo is Not Uploaded Succesfully");
                                },
                                child: Text("Ok",
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

  Future<void> _getImageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    print("111111111111111111111111111");
    print(pickedFile?.path);
    print("222222222222222222222222222");
    File file = File(pickedFile!.path);

    (pickedFile != null)
        ? showDialog(
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
                        SizedBox(
                          height: 100,
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(file),
                                fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            // child: Image.file(file),
                          ),
                        ),
                        SizedBox(height: 5),
                        const Text(
                          'Image Upload Succesfully',
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
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    AppColors.primaryColor,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Utils().successSnack(context,
                                      "Your Photo Uploaded Succesfully");
                                },
                                child: Text("Ok",
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
            })
        : showDialog(
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
                          'Image is Not Upload Succesfully',
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
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    AppColors.primaryColor,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Utils().errorSnack(context,
                                      "Your Photo is Not Uploaded Succesfully");
                                },
                                child: Text("Ok",
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

  Future<void> _getVideoFromGallery() async {
    final pickedFile =
        await ImagePicker().pickVideo(source: ImageSource.gallery);

    print("1111111111111111111111");
    print(pickedFile?.path);
    print("222222222222222222222");
    File file = File(pickedFile!.path);

    (pickedFile != null)
        ? showDialog(
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
                        Text(_currentPosition != null
                            ? _currentPosition!.latitude.toString()
                            : ""),
                        Text(_currentPosition != null
                            ? _currentPosition!.longitude.toString()
                            : ""),
                        SizedBox(height: 5),
                        SizedBox(
                          height: 100,
                          child: Container(
                            child: Text(file.toString(),
                                style: FontStyle.textLabel),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Video Upload Succesfully',
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
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    AppColors.primaryColor,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Utils().successSnack(context,
                                      "Your Video Uploaded Succesfully");
                                },
                                child: Text("Ok",
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
            })
        : showDialog(
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
                          'Image is Not Upload Succesfully',
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
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    AppColors.primaryColor,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Utils().errorSnack(context,
                                      "Your Photo is Not Uploaded Succesfully");
                                },
                                child: Text("Ok",
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

  Future<void> _getVideoFromCamera() async {
    final pickedFile =
        await ImagePicker().pickVideo(source: ImageSource.camera);

    print("111111111111111111111111111");
    print(pickedFile?.path);
    print("222222222222222222222222222");
    File file = File(pickedFile!.path);

    (pickedFile != null)
        ? showDialog(
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
                        SizedBox(
                          height: 100,
                          child: Container(
                            child: Text(file.toString(),
                                style: FontStyle.textLabel),
                          ),
                        ),
                        SizedBox(height: 5),
                        const Text(
                          'Video Upload Succesfully',
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
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    AppColors.primaryColor,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Utils().successSnack(context,
                                      "Your Video Uploaded Succesfully");
                                },
                                child: Text("Ok",
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
            })
        : showDialog(
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
                          'Image is Not Upload Succesfully',
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
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    AppColors.primaryColor,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  Utils().errorSnack(context,
                                      "Your Photo is Not Uploaded Succesfully");
                                },
                                child: Text("Ok",
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
    return WillPopScope(
      onWillPop: () async {
        Utils().onWillPop(context);
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: InkWell(
            onTap: () {
              chooseoption(context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("+", style: FontStyle.textTitleSmallWhite),
                  SizedBox(width: 9),
                  Text("New Upload", style: FontStyle.textTitleSmallWhite),
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: AppBar(
          titleSpacing: 5,
          title: const Padding(
            padding: EdgeInsets.only(bottom: 5, left: 10.0),
            child: Text("Dashboard", style: FontStyle.textHeader),
          ),
          backgroundColor: AppColors.primaryColor,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.menu_rounded,
              color: AppColors.white_00,
              size: 30,
            ),
            onPressed: () {
              //icon button to the side bar
              _scaffoldKey.currentState!.openDrawer();
            },
          ),
        ),
        drawer: AppDrawer(scaffoldKey: _scaffoldKey),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 7.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "News",
                        style: FontStyle.textHeaderBlack,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewsList()));
                        },
                        child: const Text(
                          "View All",
                          style: FontStyle.textHeaderBlackSmall,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  height: 270,
                  child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return newsCard();
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 7.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Recent Upload",
                        style: FontStyle.textHeaderBlack,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RecentUploadList()));
                        },
                        child: const Text(
                          "View All",
                          style: FontStyle.textHeaderBlackSmall,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecentDetails()));
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: AppColors.white_00,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  height: 170,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        color: AppColors.white_00,
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/image/truck.jpg'),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                ),
                                Positioned(
                                  right: 8,
                                  bottom: 8,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color:
                                            AppColors.green_00.withOpacity(0.7),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("Solved",
                                            style:
                                                FontStyle.textTitleSmallWhite),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: const [
                                Expanded(
                                  child: Text(
                                    "Description jhbjhg jhghu jhgyf hjftf hjftysjandk sabcjsakhc sajcbshc scsuyc hsdygs hdygs hgsdhg nsdbhsg bsvdg bsfdg bshfdysg hfsdg dbsvdg hsfdg bsdgsfd dsfdsgf dsgdgsv dbsvdgsjbsdjbd  bsjhbdj bsjbd bsjbd bsjd nbsjdsjdnajdn hsbadbhdb bvsdhhjsbbd f jguyg jhgyufuf hguh vuhfdivid vbfdhv",
                                    style: FontStyle.textLabelSmall,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RecentDetails()));
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: AppColors.white_00,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  height: 170,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        color: AppColors.white_00,
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/image/truck.jpg'),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                ),
                                Positioned(
                                  right: 8,
                                  bottom: 8,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.yellow.withOpacity(0.7),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("Investigation",
                                            style:
                                                FontStyle.textTitleSmallWhite),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: const [
                                Expanded(
                                  child: Text(
                                    "Description jhbjhg jhghu jhgyf hjftf hjftysjandk sabcjsakhc sajcbshc scsuyc hsdygs hdygs hgsdhg nsdbhsg bsvdg bsfdg bshfdysg hfsdg dbsvdg hsfdg bsdgsfd dsfdsgf dsgdgsv dbsvdgsjbsdjbd  bsjhbdj bsjbd bsjbd bsjd nbsjdsjdnajdn hsbadbhdb bvsdhhjsbbd f jguyg jhgyufuf hguh vuhfdivid vbfdhv",
                                    style: FontStyle.textLabelSmall,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecentDetails()));
                    },
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: AppColors.white_00,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  height: 170,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        color: AppColors.white_00,
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/image/truck.jpg'),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                ),
                                Positioned(
                                  right: 8,
                                  bottom: 8,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color:
                                            AppColors.red_00.withOpacity(0.7),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("Pending",
                                            style:
                                                FontStyle.textTitleSmallWhite),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: const [
                                Expanded(
                                  child: Text(
                                    "Description jhbjhg jhghu jhgyf hjftf hjftysjandk sabcjsakhc sajcbshc scsuyc hsdygs hdygs hgsdhg nsdbhsg bsvdg bsfdg bshfdysg hfsdg dbsvdg hsfdg bsdgsfd dsfdsgf dsgdgsv dbsvdgsjbsdjbd  bsjhbdj bsjbd bsjbd bsjd nbsjdsjdnajdn hsbadbhdb bvsdhhjsbbd f jguyg jhgyufuf hguh vuhfdivid vbfdhv",
                                    style: FontStyle.textLabelSmall,
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 70),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
