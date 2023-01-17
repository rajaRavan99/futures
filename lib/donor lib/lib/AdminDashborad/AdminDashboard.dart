import 'package:donor/ADonorList.dart';
import 'package:donor/AdminDashborad/AFundRequestList.dart';
import 'package:donor/AdminDashborad/AStudentList.dart';
import 'package:donor/AdminDashborad/StudentDistribution.dart';
import 'package:donor/Library/TextStyle.dart';
import 'package:donor/Library/Utils.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../Library/AppColors.dart';
import '../model/ChartModel.dart';
import 'AdminDrawer.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final List<ChartData> chartData = <ChartData>[
    ChartData('Jan', 0),
    ChartData('Feb', 5),
    ChartData('mar', 3),
    ChartData('Aep', 6),
    ChartData('May', 4),
    ChartData('Jun', 6),
    ChartData('July', 0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard',
          style: FontStyle.textLabelWhite,
        ),
      ),
      drawer: const AdminDrawer(),

      floatingActionButton: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => StudentDistribution(),));
        },
        child: Utils().primaryButton('Distribute Fund', MediaQuery.of(context).size.width*0.7),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.black12,
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
              // dashboard First Row
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AStudentList(),));
                            },
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Icon(
                                        Icons.person,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'No.of',
                                        style: FontStyle.primarySmallBold,
                                      ),
                                      Text(
                                        'Students',
                                        style: FontStyle.primarySmallBold,
                                      ),
                                      Text(
                                        '10.082',
                                        style: FontStyle.textHintbox,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ADonorList(),));
                            },
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Icon(
                                        Icons.group_add,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        'Total',
                                        style: FontStyle.primarySmallBold,
                                      ),
                                      Text(
                                        'Donor',
                                        style: FontStyle.primarySmallBold,
                                      ),
                                      Text(
                                        '4.425',
                                        style: FontStyle.textHintbox,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    // dashboard Second Row :-
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        InkWell(
                          onTap: () {},
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: SizedBox(
                              height: 150,
                              width: 150,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Icon(
                                      Icons.handshake,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'Total',
                                      style: FontStyle.primarySmallBold,
                                    ),
                                    Text(
                                      'Funding',
                                      style: FontStyle.primarySmallBold,
                                    ),
                                    Text(
                                      '1.082',
                                      style: FontStyle.textHintbox,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AFundRequestList(),));
                          },
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: SizedBox(
                              height: 150,
                              width: 150,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Icon(
                                      Icons.group_add,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'Fund',
                                      style: FontStyle.primarySmallBold,
                                    ),
                                    Text(
                                      'Request',
                                      style: FontStyle.primarySmallBold,
                                    ),
                                    Text(
                                      '308.42',
                                      style: FontStyle.textHintbox,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
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
