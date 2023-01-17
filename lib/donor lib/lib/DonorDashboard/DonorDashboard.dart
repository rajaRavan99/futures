import 'package:cached_network_image/cached_network_image.dart';
import 'package:donor/DonorDashboard/DonationList.dart';
import 'package:donor/DonorDashboard/DonorDrawer.dart';
import 'package:donor/DonorDashboard/MakeDonation.dart';
import 'package:donor/Library/TextStyle.dart';
import 'package:donor/DonorDashboard/StudentListPage.dart';
import 'package:donor/Library/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../Library/ApiData.dart';
import '../Library/AppColors.dart';
import '../model/ChartModel.dart';
import '../model/UserModel.dart';
import 'DStudentDetail.dart';

class DonorDashboard extends StatefulWidget {
  const DonorDashboard({super.key});

  @override
  State<DonorDashboard> createState() => _DonorDashboardState();
}

class _DonorDashboardState extends State<DonorDashboard> {
  final List<ChartData> chartData = <ChartData>[
    ChartData('Jan', 0),
    ChartData('Feb', 5),
    ChartData('Mar', 3),
    ChartData('Mar', 3),
    ChartData('Aep', 6),
    ChartData('May', 4),
    ChartData('Jun', 6),
    ChartData('July', 0),
  ];

  List<UserModel> uList = [];
  late Future fetchStudentListPage;

  getStudentListPage() async {
    try {
      var data = {};
      data['utype'] = '1';

      var res = await ApiData().postData('student_list', data);
      if (res['st'] == 'success') {
        if (!mounted) return;
        uList = UserModelList(res['data'] ?? []);
      } else {
        if (!mounted) return;
        Utils().errorSnack(context, res["msg"]);
      }
    } catch (e) {
      print('print error: $e');
      Utils().errorSnack(context, "Internal Server Error");
    }
    return uList;
  }

  @override
  void initState() {
    fetchStudentListPage = getStudentListPage();
    super.initState();
  }

  studentCard(UserModel uData, index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DStudentDetail(
                    uid: uData.uid!,
                  )));
        },
        child: Stack(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(width: 1.5, color: AppColors.grey_09),
                      ),
                      child: ClipOval(
                        child: CachedNetworkImage(
                          height: 70,
                          width: 70,
                          imageUrl: uData.uphoto.toString(),
                          errorWidget: (context, url, error) => ClipOval(
                            child: Image.asset(
                              'assets/image/person.png',
                              width: 70,
                              height: 70,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    uData.uname.toString(),
                                    style: FontStyle.textHint.copyWith(
                                        fontSize: 15, color: AppColors.black),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    uData.umobile.toString(),
                                    style: FontStyle.textCardValue.copyWith(
                                        fontSize: 12, color: AppColors.grey_90),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    uData.uemail.toString(),
                                    style: FontStyle.textCardValue.copyWith(
                                        fontSize: 12, color: AppColors.grey_90),
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
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DonorDrawer(),
      floatingActionButton: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const MakeDonation(),
            ),
          );
        },
        child: Utils().primaryIconButton(
          Icons.add_rounded,
          'Donate',
          MediaQuery.of(context).size.width * 0.7,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: FontStyle.textLabelWhite,
        ),
      ),
      body: FutureBuilder(
          // future: ,
          builder: (context, snapshot) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: AppColors.black,
                child: Column(
                  children: [
                    SizedBox(
                      height: 170,
                      child: SfCartesianChart(
                        backgroundColor: Colors.white,
                        primaryXAxis: CategoryAxis(
                          labelStyle: FontStyle.greyTextSmall,
                        ),
                        primaryYAxis: NumericAxis(
                          labelStyle: FontStyle.greyTextSmall,
                        ),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <ChartSeries>[
                          SplineAreaSeries<ChartData, String>(
                              gradient: const LinearGradient(
                                colors: <Color>[
                                  AppColors.pink_00,
                                  AppColors.orange_00
                                ],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              ),
                              dataSource: chartData,
                              xValueMapper: (ChartData data, _) => data.month,
                              yValueMapper: (ChartData data, _) => data.sales),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1,
                    child: Card(
                      color: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 15),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Avalible Balance',
                                style: FontStyle.textLabelSmallWhite
                                    .copyWith(fontSize: 15),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                overflow: TextOverflow.ellipsis,
                                '10,000',
                                style: FontStyle.textLabelWhite.copyWith(
                                    fontFamily: 'SemiBold', fontSize: 20),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const DonationList(),
                                          ));
                                    },
                                    child: Text(
                                      'View History',
                                      style: FontStyle.textLabelSmallWhite
                                          .copyWith(fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Student List',
                      style: FontStyle.textHeaderBlack,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const StudentListPage(),
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 5),
                          child: Text(
                            'View More',
                            style:
                                FontStyle.greyTextSmall.copyWith(fontSize: 13),
                          ),
                        )),
                  ],
                ),
              ),
              FutureBuilder(
                future: fetchStudentListPage,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.0),
                      child: Center(
                        child: SpinKitThreeBounce(
                          size: 30,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    );
                  } else {
                    if (uList.isNotEmpty) {
                      return Column(
                        children: [
                          SizedBox(
                            width: context.width,
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: uList.length < 5 ? uList.length : 5,
                              itemBuilder: (context, index) {
                                return studentCard(uList[index], index);
                              },
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Utils().noItem('No Data Found'),
                      );
                    }
                  }
                },
              )
            ],
          ),
        );
      }),
    );
  }
}
