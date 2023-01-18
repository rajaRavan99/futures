import 'package:cfsys/addstock.dart';
import 'package:cfsys/addstocknewpage.dart';
import 'package:cfsys/colors.dart';
import 'package:cfsys/emptystate.dart';
import 'package:cfsys/multiform.dart';
import 'package:cfsys/stylepage/textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: camel_case_types
class dashboard extends StatelessWidget {
  const dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(DataController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "DashBoard",
          style: CustomTextStyle.apptitle,
        ),
        backgroundColor: AppColors.primarycolor2,
        elevation: 0.0,
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         navigator!.pop(context);
        //       },
        //       icon: Icon(Icons.arrow_back))
        // ],
      ),
      drawer: const Drawer(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 5,
                        margin:
                            const EdgeInsets.only(top: 15, left: 10, right: 5),
                        shape: RoundedRectangleBorder(
                          side:
                              const BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        color: Colors.white,
                        child: Container(
                          height: 200,
                          width: context.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 12, left: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Total Stock',
                                      style: CustomTextStyle.style1,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 80,
                                width: context.width,
                                color: Colors.transparent,
                                margin: const EdgeInsets.all(10),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.diamond,
                                      color: Colors.black38,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 50, top: 10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'USD',
                                          style: CustomTextStyle.style1,
                                        ),
                                        Text(
                                          '3854.67',
                                          style: CustomTextStyle.style11,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        color: Colors.white,
                        elevation: 5,
                        margin:
                            const EdgeInsets.only(top: 15, left: 5, right: 10),
                        shape: RoundedRectangleBorder(
                          side:
                              const BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          height: 200,
                          width: context.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 12, left: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Reciver',
                                      style: CustomTextStyle.style1,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 80,
                                width: context.width,
                                color: Colors.transparent,
                                margin: const EdgeInsets.all(10),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.account_tree_outlined,
                                      color: Colors.black38,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 50, top: 10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'USD',
                                          style: CustomTextStyle.style1,
                                        ),
                                        Text(
                                          '1.0803',
                                          style: CustomTextStyle.style11,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                //row start :-
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          height: 80,
                          width: 40,
                          margin: const EdgeInsets.only(
                              bottom: 0, right: 5, left: 10, top: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.biotech,
                                  color: AppColors.logo_70,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text("Today po",
                                    style: CustomTextStyle.style444),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  "36,641.20",
                                  style: CustomTextStyle.bigtextblack,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 80,
                          width: 40,
                          margin: const EdgeInsets.only(
                              bottom: 0, right: 5, left: 5, top: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.settings,
                                  color: AppColors.logo_70,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text("Receivable",
                                    style: CustomTextStyle.style444),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  "36,641.20",
                                  style: CustomTextStyle.bigtextblack,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 80,
                          width: 40,
                          margin: const EdgeInsets.only(
                              bottom: 0, right: 10, left: 5, top: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0, top: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.compare_arrows_sharp,
                                  color: AppColors.logo_70,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text("Total Stock",
                                    style: CustomTextStyle.style444),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  textAlign: TextAlign.center,
                                  "36,641.20",
                                  style: CustomTextStyle.bigtextblack,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //row start :-
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        ClipOval(
                          child: Container(
                            height: 80,
                            width: 80,
                            margin: const EdgeInsets.only(
                                bottom: 10, right: 5, left: 20, top: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: AppColors.greywhite,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_right_alt,
                                color: AppColors.logo_70,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'DEPOSIT',
                          style: CustomTextStyle.style44,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ClipOval(
                          child: Container(
                            height: 80,
                            width: 80,
                            margin: const EdgeInsets.only(
                                bottom: 10, right: 5, left: 5, top: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: AppColors.greywhite,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_right_alt_sharp,
                                color: AppColors.logo_70,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'WITHDRAW',
                          style: CustomTextStyle.style44,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ClipOval(
                          child: Container(
                            height: 80,
                            width: 80,
                            margin: const EdgeInsets.only(
                                bottom: 10, right: 20, left: 5, top: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: AppColors.greywhite,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.voicemail,
                                color: AppColors.logo_70,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'ANALYTICS',
                          style: CustomTextStyle.style44,
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        ClipOval(
                          child: GestureDetector(
                            onTap: () {
                              var message;
                              var title;
                              Get.to(MultiForm());
                            },
                            child: Container(
                              height: 80,
                              width: 80,
                              margin: const EdgeInsets.only(
                                  bottom: 10, right: 5, left: 20, top: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.0),
                                color: AppColors.greywhite,
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.add,
                                  color: AppColors.logo_70,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'ADD STOCK',
                          style: CustomTextStyle.style44,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ClipOval(
                          child: Container(
                            height: 80,
                            width: 80,
                            margin: const EdgeInsets.only(
                                bottom: 10, right: 5, left: 5, top: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: AppColors.greywhite,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.delete_outline,
                                color: AppColors.logo_70,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'WITHDRAW2',
                          style: CustomTextStyle.style44,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ClipOval(
                          child: Container(
                            height: 80,
                            width: 80,
                            margin: const EdgeInsets.only(
                                bottom: 10, right: 20, left: 5, top: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                              color: AppColors.greywhite,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.transform_rounded,
                                color: AppColors.logo_70,
                                size: 22,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'ANALYTICS2',
                          style: CustomTextStyle.style44,
                        ),
                      ],
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
