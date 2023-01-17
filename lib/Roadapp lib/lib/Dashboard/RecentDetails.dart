import 'package:carousel_slider/carousel_slider.dart';
import 'package:roadapp/Library/TextStyle.dart';
import 'package:flutter/material.dart';
import '../Library/AppColors.dart';
import '../Library/Utils.dart';

class RecentDetails extends StatefulWidget {
  const RecentDetails({Key? key}) : super(key: key);

  @override
  _RecentDetailsState createState() => _RecentDetailsState();
}

class _RecentDetailsState extends State<RecentDetails> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  int _current = 0;
  final CarouselController _controller = CarouselController();

  commentSection(){
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SizedBox(
            //width: MediaQuery.of(context).size.width - 100,
            child: AlertDialog(
              insetPadding: const EdgeInsets.all(20.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              content: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    TextFormField(
                      maxLines: 6,
                      style: FontStyle.textInput,
                      decoration: Utils().inputDecoration('Comment'),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Utils().primaryButton("Post Comment", MediaQuery.of(context).size.width*0.7),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
  }

  // (Padding(
  // padding: const EdgeInsets.all(15.0),
  // child: Column(
  // crossAxisAlignment: CrossAxisAlignment.center,
  // children: [
  //
  // const Text("Profile"),
  // const SizedBox(height: 10),
  // Row(
  // mainAxisAlignment: MainAxisAlignment.center,
  // children: [
  // Stack(
  // children: [
  // InkWell(
  // onTap: (){},
  // child: Container(
  // height: 140,
  // width: 140,
  // decoration: BoxDecoration(
  // shape: BoxShape.circle,
  // border: Border.all(
  // color: AppColors.grey_10,
  // )
  // ),
  // child: const Center(child: Text("Add\nPhoto",style: FontStyle.textHint)),
  // ),
  // ),
  // Positioned(
  // right: 9,
  // bottom: 10,
  // child: Icon(Icons.add,color: AppColors.grey_10,)
  // ),
  // ],
  // ),
  // ],
  // ),
  //
  // ],
  // ),
  // ),)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        titleSpacing: 5,
        title: const Padding(
          padding: EdgeInsets.only(bottom: 5, left: 10.0),
          child: Text("Detail", style: FontStyle.textHeader),
        ),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                          image: AssetImage('assets/image/truck.jpg'),
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
              const SizedBox(height: 15),
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

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
                child: Row(
                  children: [
                    Text("Comments",style: FontStyle.textBold.copyWith(fontWeight: FontWeight.w300)),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 55.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("gururandhawa",style: FontStyle.textBold),
                            Image.asset('assets/image/tick.png',height: 28,width: 28,),
                            SizedBox(width: 3),
                            Text("46m",style: FontStyle.textHint),

                          ],
                        ),
                        SizedBox(height: 2),
                        Row(
                          children: [
                            Text("Teaser of Fayaah Fayaah is here.",style: FontStyle.textLabel),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Song releasing today",style: FontStyle.textLabel),
                            SizedBox(width: 2),
                            Image.asset('assets/image/blast.png',height: 20,width:20),
                            SizedBox(width: 1),
                            Image.asset('assets/image/rocket.png',height: 20,width:20),
                          ],
                        ),
                        Row(
                          children: [
                            Text("@nargisfakhri @tseries.official @rupanbal",style: FontStyle.textLabelBlue),
                          ],
                        ),
                        Row(
                          children: [
                            Text("@officialveemusic #bhusankumar",style: FontStyle.textLabelBlue),
                            Image.asset('assets/image/blast.png',height: 20,width:20),

                          ],
                        ),
                        SizedBox(height: 3),
                        Row(
                          children: [
                            SizedBox(width: 5),
                            InkWell(
                                onTap: (){
                                  commentSection();
                                },
                                child: Text("Reply",style: FontStyle.textHint)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset('assets/image/profile.png',height: 50,width: 50),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 55.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("rupanbal",style: FontStyle.textBold),
                            Image.asset('assets/image/tick.png',height: 28,width: 28,),
                            SizedBox(width: 3),
                            Text("37m",style: FontStyle.textHint),

                          ],
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Text("Insane",style: FontStyle.textLabel),
                            SizedBox(width: 1),
                            Image.asset('assets/image/fire.png',height: 20,width:20),
                            SizedBox(width: 1),
                            Image.asset('assets/image/fire.png',height: 20,width:20),
                            Text("I can't believe we shot this",style: FontStyle.textLabel),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("MOVIES",style: FontStyle.textLabel),
                            Image.asset('assets/image/record.png',height: 30,width:30),
                            Image.asset('assets/image/heart.png',height: 18,width:18),
                            const SizedBox(width: 3),
                            Image.asset('assets/image/fire.png',height: 20,width:20),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Song releasing tomorrow",style: FontStyle.textLabel),
                            const SizedBox(width: 2),
                            Image.asset('assets/image/blast.png',height: 20,width:20),
                            const SizedBox(width: 1),
                            Image.asset('assets/image/rocket.png',height: 20,width:20),
                          ],
                        ),
                        Row(
                          children: const [
                            Text("@nargisfakhri @tseries.official @rupanbal",style: FontStyle.textLabelBlue),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("@officialveemusic #bhusankumar",style: FontStyle.textLabelBlue),
                            Image.asset('assets/image/blast.png',height: 20,width:20),

                          ],
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            SizedBox(width: 5),
                            InkWell(
                                onTap: (){
                                  commentSection();
                                },
                                child: Text("Reply",style: FontStyle.textHint)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset('assets/image/rupanbal.png',height: 50,width: 50),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              InkWell(
                onTap: () {
                  commentSection();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("+", style: FontStyle.textTitleSmallWhite),
                      SizedBox(width: 9),
                      Text("Add Comment", style: FontStyle.textTitleSmallWhite),
                    ],
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
