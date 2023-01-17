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
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:acadmin/Library/AppColors.dart';
import 'package:acadmin/Library/api_data.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../StudentDashboard/notice_detail.dart';
import 'Staff.dart';

import 'package:intl/intl.dart';

class stud_dashboard extends StatefulWidget {
  stud_dashboard({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _student_dashboardState createState() => _student_dashboardState();
}

class _student_dashboardState extends State<stud_dashboard> {
  bool color = false;
  bool color2 = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late Future personal_data;
  late Future f_notice;
  late Future f_homework;
  late Future f_attendance;

  final List<ChartData> chartData = [
    ChartData('David', 75, AppColors.primaryColor),
    ChartData('Steve', 25, AppColors.red_55),
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
            'Stud Dashboard',
            style: tStyle.text_header,
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.notifications,
                color: AppColors.white_00,
              ),
              onPressed: () {},
            ),
          ],
          backgroundColor: AppColors.primaryColor,
        ),
        drawer: student_drawer(scaffoldKey: _scaffoldKey),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Column(
              children: [
                SizedBox(
                  height: 15.0,
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
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.black, width: 1),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Vaghasiya Maulik Sureshbhai",
                              style: tStyle.text_bold.copyWith(fontSize: 18),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                            border: Border.all(
                                                color: AppColors.black,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        )
                                      : Container(
                                          height: 140,
                                          width: 110,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  user.Image.toString()),
                                              fit: BoxFit.cover,
                                            ),
                                            border: Border.all(
                                                color: AppColors.black,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.18,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Unique ID : ",
                                              style: tStyle.text_bold,
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  270,
                                              child: Text(
                                                user.UniqueID.toString(),
                                                style: tStyle.text_label,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Class : ",
                                                style: tStyle.text_bold),
                                            Text(
                                              user.Designation.toString(),
                                              style: tStyle.text_label,
                                            ),
                                            SizedBox(
                                              width: 35.0,
                                            ),
                                            Text(
                                              "Roll No : ",
                                              style: tStyle.text_bold,
                                            ),
                                            Text(
                                              user.RollNo.toString(),
                                              style: tStyle.text_label,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PayFees()),
                                                );
                                              },
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    25,
                                                decoration: BoxDecoration(
                                                  color: AppColors.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'Pay Fees',
                                                      style: tStyle.white_big
                                                          .copyWith(
                                                              fontSize: 13),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2,
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
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    25,
                                                decoration: BoxDecoration(
                                                  color: AppColors.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'Attendense',
                                                      style: tStyle.white_big
                                                          .copyWith(
                                                              fontSize: 13),
                                                    ),
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
                            Row(
                              children: [
                                InkWell(
                                  // onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => trackbus()),);},
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    height:
                                        MediaQuery.of(context).size.height / 20,
                                    width: MediaQuery.of(context).size.width *
                                        0.32,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Bus Track',
                                        style: tStyle.white_big
                                            .copyWith(fontSize: 13),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              color2 = !color2;
                            });
                          },
                          child: Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.17,
                                decoration: BoxDecoration(
                                  color: AppColors.white_00,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: SfCircularChart(
                                  series: <CircularSeries>[
                                    // Render pie chart
                                    PieSeries<ChartData, String>(
                                        radius: '100%',
                                        dataSource: chartData,
                                        explode: true,
                                        selectionBehavior:
                                            SelectionBehavior(enable: true),
                                        // pointColorMapper: (ChartData data, _) =>
                                        //     data.color,
                                        xValueMapper: (ChartData data, _) =>
                                            data.icon,
                                        yValueMapper: (ChartData data, _) =>
                                            data.category)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              color2 = !color2;
                            });
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.17,
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: AppColors.white_90,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    'Notice',
                                    style: tStyle.textPrimary,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: 1,
                                    itemBuilder: (context, index) {
                                      return Card(
                                        elevation: 0,
                                        color: AppColors.white_00,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Notice Detail',
                                              style: tStyle.textBlack,
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
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: Text(
                          'View More',
                          style: tStyle.textBlack.copyWith(
                              fontSize: 13, fontFamily: 'MONTSERRAT-BOLD'),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              color2 = !color2;
                            });
                          },
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              height: MediaQuery.of(context).size.height * 0.17,
                              decoration: BoxDecoration(
                                color: AppColors.white_90,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      'HomeWork',
                                      style: tStyle.textPrimary,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: 1,
                                      itemBuilder: (context, index) {
                                        return Card(
                                          elevation: 2,
                                          color: AppColors.white_00,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Task',
                                                style: tStyle.textBlack,
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                'https://th.bing.com/th/id/OIP.F00dCf4bXxX0J-qEEf4qIQHaD6?pid=ImgDet&rs=1',
                                fit: BoxFit.fitWidth,
                                height:
                                    MediaQuery.of(context).size.height * 0.17,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => StaffPage()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          'View More',
                          style: tStyle.textBlack.copyWith(
                              fontSize: 13, fontFamily: 'MONTSERRAT-BOLD'),
                        ),
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
}
