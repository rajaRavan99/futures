import 'dart:async';
import 'dart:convert';
import 'package:acadmin/Library/AppColors.dart';
import 'package:acadmin/Library/api_data.dart';
import 'package:acadmin/Library/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;
import '../Library/StorageManager.dart';

class StudentBusTrackerOld extends StatefulWidget {
  const StudentBusTrackerOld({Key? key}) : super(key: key);

  @override
  State<StudentBusTrackerOld> createState() => _StudentBusTrackerOldState();
}

class _StudentBusTrackerOldState extends State<StudentBusTrackerOld> {
  bool isLoading = false;

  late GoogleMapController _controller;
  Set<Marker> _marker = {};


  Set<Polyline> _polyline = {};
  List<LatLng> polylineCoordinates = [];

  double currentLat = 0.0;
  double currentLon = 0.0;
  double driverLat = 0.0;
  double driverLon = 0.0;
  double schoolLat = 0.0;
  double schoolLon = 0.0;

  late double distance = 0.0;

  String distanceApi = "0 km";
  String durationApi = "0 hour";

  @override
  void initState() {
    super.initState();
    mainFunc();
  }


  Future timerFunc() async{
    Timer(Duration(seconds: 30),()async {
      _marker.clear();
      polylineCoordinates.clear();
      _polyline.clear();

      await getCurrentLocation();
      await getSchoolDriverLocation();
      await mapRoute(currentLat, currentLon, driverLat, driverLon);
      setState(() {});
      timerFunc();
    },);
  }
  
  Future mainFunc() async{
    await getCurrentLocation();
    _controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(currentLat,currentLon),zoom: 17)));
    await getSchoolDriverLocation();
    await mapRoute(currentLat, currentLon, driverLat, driverLon);
    setState(() {});
    await timerFunc();
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
    setState(() {
      isLoading = true;
    });
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
    setState(() {
      isLoading = false;
    });
  }

  Future mapRoute(double startlat, double startlon, double destlat, double destlon) async{
    String url = "https://maps.googleapis.com/maps/api/directions/json?origin=$startlat,$startlon&destination=$destlat,$destlon&mode=driving&key=${Common.google_api_key}";
    http.Response response = await http.get(Uri.parse(url));

    var values = jsonDecode(response.body);

    setState(() {
      distanceApi = values["routes"][0]["legs"][0]["distance"]["text"];
      durationApi = values["routes"][0]["legs"][0]["duration"]["text"];
    });

    List<PointLatLng> result = PolylinePoints().decodePolyline(values["routes"][0]["overview_polyline"]["points"]);
    for (var point in result) {
      print(point.latitude);
      print(point.longitude);
      polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    }

    _polyline.add(
        Polyline(
          polylineId: PolylineId('poly'),
          color: Colors.blueAccent,
          points: polylineCoordinates,
          width: 6,
        )
    );
    setState(() {});
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
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: LatLng(0.0,0.0)),
            myLocationEnabled: true,
            tiltGesturesEnabled: true,
            compassEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            polylines: _polyline,
            onMapCreated: (GoogleMapController controller){
              _controller = controller;
            },
            markers: _marker,
          ),
          Visibility(
              visible: isLoading,
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(7),
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),color: Colors.black.withOpacity(0.5),),
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.white,),
                  ),
                ),
              )
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: 80,
            width: MediaQuery.of(context).size.width*0.80,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: (driverLat==0.0 || driverLon==0.0)
                    ?[Text("Bus Driver Location is not found",style: tStyle.no_found_big,),]
                    :[
                  Text(
                    "Duration: $durationApi",
                    style: tStyle.no_found_big,
                  ),
                  SizedBox(height: 8,),
                  Text(
                      "Destination: $distanceApi",
                    style: tStyle.no_found_big,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}