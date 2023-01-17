import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:future/ApiPage.dart/Pagiation.dart';
import 'package:future/Library/TextStyle.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../ApiPage.dart/ApiHomepage.dart';
import '../Library/AppColors.dart';
import '../model/ChartModel.dart';
import 'VideoPage.dart';
import 'drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;
  Position? _currentPosition;
  final List<ChartData2> chartData2 = <ChartData2>[
    ChartData2(2019, 3),
    ChartData2(2020, 6),
    ChartData2(2021, 4),
    ChartData2(2022, 7),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'HomePage',
          style: FontStyle.textLabelWhite,
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Avarage Viewer in India',
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 170,
                child: SfCartesianChart(
                  backgroundColor: AppColors.white_00,
                  primaryXAxis: CategoryAxis(
                    labelStyle: FontStyle.greyTextSmall,
                    title: AxisTitle(
                        text: 'Year', textStyle: FontStyle.primarySmallBold),
                  ),
                  primaryYAxis: NumericAxis(
                    labelStyle: FontStyle.greyTextSmall,
                    title: AxisTitle(
                        text: 'Amount', textStyle: FontStyle.primarySmallBold),
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
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: 90,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                        color: AppColors.grey_09,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'Photo',
                          style: FontStyle.textHint.copyWith(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(const VideoPage());
                    },
                    child: Container(
                      height: 90,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                        color: AppColors.grey_09,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'Videos',
                          style: FontStyle.textHint.copyWith(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Get.to(const DashBoard());
                },
                child: Container(
                  height: 90,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                    color: AppColors.grey_09,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'Api',
                      style: FontStyle.textHint.copyWith(fontSize: 15),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  Get.to(const Pagiation());
                },
                child: Container(
                  height: 90,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                    color: AppColors.grey_09,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'Pagiation',
                      style: FontStyle.textHint.copyWith(fontSize: 15),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
