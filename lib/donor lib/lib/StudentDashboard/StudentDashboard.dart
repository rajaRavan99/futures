import 'package:donor/Library/TextStyle.dart';
import 'package:donor/StudentDashboard/RaisedFundList.dart';
import 'package:donor/StudentDashboard/StudentActivity.dart';
import 'package:donor/StudentDashboard/StudentDrawer.dart';
import 'package:donor/StudentDashboard/StudentFundingHistory.dart';
import 'package:donor/StudentDashboard/StudentProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../Library/ApiData.dart';
import '../Library/AppColors.dart';
import '../Library/ManageStorage.dart';
import '../Library/Utils.dart';
import '../model/ChartModel.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  // ChartData2 data = ChartData2(year, sales);
  final List<ChartData2> chartData2 = <ChartData2>[
    ChartData2(2019, 8),
    ChartData2(2020, 6),
    ChartData2(2021, 4),
    ChartData2(2022, 5),
  ];

  late Future fStudent;

  getDashboard() async {
    try {
      var data = {};
      data['aaid'] = await AppStorage.getData('aaid') ?? "";

      var res = await ApiData().postData('get_student_dashboard', data);
      if (res['st'] == 'success') {
        if (!mounted) return;
        print('----------------------------->');
        print(res['data']['is_kys']);
        if (res['data']['is_kys'].toString() == "0") {
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/AddPersonalInfo', (route) => false);
        } else {
          if (res['data']['is_profile'].toString() == "0") {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/AddOtherInfo', (route) => false);
          }
        }
      } else {
        if (!mounted) return;
        Utils().errorSnack(context, res["msg"]);
      }
    } catch (e) {
      print('print error: $e');
      Utils().errorSnack(context, "Internal Server Error");
    }
  }

  @override
  void initState() {
    fStudent = getDashboard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Student Dashboard',
          style: FontStyle.textLabelWhite,
        ),
      ),
      drawer: const StudentDrawer(),
      body: FutureBuilder(
          future: fStudent,
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
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    SfCartesianChart(
                      backgroundColor: AppColors.white_00,
                      primaryXAxis: CategoryAxis(
                        labelStyle: FontStyle.greyTextSmall,
                        title: AxisTitle(
                            text: 'Year',
                            textStyle: FontStyle.primarySmallBold),
                      ),
                      primaryYAxis: NumericAxis(
                        labelStyle: FontStyle.greyTextSmall,
                        title: AxisTitle(
                            text: 'Amount',
                            textStyle: FontStyle.primarySmallBold),
                      ),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <ChartSeries<ChartData2, int>>[
                        ColumnSeries<ChartData2, int>(
                          color: AppColors.primaryColor,
                          dataSource: chartData2,
                          xValueMapper: (ChartData2 data, _) => data.year,
                          yValueMapper: (ChartData2 data, _) => data.sales,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          crossAxisCount: 3,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 8.0,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const StudentProfile(),
                                    ));
                              },
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.25,
                                  width:
                                      MediaQuery.of(context).size.width * 0.27,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.person_outlined,
                                        size: 25,
                                        color: AppColors.black,
                                      ),
                                      Text(
                                        'Profile',
                                        style: FontStyle.textLabelPrimary
                                            .copyWith(color: AppColors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const StudentActivity()));
                              },
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.25,
                                  width:
                                      MediaQuery.of(context).size.width * 0.27,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.person_pin_circle_outlined,
                                        size: 25,
                                        color: AppColors.black,
                                      ),
                                      Text(
                                        'Activities',
                                        style: FontStyle.textLabelPrimary
                                            .copyWith(color: AppColors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const RaisedFundList()));
                              },
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.25,
                                  width:
                                      MediaQuery.of(context).size.width * 0.27,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.note_alt_outlined,
                                        size: 25,
                                        color: AppColors.black,
                                      ),
                                      Text(
                                        'Raised Fund',
                                        textAlign: TextAlign.center,
                                        style: FontStyle.textLabelPrimary
                                            .copyWith(color: AppColors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const StudentFundingHistory()));
                              },
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.25,
                                  width:
                                      MediaQuery.of(context).size.width * 0.27,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.history,
                                        size: 25,
                                        color: AppColors.black,
                                      ),
                                      Text(
                                        'Funding History',
                                        textAlign: TextAlign.center,
                                        style: FontStyle.textLabelPrimary
                                            .copyWith(color: AppColors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    )
                  ],
                ),
              );
            }
          }),
    );
  }
}
