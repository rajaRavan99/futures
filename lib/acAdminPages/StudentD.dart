import 'dart:ui';

import 'package:acadmin/Library/MyNavigator.dart';
import 'package:acadmin/Library/StorageManager.dart';
import 'package:acadmin/Library/Utils.dart';
import 'package:acadmin/Library/student_drawer.dart';
import 'package:acadmin/Model/ChartModel.dart';
import 'package:acadmin/Model/HomeworkModel.dart';
import 'package:acadmin/Model/NoticeModel.dart';
import 'package:acadmin/Model/UserModel.dart';
import 'package:acadmin/StaffDashboard/attendance_list.dart';
import 'package:acadmin/StudentDashboard/PayFees.dart';
import 'package:acadmin/StudentDashboard/homework_detail.dart';
import 'package:acadmin/StudentDashboard/student_bus_tracker.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:acadmin/Library/AppColors.dart';
import 'package:acadmin/Library/api_data.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:intl/intl.dart';

import '../StudentDashboard/notice_detail.dart';

class Student_D extends StatefulWidget {
  Student_D({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _student_dashboardState createState() => _student_dashboardState();
}

class _student_dashboardState extends State<Student_D> {
  bool color = false;
  bool color2 = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late Future personal_data;
  late Future f_notice;
  late Future f_homework;
  late Future f_attendance;

  final List<ChartData> chartData = [
    ChartData('David', 30, AppColors.primaryColor),
    ChartData('Steve', 70, AppColors.blue),
  ];

  Future get_personal_data() async {
    UserModel dataStr = UserModel();

    try {
      var data = {};
      data["token"] = await AppStorage.getData("utoken");
      var res = await ApiData().get_data('MasterData/GetPersonalDetail', data);
      if (res['IsSuccess'] == "1") {
        dataStr = UserModel.fromJson(res['PersonalInfoList']);
      }
    } catch (e) {}

    return dataStr;
  }

  Future get_notice_data() async {
    List<NoticeModel> noticeL = [];

    try {
      var data = {};
      data["token"] = await AppStorage.getData("utoken");
      var res =
          await ApiData().get_data('NoticeData/GetNoticeLatestData', data);
      if (res['IsSuccess'] == "1") {
        noticeL = NoticeModelList(res['NoticeList']);
      }
    } catch (e) {}

    return noticeL;
  }

  Future get_homework_data() async {
    List<HomeworkModel> homeworkL = [];

    try {
      var data = {};
      data["token"] = await AppStorage.getData("utoken");
      var res =
          await ApiData().get_data('AcademicsData/GetSubmittedHomework', data);
      if (res['IsSuccess'] == "1") {
        homeworkL = HomeworkModelList(res['CurrentHomeworkList']);
      }
    } catch (e) {}

    return homeworkL;
  }

  Future get_attendance_data() async {
    List<dynamic> attendance = [];

    try {
      var data = {};
      data["token"] = await AppStorage.getData("utoken");
      var res =
          await ApiData().get_data('AttendanceData/GetCurrentAttendance', data);
      if (res['IsSuccess'] == "1") {
        attendance = (res['CurrentAttendanceList']);
      }
    } catch (e) {}

    return attendance;
  }

  @override
  void initState() {
    super.initState();
    personal_data = get_personal_data();
    f_notice = get_notice_data();
    f_homework = get_homework_data();
    f_attendance = get_attendance_data();
  }

  noticeCard(NoticeModel notice) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 1, bottom: 1),
              child: Container(
                height: 60,
                width: 3,
                color: AppColors.primaryColorLight,
              ),
            ),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width - 20,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => notice_detail(
                              nid: notice.NoticeManagerID,
                              data: notice,
                            )),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 170,
                        child: Text(
                          notice.NoticeTitle.toString(),
                          style: tStyle.big_black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 7.0, bottom: 7.0, right: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              (notice.NoticeDate ?? "") == ""
                                  ? ""
                                  : DateFormat('dd-MM-yyyy')
                                      .format(DateTime.parse(
                                          (notice.NoticeDate.toString())))
                                      .toString(),
                              style: tStyle.small_grey,
                            ),
                            Text(
                              (notice.NoticeDate ?? "") == ""
                                  ? ""
                                  : DateFormat('hh:mm a')
                                      .format(DateTime.parse(
                                          (notice.NoticeDate.toString())))
                                      .toString(),
                              style: tStyle.small_grey,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(
          color: AppColors.grey_20,
          thickness: 0.5,
          height: 0,
        ),
      ],
    );
  }

  homeworkCard(HomeworkModel homework) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 1, bottom: 1),
              child: Container(
                height: 60,
                width: 3,
                color: AppColors.primaryColorLight,
              ),
            ),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width - 20,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => homework_detail(
                              taskID: homework.TaskID,
                              data: homework,
                              title: homework.TaskTitle.toString(),
                            )),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 170,
                        child: Text(
                          homework.TaskTitle.toString(),
                          style: tStyle.big_black,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 7.0, bottom: 7.0, right: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              (homework.TaskDate ?? "") == ""
                                  ? ""
                                  : DateFormat('dd-MM-yyyy')
                                      .format(DateTime.parse(
                                          (homework.TaskDate.toString())))
                                      .toString(),
                              style: tStyle.small_grey,
                            ),
                            Text(
                              (homework.TaskDate ?? "") == ""
                                  ? ""
                                  : DateFormat('hh:mm a')
                                      .format(DateTime.parse(
                                          (homework.TaskDate.toString())))
                                      .toString(),
                              style: tStyle.small_grey,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(
          color: AppColors.grey_20,
          thickness: 0.5,
          height: 0,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await MyNavigator().onWillPop(context);
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryBackGroundColor,
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          titleSpacing: 5,
          leading: InkWell(
            onTap: () {
              _scaffoldKey.currentState!.openDrawer();
            },
            child: Tab(
                icon: new Image.asset(
              "assets/img/menu.png",
              height: 25,
              width: 27,
            )),
          ),
          title: Text(
            'DASHBOARD',
            style: tStyle.text_header,
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.notifications_active_outlined,
                color: AppColors.white_00,
              ),
              onPressed: () {},
            ),
          ],
          backgroundColor: AppColors.blue,
        ),
        drawer: student_drawer(scaffoldKey: _scaffoldKey),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: AppColors.blue,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                    ),
                    FutureBuilder(
                      future: personal_data,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  AppColors.primaryColorLight),
                            ),
                          );
                        } else {
                          var user = snapshot.data as UserModel;
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            width: 400,
                            padding: const EdgeInsets.all(0.0),
                            child: Card(
                              elevation: 2,
                              color: AppColors.white_00,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    "Vaghasiya Maulik Sureshbhai",
                                    style:
                                        tStyle.big_bold.copyWith(fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          children: [
                                            user.Image == ""
                                                ? Container(
                                                    height: 140,
                                                    width: 110,
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            "assets/img/person1.png"),
                                                        fit: BoxFit.cover,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                  )
                                                : Container(
                                                    height: 140,
                                                    width: 110,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              user.Image
                                                                  .toString()),
                                                          fit: BoxFit.cover,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    10.0)),
                                                  ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            InkWell(
                                              // onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => trackbus()),);},
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    25,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.32,
                                                decoration: BoxDecoration(
                                                  color: AppColors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Bus Tracking',
                                                    style: tStyle.white_big
                                                        .copyWith(fontSize: 13),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 8),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5),
                                            // color: AppColors.white_00,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.22,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text("Unique ID : ",
                                                        style: tStyle
                                                            .common_label_black),
                                                    Container(
                                                      child: Text(
                                                          user.UniqueID
                                                              .toString(),
                                                          style: tStyle
                                                              .text_label),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("JR.KG",
                                                        style: tStyle
                                                            .common_label_black),
                                                    Text("D",
                                                        style: tStyle
                                                            .common_label_black),
                                                    Text(
                                                      "19",
                                                      style: tStyle
                                                          .common_label_black,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  attendance_list()),
                                                        );
                                                      },
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                              height: MediaQuery
                                                                          .of(
                                                                              context)
                                                                      .size
                                                                      .height /
                                                                  18,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.15,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: AppColors
                                                                    .primaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    Image.asset(
                                                                  'assets/img/money.png',
                                                                  height: 5,
                                                                  color: AppColors
                                                                      .white_00,
                                                                ),
                                                              )),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            'Pay Fees',
                                                            style: tStyle
                                                                .common_label_black
                                                                .copyWith(
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  attendance_list()),
                                                        );
                                                      },
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                              height: MediaQuery
                                                                          .of(
                                                                              context)
                                                                      .size
                                                                      .height /
                                                                  18,
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.15,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: AppColors
                                                                    .primaryColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    Image.asset(
                                                                  'assets/img/user.png',
                                                                  height: 5,
                                                                  color: AppColors
                                                                      .white_00,
                                                                ),
                                                              )),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            'Attendance',
                                                            style: tStyle
                                                                .common_label_black
                                                                .copyWith(
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
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
                            ),
                          );
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.30,
                                width: MediaQuery.of(context).size.width * 0.40,
                                decoration: BoxDecoration(
                                  color: AppColors.white_00,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: SfCircularChart(
                                  series: <CircularSeries>[
                                    // Render pie chart
                                    PieSeries<ChartData, String>(
                                        radius: '85%',
                                        dataSource: chartData,
                                        explode: true,
                                        selectionBehavior:
                                            SelectionBehavior(enable: true),
                                        pointColorMapper: (ChartData data, _) =>
                                            data.color,
                                        xValueMapper: (ChartData data, _) =>
                                            data.icon,
                                        strokeColor: AppColors.primaryColor,
                                        yValueMapper: (ChartData data, _) =>
                                            data.category),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              width: MediaQuery.of(context).size.width * 0.60,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'NOTICES : ',
                                            style: tStyle.textPrimary.copyWith(
                                                fontFamily:
                                                    'MONTSERRAT-MEDIUM'),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 2),
                                            height: 2,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.13,
                                            color: AppColors.primaryColor,
                                          )
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Text(
                                            'VIEW ALL',
                                            style: tStyle.white_big.copyWith(
                                                fontSize: 12,
                                                fontFamily:
                                                    'MONTSERRAT-MEDIUM'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: 3,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        elevation: 0.5,
                                        color: AppColors.white_00,
                                        child: Row(
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  18,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.12,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 10),
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 2, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: AppColors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: FittedBox(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '4 ',
                                                      maxLines: 2,
                                                      style: tStyle.white_big
                                                          .copyWith(
                                                              fontSize: 12),
                                                    ),
                                                    Text(
                                                      'Dec',
                                                      maxLines: 2,
                                                      style: tStyle.white_big
                                                          .copyWith(
                                                              fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
                                              child: Text(
                                                'When the user clicks on the widget or focuses it then '
                                                'presses the space bar, it "twists" open, revealing its contents. The common use of a triangle which rotates or '
                                                'twists around to represent opening or closing the widget is why these are sometimes called "twisty".',
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: tStyle.textBlack
                                                    .copyWith(fontSize: 12),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            width: MediaQuery.of(context).size.width * 0.50,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'HOMEWORK  : ',
                                          style: tStyle.textPrimary.copyWith(
                                              fontFamily: 'MONTSERRAT-MEDIUM'),
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.symmetric(vertical: 2),
                                          height: 2,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.19,
                                          color: AppColors.primaryColor,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: 3,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      elevation: 0.5,
                                      color: AppColors.white_00,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2.0, horizontal: 15),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'English',
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                                style: tStyle.big_black
                                                    .copyWith(fontSize: 12),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  21,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.10,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5, vertical: 0),
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: 2, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: AppColors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '1',
                                                  style: tStyle.white_big
                                                      .copyWith(fontSize: 12),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    'VIEW ALL',
                                    style: tStyle.white_big.copyWith(
                                        fontSize: 12,
                                        fontFamily: 'MONTSERRAT-MEDIUM'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.30,
                                width: MediaQuery.of(context).size.width * 0.40,
                                decoration: BoxDecoration(
                                  color: AppColors.white_00,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.50,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.40,
                                            decoration: BoxDecoration(
                                              // color: AppColors.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.network(
                                                'https://th.bing.com/th/id/OIP.k6i15iZbLtLpzvB6QTdhtgHaE8?pid=ImgDet&rs=1',
                                                fit: BoxFit.fitWidth,
                                              ),
                                            )),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.50,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.40,
                                            decoration: BoxDecoration(
                                              // color: AppColors.primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Image.network(
                                              'https://th.bing.com/th/id/OIP.k6i15iZbLtLpzvB6QTdhtgHaE8?pid=ImgDet&rs=1',
                                              fit: BoxFit.fitWidth,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
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
    );
  }
}
