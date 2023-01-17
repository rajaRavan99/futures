import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:roadapp/Dashboard/NewsDetails.dart';
import 'package:roadapp/Library/AppDrawer.dart';
import 'package:roadapp/Library/TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:roadapp/Library/Utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Library/AppColors.dart';

class NewsList extends StatefulWidget {
  NewsList({Key? key}) : super(key: key);

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  viewCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewsDetails()));
        },
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: AppColors.white_00,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 170,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            color: AppColors.white_00,
                            image: DecorationImage(
                              image: AssetImage('assets/image/truck.jpg'),
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.grey_10.withOpacity(0.8),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text("+3",
                                style: FontStyle.textTitleSmallWhite),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: const [
                    Text(
                      "Description",
                      style: FontStyle.textLabel,
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: const [
                    Expanded(
                      child: Text(
                        "Description jhbjhg jhghu jhgyf hjftf hjftysjandk sabcjsakhc sajcbshc scsuyc hsdygs hdygs hgsdhg nsdbhsg bsvdg bsfdg bshfdysg hfsdg dbsvdg hsfdg bsdgsfd dsfdsgf dsgdgsv dbsvdgsjbsdjbd  bsjhbdj bsjbd bsjbd bsjd nbsjdsjdnajdn hsbadbhdb bvsdhhjsbbd f jguyg jhgyufuf hguh vuhfdivid vbfdhv",
                        style: FontStyle.textLabelSmall,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        titleSpacing: 5,
        title: const Padding(
          padding: EdgeInsets.only(bottom: 5, left: 10.0),
          child: Text("News List", style: FontStyle.textHeader),
        ),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:12.0,vertical: 12),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewsDetails()));
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: AppColors.white_00,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: 170,
                                child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10.0)),
                                      color: AppColors.white_00,
                                      image: DecorationImage(
                                        image: AssetImage('assets/image/news.jpg'),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ),
                              Positioned(
                                right: 8,
                                bottom: 8,
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppColors.green_00.withOpacity(0.8),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Solved",
                                          style: FontStyle.textTitleSmallWhite),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: const [
                              Text(
                                "Description",
                                style: FontStyle.textLabel,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: const [
                              Expanded(
                                child: Text(
                                  "Description jhbjhg jhghu jhgyf hjftf hjftysjandk sabcjsakhc sajcbshc scsuyc hsdygs hdygs hgsdhg nsdbhsg bsvdg bsfdg bshfdysg hfsdg dbsvdg hsfdg bsdgsfd dsfdsgf dsgdgsv dbsvdgsjbsdjbd  bsjhbdj bsjbd bsjbd bsjd nbsjdsjdnajdn hsbadbhdb bvsdhhjsbbd f jguyg jhgyufuf hguh vuhfdivid vbfdhv",
                                  style: FontStyle.textLabelSmall,
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewsDetails()));
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: AppColors.white_00,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: 170,
                                child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10.0)),
                                      color: AppColors.white_00,
                                      image: DecorationImage(
                                        image: AssetImage('assets/image/news.jpg'),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ),
                              Positioned(
                                right: 8,
                                bottom: 8,
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppColors.yellow_00.withOpacity(0.8),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Investigation",
                                          style: FontStyle.textTitleSmallWhite),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: const [
                              Text(
                                "Description",
                                style: FontStyle.textLabel,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: const [
                              Expanded(
                                child: Text(
                                  "Description jhbjhg jhghu jhgyf hjftf hjftysjandk sabcjsakhc sajcbshc scsuyc hsdygs hdygs hgsdhg nsdbhsg bsvdg bsfdg bshfdysg hfsdg dbsvdg hsfdg bsdgsfd dsfdsgf dsgdgsv dbsvdgsjbsdjbd  bsjhbdj bsjbd bsjbd bsjd nbsjdsjdnajdn hsbadbhdb bvsdhhjsbbd f jguyg jhgyufuf hguh vuhfdivid vbfdhv",
                                  style: FontStyle.textLabelSmall,
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewsDetails()));
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: AppColors.white_00,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: 170,
                                child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10.0)),
                                      color: AppColors.white_00,
                                      image: DecorationImage(
                                        image: AssetImage('assets/image/news.jpg'),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                              ),
                              Positioned(
                                right: 8,
                                bottom: 8,
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppColors.red_00.withOpacity(0.8),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Pending",
                                          style: FontStyle.textTitleSmallWhite),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: const [
                              Text(
                                "Description",
                                style: FontStyle.textLabel,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: const [
                              Expanded(
                                child: Text(
                                  "Description jhbjhg jhghu jhgyf hjftf hjftysjandk sabcjsakhc sajcbshc scsuyc hsdygs hdygs hgsdhg nsdbhsg bsvdg bsfdg bshfdysg hfsdg dbsvdg hsfdg bsdgsfd dsfdsgf dsgdgsv dbsvdgsjbsdjbd  bsjhbdj bsjbd bsjbd bsjd nbsjdsjdnajdn hsbadbhdb bvsdhhjsbbd f jguyg jhgyufuf hguh vuhfdivid vbfdhv",
                                  style: FontStyle.textLabelSmall,
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
