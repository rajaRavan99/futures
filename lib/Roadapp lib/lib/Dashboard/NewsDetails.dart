import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:roadapp/Library/AppDrawer.dart';
import 'package:roadapp/Library/TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:roadapp/Library/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Library/AppColors.dart';

class NewsDetails extends StatefulWidget {
  NewsDetails({Key? key}) : super(key: key);

  @override
  _NewsDetailsState createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        titleSpacing: 5,
        title: const Padding(
          padding: EdgeInsets.only(bottom: 5, left: 10.0),
          child: Text("Description", style: FontStyle.textHeader),
        ),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [

            CarouselSlider.builder(
              itemCount: 1,
              carouselController: _controller,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage('assets/image/news.jpg'),
                        fit: BoxFit.fill,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
                height: 250,
                autoPlay: true,
                //aspectRatio: 1 / 0.8,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: false,
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                viewportFraction: 1,
              ),
            ),

            Visibility(
              visible: false,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [0].asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: _current == entry.key ? Container(
                      width: 12.0,
                      height: 12.0,
                      margin:
                          const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black)
                              .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                    ):Container(
                      width: 8.0,
                      height: 8.0,
                      margin:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black)
                              .withOpacity(_current == entry.key ? 0.6 : 0.1)),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children:  [

                  Expanded(
                    child: Text("Description",
                      style: FontStyle.textBold.copyWith(fontSize: 19),
                    ),
                  ),
              ],
              ),
            ),

            const SizedBox(height: 10),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: AppColors.white_00,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 15.0),
                child: Expanded(
                    child: Text(
                  "wdasddff xbhasjk sdjkcasd dcasudh bsahbcbsa jhabdjh ajsdgg ajdgGS Gaygdg jAGJG SAshgfa JVdayjfgd jahvdgjgj JGadjgs jAYGDYAUg jACDS SDCSF SDVSDC SVSD CVSDFC SDFCDA WFSDFASFCvrs srhgserdfg rrsbfxxbsf sfbvsgbsfhsr srgrsgdfsgvsdf sfsgsergfvdhbrd xfghdfhh buGVgvy buygguyg HBugB BHBHSDBHSBD HUDBSBCHUDSBC  DSHJBCHD DSH CHSDC  SDHC SGDH CHGSD H C DSHG C SD CSGHJD  DV HSD VGHDV VGHV V  VHGS  VDS HGVD VGHVD VGHDS JYGDYG jagsjygayS JHagsgS JVHSAGDJHDS BHCJSBDHJ JDSAGDJGASH sabbughduihas dhjsabdhad sdaihdiuhsad sadbbsadhgsad dhsbadhadh jasdbbdas dasbdshad sdbsbdsadsahbsd dhjsadbsabd dbsdhsad dhasbdjh dhjsabds dajshbdjas dhjabd",
                  style: FontStyle.textLabelSmall,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
