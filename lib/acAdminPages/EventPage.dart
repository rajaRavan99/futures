import 'package:acadmin/Library/AppColors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

import 'DetailPage.dart';
import 'SettingPage.dart';

class EventPage extends StatefulWidget {
  const EventPage({Key? key}) : super(key: key);

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String formattedDate = DateFormat('dd - MMMM - yyyy').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'Event',
          style: tStyle.text_header,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_active_outlined,
              color: AppColors.white_00,
            ),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => SettingPage()),
              // );
            },
          ),
        ],
        backgroundColor: AppColors.blue,
      ),
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
          Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
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
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DetailPage()),
                                      );
                                    },
                                    child: Card(
                                      elevation: 2,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: CarouselSlider(
                                        items: [
                                          //1st Image of Slider
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: Colors.white,
                                              image: const DecorationImage(
                                                  image: NetworkImage(
                                                      "https://th.bing.com/th/id/OIP.0YvjbnRaBh5tvs0O1HgQmAHaFj?pid=ImgDet&rs=1"),
                                                  fit: BoxFit.fitWidth),
                                            ),
                                          ),

                                          //2nd Image of Slider
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              color: Colors.white,
                                              image: const DecorationImage(
                                                image: NetworkImage(
                                                    "https://th.bing.com/th/id/OIP.0YvjbnRaBh5tvs0O1HgQmAHaFj?pid=ImgDet&rs=1"),
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                          ),
                                        ],
                                        //Slider Container properties
                                        options: CarouselOptions(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.20,
                                          enlargeCenterPage: true,
                                          autoPlay: false,
                                          reverse: true,
                                          aspectRatio: 16 / 9,
                                          autoPlayCurve: Curves.fastOutSlowIn,
                                          enableInfiniteScroll: true,
                                          autoPlayAnimationDuration:
                                              const Duration(milliseconds: 800),
                                          viewportFraction: 0.8,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Student Event's ",
                                          style: tStyle.text_label_big
                                              .copyWith(letterSpacing: 0.5),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                  "The Sky and ran on the Android operating system.",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                  style: tStyle
                                                      .common_label_black
                                                      .copyWith(fontSize: 16)),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.timer,
                                              size: 20,
                                              color: AppColors.primaryColor,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(formattedDate,
                                                style:
                                                    tStyle.common_label_black),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.location_on,
                                                    size: 20,
                                                    color:
                                                        AppColors.primaryColor),
                                                Text('  Surat',
                                                    style: tStyle
                                                        .common_label_black),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
        ],
      ),
    );
  }
}
