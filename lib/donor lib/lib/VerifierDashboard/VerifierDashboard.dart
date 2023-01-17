import 'package:donor/Library/TextStyle.dart';
import 'package:donor/VerifierDashboard/VStudentList.dart';
import 'package:donor/VerifierDashboard/VerifierDrawer.dart';
import 'package:flutter/material.dart';
import '../model/ChartModel.dart';

class VerifierDashboard extends StatefulWidget {
  const VerifierDashboard({Key? key}) : super(key: key);

  @override
  State<VerifierDashboard> createState() => _VerifierDashboardState();
}

class _VerifierDashboardState extends State<VerifierDashboard> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verifier Dashboard'),
      ),
      drawer: const VerifierDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [

                const SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    InkWell(
                      onTap: () {
                        // status == 1 (Pending) OR status == 2 (Verified)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VStudentList(status: "2",)),
                        );
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
                                  'Verified Students',
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
                        // status == 1 (Pending) OR status == 2 (Verified)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const VStudentList(status: "1",)),
                        );
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
                                  'No.of Pending',
                                  style: FontStyle.primarySmallBold,
                                ),
                                Text(
                                  'Verification',
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
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
