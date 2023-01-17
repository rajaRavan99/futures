import 'package:acadmin/Library/MyNavigator.dart';
import 'package:acadmin/Library/StorageManager.dart';
import 'package:acadmin/Library/student_drawer.dart';
import 'package:acadmin/Model/HomeworkModel.dart';
import 'package:acadmin/Model/NoticeModel.dart';
import 'package:acadmin/Model/UserModel.dart';
import 'package:acadmin/StudentDashboard/homework_detail.dart';
import 'package:acadmin/StudentDashboard/homework_list.dart';
import 'package:acadmin/Library/AppColors.dart';
import 'package:acadmin/Library/api_data.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../StaffDashboard/attendance_list.dart';
import '../StudentDashboard/PayFees.dart';

class StaffPage extends StatefulWidget {
  StaffPage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _student_dashboardState createState() => _student_dashboardState();
}

class _student_dashboardState extends State<StaffPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late Future personal_data;
  late Future f_notice;
  late Future f_homework;
  late Future f_attendance;
  String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

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
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => notice_detail(
                  //             nid: notice.NoticeManagerID,
                  //             data: notice,
                  //           )),
                  // );
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
          backgroundColor: AppColors.blue,
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
            'Staff ',
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
        ),
        drawer: student_drawer(scaffoldKey: _scaffoldKey),
        body: SingleChildScrollView(
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
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Vaghasiya Maulik Sureshbhai",
                              style: tStyle.text_bold.copyWith(fontSize: 18),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           PayFees()),
                                        // );
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.10,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.23,
                                        decoration: BoxDecoration(
                                          color: AppColors.white_90,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/img/student.png',
                                              height: 25,
                                              color: AppColors.black,
                                            ),
                                            Text(
                                              'Student',
                                              style: tStyle.textBlack
                                                  .copyWith(fontSize: 13),
                                            ),
                                            Text(
                                              '2',
                                              style: tStyle.text_bold
                                                  .copyWith(fontSize: 13),
                                            ),
                                          ],
                                        ),
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
                                              builder: (context) => PayFees()),
                                        );
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.10,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.23,
                                        decoration: BoxDecoration(
                                          color: AppColors.white_90,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/img/money.png',
                                              height: 25,
                                              color: AppColors.black,
                                            ),
                                            Text(
                                              'Fees',
                                              style: tStyle.textBlack
                                                  .copyWith(fontSize: 13),
                                            ),
                                            Text(
                                              '5',
                                              style: tStyle.text_bold
                                                  .copyWith(fontSize: 13),
                                            ),
                                          ],
                                        ),
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
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.10,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.23,
                                        decoration: BoxDecoration(
                                          color: AppColors.white_90,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/img/user.png',
                                              height: 25,
                                              color: AppColors.black,
                                            ),
                                            Text(
                                              'Attend',
                                              style: tStyle.textBlack
                                                  .copyWith(fontSize: 13),
                                            ),
                                            Text(
                                              '10',
                                              style: tStyle.text_bold
                                                  .copyWith(fontSize: 13),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //       builder: (context) =>
                                        //           PayFees()),
                                        // );
                                      },
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.10,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.23,
                                        decoration: BoxDecoration(
                                          color: AppColors.white_90,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/img/test.png',
                                              height: 25,
                                              color: AppColors.black,
                                            ),
                                            Text(
                                              'Exam',
                                              style: tStyle.textBlack
                                                  .copyWith(fontSize: 13),
                                            ),
                                            Text(
                                              '3',
                                              style: tStyle.text_bold
                                                  .copyWith(fontSize: 13),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ));
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50.0,
                color: AppColors.blue,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: Text(
                        "TIME TABLE :",
                        style: tStyle.big_label,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  // border: Border.all(color: AppColors.black, width: 0.2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  // itemCount: arrUsers.length < 3
                  //     ? arrUsers.length
                  //     : 3,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 1,
                      color: AppColors.white_00,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 5),
                        child: Row(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height / 22,
                              width: MediaQuery.of(context).size.width * 0.10,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 0),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 2, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.blue,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Center(
                                child: Text(
                                  '$index',
                                  style:
                                      tStyle.white_big.copyWith(fontSize: 12),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Std : 10',
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: tStyle.big_black
                                                .copyWith(fontSize: 12),
                                          ),
                                          SizedBox(
                                            width: 25,
                                          ),
                                          Text(
                                            'Div : B',
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: tStyle.big_black
                                                .copyWith(fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'Sub : English',
                                        overflow: TextOverflow.ellipsis,
                                        style: tStyle.big_black
                                            .copyWith(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    formattedDate,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        tStyle.big_black.copyWith(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      color: AppColors.blue,
                      child: Center(
                        child: Text(
                          "NOTICE ",
                          style: tStyle.big_label,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 2,
                    color: AppColors.white_00,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                  ),
                  Expanded(
                    child: Container(
                      height: 50,
                      color: AppColors.blue,
                      child: Center(
                        child: Text(
                          "HOMEWORK ",
                          style: tStyle.big_label,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.30,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: AppColors.white_00,
                          // border: Border.all(color: AppColors.black, width: 0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 0.5,
                              color: AppColors.white_00,
                              child: Row(
                                children: [
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 18,
                                    width: MediaQuery.of(context).size.width *
                                        0.12,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 10),
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 2, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppColors.blue,
                                      borderRadius: BorderRadius.circular(50),
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
                                                .copyWith(fontSize: 12),
                                          ),
                                          Text(
                                            'Dec',
                                            maxLines: 2,
                                            style: tStyle.white_big
                                                .copyWith(fontSize: 12),
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
                                      'presses the space bar, it "twists" open, revealing its contents',
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
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.30,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: AppColors.white_00,
                          // border: Border.all(color: AppColors.black, width: 0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListView.builder(
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
                                      height:
                                          MediaQuery.of(context).size.height /
                                              21,
                                      width: MediaQuery.of(context).size.width *
                                          0.10,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 0),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 2, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: AppColors.blue,
                                        borderRadius: BorderRadius.circular(50),
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
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
