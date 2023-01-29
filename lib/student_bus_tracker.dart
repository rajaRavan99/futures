import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:ui' as ui;

import '../Library/AppColors.dart';
import '../Library/StorageManager.dart';
import '../Library/api_data.dart';

class StudentBusTracker extends StatefulWidget {
  const StudentBusTracker({Key? key}) : super(key: key);

  @override
  State<StudentBusTracker> createState() => _StudentBusTrackerState();
}

class _StudentBusTrackerState extends State<StudentBusTracker> {
  late GoogleMapController _controller;
  Set<Marker> _marker = {};

  double currentLat = 0.0;
  double currentLon = 0.0;
  double driverLat = 0.0;
  double driverLon = 0.0;
  double schoolLat = 0.0;
  double schoolLon = 0.0;

  @override
  void initState() {
    super.initState();
    mainFunc();
  }

  mainFunc()async{
    final status = await Permission.location.request();
    if(status.isGranted){
      await getCurrentLocation();
      getSchoolDriverLocation();
      delayFunc();
    }
    if(status.isDenied){
      Navigator.pop(context);
      tStyle().messagePop(context, 'Please Allow Permission to show bus route');
    }
    if(status.isPermanentlyDenied){
      Navigator.pop(context);
      openAppSettings();
    }

  }

  delayFunc() async{
    Timer(Duration(seconds: 30),()async {
      _marker.clear();
      await getCurrentLocation();
      await getSchoolDriverLocation();
      delayFunc();
    },);
  }


  Future getCurrentLocation() async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentLat = position.latitude;
    currentLon = position.longitude;
    final Uint8List? schoolMarker = await getBytesFromAsset('assets/img/location.png',120);
    _marker.add(Marker(markerId: MarkerId("Current"),position: LatLng(currentLat, currentLon), icon: BitmapDescriptor.fromBytes(schoolMarker!),));
    setState(() {});
  }

  Future getSchoolDriverLocation() async{
    try{
      var data = {};
      data["token"] = await AppStorage.getData("utoken");
      var res = await ApiData().get_data("TransportData/GetStudentRouteLocation/",data);
      if( res['IsSuccess'] == '1'){

        // school marker
        schoolLat = double.parse(res['FirstRoute'][0]['Latitude']);
        schoolLon = double.parse(res['FirstRoute'][0]['Longitude']);
        final Uint8List? schoolMarker = await getBytesFromAsset('assets/img/school.png',150);
        _marker.add(Marker(markerId: MarkerId("School"),position: LatLng(schoolLat, schoolLon), icon: BitmapDescriptor.fromBytes(schoolMarker!),));
        _controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(schoolLat,schoolLon),zoom: 17)));

        // driver marker
        driverLat = double.parse(res['LastRoute'][0]['Latitude']);
        driverLon = double.parse(res['LastRoute'][0]['Longitude']);
        final Uint8List? driverMarker = await getBytesFromAsset('assets/img/bus_tracking.png',120);
        _marker.add(Marker(markerId: MarkerId("Bus Driver"),position: LatLng(driverLat, driverLon), icon: BitmapDescriptor.fromBytes(driverMarker!),));
        setState(() {});
      }else{
        tStyle().showsnackbar(context, 'Something went wrong!');
      }
    }catch(e){
      tStyle().showsnackbar(context, 'Internal Server Error');
    }
  }

  Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))?.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text("Bus Tracking"),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: LatLng(0.0,0.0)),
        myLocationEnabled: true,
        tiltGesturesEnabled: true,
        compassEnabled: true,
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: false,
        markers: _marker,
        onMapCreated: (GoogleMapController controller){
          _controller = controller;
        },
      ),
    );
  }
}
