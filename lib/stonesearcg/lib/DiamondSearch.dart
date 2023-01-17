import 'package:flutter/material.dart';
import 'package:stonesearch/Liabrary/AppColors.dart';
import 'package:stonesearch/Liabrary/TextStyle.dart';
import 'package:stonesearch/Models/SearchModel.dart';

class DiamondSearch extends StatefulWidget {
  const DiamondSearch({Key? key}) : super(key: key);

  @override
  State<DiamondSearch> createState() => _DiamondSearchState();
}

enum RType { all, ex, vg, g }

class _DiamondSearchState extends State<DiamondSearch> {
  final _formKey = GlobalKey<FormState>();
  List<String> shapeList = [];
  bool isAdvanceSearch = false;
  RType rr = RType.all;
  SearchModel sData = SearchModel();

  List<dynamic> sList = [
    {
      'img': 'assets/image/D_ROUND.jpg',
      'himg': 'assets/image/H_ROUND.jpg',
      'shape': 'ROUND',
    },
    {
      'img': 'assets/image/D_PRINCESS.jpg',
      'himg': 'assets/image/H_PRINCESS.jpg',
      'shape': 'PRINCESS',
    },
    {
      'img': 'assets/image/D_CUSHION.jpg',
      'himg': 'assets/image/H_CUSHION.jpg',
      'shape': 'CUSHION',
    },
    {
      'img': 'assets/image/D_OVAL.jpg',
      'himg': 'assets/image/H_OVAL.jpg',
      'shape': 'OVAL',
    },
    {
      'img': 'assets/image/D_PEAR.jpg',
      'himg': 'assets/image/H_PEAR.jpg',
      'shape': 'PEAR',
    },
    {
      'img': 'assets/image/D_MARQUISE.jpg',
      'himg': 'assets/image/H_MARQUISE.jpg',
      'shape': 'MARQUISE',
    },
    {
      'img': 'assets/image/D_HEART.jpg',
      'himg': 'assets/image/H_HEART.jpg',
      'shape': 'HEART',
    },
    {
      'img': 'assets/image/D_EMERALD.jpg',
      'himg': 'assets/image/H_EMERALD.jpg',
      'shape': 'EMERALD',
    },
    {
      'img': 'assets/image/D_SQUAREEMERALD.jpg',
      'himg': 'assets/image/H_SQUAREEMERALD.jpg',
      'shape': 'SQUARE EMERALD',
    },
    {
      'img': 'assets/image/D_RADIANT.jpg',
      'himg': 'assets/image/H_RADIANT.jpg',
      'shape': 'RADIANT',
    },
  ];

  List<String> colorList = [
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O-P",
    "Q-R",
    "S-T",
    "U-V",
    "W-X",
    "Y-Z"
  ];
  List<String> colorListS = [];

  List<String> clarityList = [
    "FL",
    "IF",
    "VVS1",
    "VVS2",
    "VS1",
    "VS2",
    "SI1",
    "SI2",
    "I1",
    "I2",
    "I3"
  ];
  List<String> clarityListS = [];

  List<String> cutList = ["EX", "VG", "G"];
  List<String> cutListS = [];

  List<String> polishList = ["EX", "VG", "G"];
  List<String> polishListS = [];

  List<String> symList = ["EX", "VG", "G"];
  List<String> symListS = [];

  List<dynamic> floList = [
    {
      "id": "N",
      "value": "NON",
    },
    {
      "id": "VSL",
      "value": "VSL",
    },
    {
      "id": "F",
      "value": "FNT",
    },
    {
      "id": "M",
      "value": "MED",
    },
    {
      "id": "S",
      "value": "STG",
    },
    {
      "id": "VST",
      "value": "VST",
    },
  ];
  //N,VSL,F,M,S,VST
  //["NON","VSL","FNT","MED","STG","VST"];
  List<String> floListS = [];

  List<String> labList = ["GIA", "IGI", "HRD"];
  List<String> labListS = [];

  TextEditingController stoneId = TextEditingController();
  TextEditingController reportNo = TextEditingController();

  TextEditingController weightFrom = TextEditingController();
  TextEditingController weightTo = TextEditingController();

  TextEditingController depthFrom = TextEditingController();
  TextEditingController depthTo = TextEditingController();

  TextEditingController tableFrom = TextEditingController();
  TextEditingController tableTo = TextEditingController();

  TextEditingController cHeightFrom = TextEditingController();
  TextEditingController cHeightTo = TextEditingController();

  TextEditingController cAngleFrom = TextEditingController();
  TextEditingController cAngleTo = TextEditingController();

  TextEditingController pHeightFrom = TextEditingController();
  TextEditingController pHeightTo = TextEditingController();

  TextEditingController pAngleFrom = TextEditingController();
  TextEditingController pAngleTo = TextEditingController();

  TextEditingController lenFrom = TextEditingController();
  TextEditingController lenTo = TextEditingController();

  TextEditingController widthFrom = TextEditingController();
  TextEditingController widthTo = TextEditingController();

  TextEditingController heightFrom = TextEditingController();
  TextEditingController heightTo = TextEditingController();

  resetData() {
    sData = SearchModel();

    stoneId.text = "";
    reportNo.text = "";

    weightFrom.text = "";
    weightTo.text = "";

    depthFrom.text = "";
    depthTo.text = "";

    tableFrom.text = "";
    tableTo.text = "";

    cHeightFrom.text = "";
    cHeightTo.text = "";

    cAngleFrom.text = "";
    cAngleTo.text = "";

    pHeightFrom.text = "";
    pHeightTo.text = "";

    pAngleFrom.text = "";
    pAngleTo.text = "";

    lenFrom.text = "";
    lenTo.text = "";

    widthFrom.text = "";
    widthTo.text = "";

    heightFrom.text = "";
    heightTo.text = "";

    shapeList.clear();
    isAdvanceSearch = false;
    rr = RType.all;

    colorListS.clear();

    clarityListS.clear();

    cutListS.clear();

    polishListS.clear();

    symListS.clear();

    floListS.clear();

    labListS.clear();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white_00,
      appBar: AppBar(
        title: Text(
          'Diamond Search',
          style: FontStyle.textHeaderBlack,
        ),
        titleSpacing: 5,
        actions: [
          IconButton(
              onPressed: () {
                resetData();
              },
              icon: const Icon(
                Icons.refresh_rounded,
                color: AppColors.white_00,
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    color: AppColors.white_40,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(left: 10),
                    height: 45,
                    child: Row(
                      children: [
                        Text(
                          "SHAPE",
                          style: FontStyle.textLabelWhite.copyWith(
                              color: AppColors.primaryColor, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: sList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        mainAxisExtent: 75,
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            if (shapeList.contains(sList[index]['shape'])) {
                              shapeList.remove(sList[index]['shape']);
                            } else {
                              shapeList.add(sList[index]['shape']);
                            }
                            setState(() {});
                          },
                          child: Container(
                            padding: const EdgeInsets.only(top: 3),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.grey_09,
                                  width: 0.4,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Image.asset(
                                  shapeList.contains(sList[index]['shape'])
                                      ? sList[index]['himg']
                                      : sList[index]['img'],
                                  scale: 1.5,
                                ),
                                Text(
                                  sList[index]['shape'],
                                  style: FontStyle.primaryLabelSmall
                                      .copyWith(fontSize: 9),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ), //shapes

              Column(
                children: [
                  Container(
                    color: AppColors.white_40,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    height: 45,
                    child: Row(
                      children: [
                        Text(
                          "BASIC SEARCH",
                          style: FontStyle.textLabelWhite.copyWith(
                              color: AppColors.primaryColor, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio<RType>(
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => AppColors.primaryColor),
                            value: RType.all,
                            groupValue: rr,
                            onChanged: (RType? value) {
                              cutListS.clear();
                              polishListS.clear();
                              symListS.clear();
                              setState(() {
                                rr = value!;
                              });
                            },
                          ),
                          const Text(
                            "ALL",
                            style: FontStyle.primarySmallBold,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio<RType>(
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => AppColors.primaryColor),
                            value: RType.ex,
                            groupValue: rr,
                            onChanged: (RType? value) {
                              cutListS.clear();
                              polishListS.clear();
                              symListS.clear();

                              cutListS.add("EX");
                              polishListS.add("EX");
                              symListS.add("EX");
                              setState(() {
                                rr = value!;
                              });
                            },
                          ),
                          const Text(
                            "3 EX",
                            style: FontStyle.primarySmallBold,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio<RType>(
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => AppColors.primaryColor),
                            value: RType.vg,
                            groupValue: rr,
                            onChanged: (RType? value) {
                              cutListS.clear();
                              polishListS.clear();
                              symListS.clear();

                              cutListS.add("VG");
                              polishListS.add("VG");
                              symListS.add("VG");

                              cutListS.add("EX");
                              polishListS.add("EX");
                              symListS.add("EX");
                              setState(() {
                                rr = value!;
                              });
                            },
                          ),
                          const Text(
                            "3 VG+",
                            style: FontStyle.primarySmallBold,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio<RType>(
                            fillColor: MaterialStateColor.resolveWith(
                                (states) => AppColors.primaryColor),
                            value: RType.g,
                            groupValue: rr,
                            onChanged: (RType? value) {
                              cutListS.clear();
                              polishListS.clear();
                              symListS.clear();

                              cutListS.add("G");
                              polishListS.add("G");
                              symListS.add("G");

                              setState(() {
                                rr = value!;
                              });
                            },
                          ),
                          const Text(
                            "3 VG-",
                            style: FontStyle.primarySmallBold,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              Column(
                children: [
                  Container(
                    color: AppColors.white_40,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(left: 15, top: 10),
                    height: 45,
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Text(
                            "STONE ID",
                            style: FontStyle.textLabelWhite.copyWith(
                                color: AppColors.primaryColor, fontSize: 13),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Text(
                            "REPORT NO",
                            style: FontStyle.textLabelWhite.copyWith(
                                color: AppColors.primaryColor, fontSize: 13),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: TextFormField(
                            controller: stoneId,
                            onSaved: (val) {
                              setState(() {});
                            },
                            style: FontStyle.textInput,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Stone Id',
                                hintStyle: FontStyle.textHint,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10)),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: TextFormField(
                            controller: reportNo,
                            onSaved: (val) {
                              setState(() {});
                            },
                            style: FontStyle.textInput,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Report No',
                                hintStyle: FontStyle.textHint,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ), // stone id

              Column(
                children: [
                  Container(
                    color: AppColors.white_40,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    height: 45,
                    child: Row(
                      children: [
                        Text(
                          "WEIGHT",
                          style: FontStyle.textLabelWhite.copyWith(
                              color: AppColors.primaryColor, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 5.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: TextFormField(
                            controller: weightFrom,
                            style: FontStyle.textInput,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'From',
                                hintStyle: FontStyle.textHint,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10)),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width * 0.45,
                          child: TextFormField(
                            controller: weightTo,
                            style: FontStyle.textInput,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'To',
                                hintStyle: FontStyle.textHint,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ), //weight

              Column(
                children: [
                  Container(
                    color: AppColors.white_40,
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "COLOR",
                          style: FontStyle.textLabelWhite.copyWith(
                              color: AppColors.primaryColor, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowHeight: 30,
                      columnSpacing: 0,
                      dividerThickness: 0.2,
                      horizontalMargin: 0,
                      border: const TableBorder(
                        verticalInside:
                            BorderSide(color: AppColors.grey_00, width: 0.2),
                      ),
                      columns: colorList.map<DataColumn>(
                        (color) {
                          return DataColumn(
                            label: InkWell(
                              onTap: () {
                                if (colorListS.contains(color)) {
                                  colorListS.remove(color);
                                } else {
                                  colorListS.add(color);
                                }
                                setState(() {});
                              },
                              child: Container(
                                height: 30,
                                width: 35,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 0.5),
                                color: colorListS.contains(color)
                                    ? AppColors.primaryColor
                                    : AppColors.white_00,
                                child: Center(
                                    child: Text(
                                  color,
                                  style: FontStyle.textLabelWhite.copyWith(
                                      color: colorListS.contains(color)
                                          ? AppColors.white_00
                                          : AppColors.black),
                                )),
                              ),
                            ),
                          );
                        },
                      ).toList(),
                      rows: [],
                    ),
                  ),

                  /*Table(
                    border: const TableBorder(verticalInside: BorderSide(color: AppColors.grey_00,width: 0.2),),
                    children: [
                      TableRow(
                        children: colorList.map((color) {
                          return InkWell(
                            onTap: () {
                              if(colorListS.contains(color)){
                                colorListS.remove(color);
                              }else{
                                colorListS.add(color);
                              }
                              setState(() {});
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              margin: const EdgeInsets.symmetric(horizontal: 0.5),
                              color:  colorListS.contains(color)?AppColors.primaryColor:AppColors.white_00,
                              child: Center(
                                  child: Text(color,style: FontStyle.textLabelSearchSmall.copyWith(color: colorListS.contains(color)?AppColors.white_00:AppColors.black),)
                              ),
                            ),
                          );
                        }).toList()
                      )
                    ],
                  ),*/
                ],
              ), //color

              Column(
                children: [
                  Container(
                    color: AppColors.white_40,
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "CLARITY",
                          style: FontStyle.textLabelWhite.copyWith(
                              color: AppColors.primaryColor, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Table(
                    border: const TableBorder(
                      verticalInside:
                          BorderSide(color: AppColors.grey_00, width: 0.2),
                    ),
                    children: [
                      TableRow(
                          children: clarityList.map((clearity) {
                        return InkWell(
                          onTap: () {
                            if (clarityListS.contains(clearity)) {
                              clarityListS.remove(clearity);
                            } else {
                              clarityListS.add(clearity);
                            }
                            setState(() {});
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            margin: const EdgeInsets.symmetric(horizontal: 0.5),
                            color: clarityListS.contains(clearity)
                                ? AppColors.primaryColor
                                : AppColors.white_00,
                            child: Center(
                                child: FittedBox(
                                    child: Text(
                              clearity,
                              style: FontStyle.textLabelWhite.copyWith(
                                  color: clarityListS.contains(clearity)
                                      ? AppColors.white_00
                                      : AppColors.black),
                            ))),
                          ),
                        );
                      }).toList())
                    ],
                  ),
                ],
              ), //clearity

              Column(
                children: [
                  Container(
                    color: AppColors.white_40,
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "CUT",
                          style: FontStyle.textLabelWhite.copyWith(
                              color: AppColors.primaryColor, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Table(
                    border: const TableBorder(
                      verticalInside:
                          BorderSide(color: AppColors.grey_00, width: 0.2),
                    ),
                    children: [
                      TableRow(
                          children: cutList.map((cut) {
                        return InkWell(
                          onTap: () {
                            if (cutListS.contains(cut)) {
                              cutListS.remove(cut);
                            } else {
                              cutListS.add(cut);
                            }
                            setState(() {});
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            margin: const EdgeInsets.symmetric(horizontal: 0.5),
                            color: cutListS.contains(cut)
                                ? AppColors.primaryColor
                                : AppColors.white_00,
                            child: Center(
                                child: Text(
                              cut,
                              style: FontStyle.textLabelWhite.copyWith(
                                  color: cutListS.contains(cut)
                                      ? AppColors.white_00
                                      : AppColors.black),
                            )),
                          ),
                        );
                      }).toList())
                    ],
                  ),
                ],
              ), //cut

              Column(
                children: [
                  Container(
                    color: AppColors.white_40,
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "POLISH",
                          style: FontStyle.textLabelWhite.copyWith(
                              color: AppColors.primaryColor, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Table(
                    border: const TableBorder(
                      verticalInside:
                          BorderSide(color: AppColors.grey_00, width: 0.2),
                    ),
                    children: [
                      TableRow(
                          children: polishList.map((polish) {
                        return InkWell(
                          onTap: () {
                            if (polishListS.contains(polish)) {
                              polishListS.remove(polish);
                            } else {
                              polishListS.add(polish);
                            }
                            setState(() {});
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            margin: const EdgeInsets.symmetric(horizontal: 0.5),
                            color: polishListS.contains(polish)
                                ? AppColors.primaryColor
                                : AppColors.white_00,
                            child: Center(
                                child: Text(
                              polish,
                              style: FontStyle.textLabelWhite.copyWith(
                                  color: polishListS.contains(polish)
                                      ? AppColors.white_00
                                      : AppColors.black),
                            )),
                          ),
                        );
                      }).toList())
                    ],
                  ),
                ],
              ), //polish

              Column(
                children: [
                  Container(
                    color: AppColors.white_40,
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "SYMMETRY",
                          style: FontStyle.textLabelWhite.copyWith(
                              color: AppColors.primaryColor, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Table(
                    border: const TableBorder(
                      verticalInside:
                          BorderSide(color: AppColors.grey_00, width: 0.2),
                    ),
                    children: [
                      TableRow(
                          children: symList.map((sym) {
                        return InkWell(
                          onTap: () {
                            if (symListS.contains(sym)) {
                              symListS.remove(sym);
                            } else {
                              symListS.add(sym);
                            }
                            setState(() {});
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            margin: const EdgeInsets.symmetric(horizontal: 0.5),
                            color: symListS.contains(sym)
                                ? AppColors.primaryColor
                                : AppColors.white_00,
                            child: Center(
                                child: Text(
                              sym,
                              style: FontStyle.textLabelWhite.copyWith(
                                  color: symListS.contains(sym)
                                      ? AppColors.white_00
                                      : AppColors.black),
                            )),
                          ),
                        );
                      }).toList())
                    ],
                  ),
                ],
              ), //symmetry

              Column(
                children: [
                  Container(
                    color: AppColors.white_40,
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "FLUORESCENCE",
                          style: FontStyle.textLabelWhite.copyWith(
                              color: AppColors.primaryColor, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Table(
                    border: const TableBorder(
                      verticalInside:
                          BorderSide(color: AppColors.grey_00, width: 0.2),
                    ),
                    children: [
                      TableRow(
                          children: floList.map((flo) {
                        return InkWell(
                          onTap: () {
                            if (floListS.contains(flo['id'])) {
                              floListS.remove(flo['id']);
                            } else {
                              floListS.add(flo['id']);
                            }
                            setState(() {});
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            margin: const EdgeInsets.symmetric(horizontal: 0.5),
                            color: floListS.contains(flo['id'])
                                ? AppColors.primaryColor
                                : AppColors.white_00,
                            child: Center(
                                child: Text(
                              flo['value'],
                              style: FontStyle.textLabelWhite.copyWith(
                                  color: floListS.contains(flo['id'])
                                      ? AppColors.white_00
                                      : AppColors.black),
                            )),
                          ),
                        );
                      }).toList())
                    ],
                  ),
                ],
              ), //fluorescence

              Column(
                children: [
                  Container(
                    color: AppColors.white_40,
                    width: MediaQuery.of(context).size.width,
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    height: 45,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "LAB",
                          style: FontStyle.textLabelWhite.copyWith(
                              color: AppColors.primaryColor, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  Table(
                    border: const TableBorder(
                      verticalInside:
                          BorderSide(color: AppColors.grey_00, width: 0.2),
                    ),
                    children: [
                      TableRow(
                          children: labList.map((lab) {
                        return InkWell(
                          onTap: () {
                            if (labListS.contains(lab)) {
                              labListS.remove(lab);
                            } else {
                              labListS.add(lab);
                            }
                            setState(() {});
                          },
                          child: Container(
                            height: 30,
                            width: 30,
                            margin: const EdgeInsets.symmetric(horizontal: 0.5),
                            color: labListS.contains(lab)
                                ? AppColors.primaryColor
                                : AppColors.white_00,
                            child: Center(
                                child: Text(
                              lab,
                              style: FontStyle.textLabelWhite.copyWith(
                                  color: labListS.contains(lab)
                                      ? AppColors.white_00
                                      : AppColors.black),
                            )),
                          ),
                        );
                      }).toList())
                    ],
                  ),
                  const Divider(
                    color: AppColors.white_40,
                    height: 0,
                    thickness: 1.2,
                  ),
                ],
              ), //lab

              Visibility(
                visible: isAdvanceSearch,
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          color: AppColors.white_40,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          height: 45,
                          child: Row(
                            children: [
                              Text(
                                "DEPTH%",
                                style: FontStyle.textLabelWhite.copyWith(
                                    color: AppColors.primaryColor,
                                    fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Row(
                            children: [
                              Expanded(
                                  child: SizedBox(
                                height: 40,
                                child: TextFormField(
                                  controller: depthFrom,
                                  style: FontStyle.textInput,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'From (%)',
                                      hintStyle: FontStyle.textHint,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10)),
                                ),
                              )),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: SizedBox(
                                height: 40,
                                child: TextFormField(
                                  controller: depthTo,
                                  style: FontStyle.textInput,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'To (%)',
                                      hintStyle: FontStyle.textHint,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10)),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ],
                    ), //depth

                    Column(
                      children: [
                        Container(
                          color: AppColors.white_40,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          height: 45,
                          child: Row(
                            children: [
                              Text(
                                "TABLE%",
                                style: FontStyle.textLabelWhite.copyWith(
                                    color: AppColors.primaryColor,
                                    fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Row(
                            children: [
                              Expanded(
                                  child: SizedBox(
                                height: 40,
                                child: TextFormField(
                                  controller: tableFrom,
                                  style: FontStyle.textInput,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'From (%)',
                                      hintStyle: FontStyle.textHint,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10)),
                                ),
                              )),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: SizedBox(
                                height: 40,
                                child: TextFormField(
                                  controller: tableTo,
                                  style: FontStyle.textInput,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'To (%)',
                                      hintStyle: FontStyle.textHint,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10)),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ],
                    ), //table

                    Column(
                      children: [
                        Container(
                          color: AppColors.white_40,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          height: 45,
                          child: Row(
                            children: [
                              Text(
                                "CROWN HEIGHT%",
                                style: FontStyle.textLabelWhite.copyWith(
                                    color: AppColors.primaryColor,
                                    fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Row(
                            children: [
                              Expanded(
                                  child: SizedBox(
                                height: 40,
                                child: TextFormField(
                                  controller: cHeightFrom,
                                  style: FontStyle.textInput,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'From (%)',
                                      hintStyle: FontStyle.textHint,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10)),
                                ),
                              )),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: SizedBox(
                                height: 40,
                                child: TextFormField(
                                  controller: cHeightTo,
                                  style: FontStyle.textInput,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'To (%)',
                                      hintStyle: FontStyle.textHint,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10)),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ],
                    ), //crown height

                    Column(
                      children: [
                        Container(
                          color: AppColors.white_40,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          height: 45,
                          child: Row(
                            children: [
                              Text(
                                "CROWN ANGLE",
                                style: FontStyle.textLabelWhite.copyWith(
                                    color: AppColors.primaryColor,
                                    fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Row(
                            children: [
                              Expanded(
                                  child: SizedBox(
                                height: 40,
                                child: TextFormField(
                                  controller: cAngleFrom,
                                  style: FontStyle.textInput,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'From (%)',
                                      hintStyle: FontStyle.textHint,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10)),
                                ),
                              )),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: SizedBox(
                                height: 40,
                                child: TextFormField(
                                  controller: cAngleTo,
                                  style: FontStyle.textInput,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'To (%)',
                                      hintStyle: FontStyle.textHint,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10)),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ],
                    ), //crown angel

                    Column(
                      children: [
                        Container(
                          color: AppColors.white_40,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          height: 45,
                          child: Row(
                            children: [
                              Text(
                                "PAVILLION HEIGHT%",
                                style: FontStyle.textLabelWhite.copyWith(
                                    color: AppColors.primaryColor,
                                    fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Row(
                            children: [
                              Expanded(
                                  child: SizedBox(
                                height: 40,
                                child: TextFormField(
                                  controller: pHeightFrom,
                                  style: FontStyle.textInput,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'From (%)',
                                      hintStyle: FontStyle.textHint,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10)),
                                ),
                              )),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: SizedBox(
                                height: 40,
                                child: TextFormField(
                                  controller: pHeightTo,
                                  style: FontStyle.textInput,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'To (%)',
                                      hintStyle: FontStyle.textHint,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10)),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ],
                    ), //pavillion height

                    Column(
                      children: [
                        Container(
                          color: AppColors.white_40,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          height: 45,
                          child: Row(
                            children: [
                              Text(
                                "PAVILLION ANGLE",
                                style: FontStyle.textLabelWhite.copyWith(
                                    color: AppColors.primaryColor,
                                    fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Row(
                            children: [
                              Expanded(
                                  child: SizedBox(
                                height: 40,
                                child: TextFormField(
                                  controller: pAngleFrom,
                                  style: FontStyle.textInput,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'From (%)',
                                      hintStyle: FontStyle.textHint,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10)),
                                ),
                              )),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: SizedBox(
                                height: 40,
                                child: TextFormField(
                                  controller: pAngleTo,
                                  style: FontStyle.textInput,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'To (%)',
                                      hintStyle: FontStyle.textHint,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10)),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ],
                    ), //pavillion angel

                    Column(
                      children: [
                        Container(
                          color: AppColors.white_40,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          height: 45,
                          child: Row(
                            children: [
                              Text(
                                "LENGTH",
                                style: FontStyle.textLabelWhite.copyWith(
                                    color: AppColors.primaryColor,
                                    fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Row(
                            children: [
                              Expanded(
                                  child: SizedBox(
                                height: 40,
                                child: TextFormField(
                                  controller: lenFrom,
                                  style: FontStyle.textInput,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'From (%)',
                                      hintStyle: FontStyle.textHint,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10)),
                                ),
                              )),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: SizedBox(
                                height: 40,
                                child: TextFormField(
                                  controller: lenTo,
                                  style: FontStyle.textInput,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'To (%)',
                                      hintStyle: FontStyle.textHint,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10)),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ],
                    ), //legth

                    Column(
                      children: [
                        Container(
                          color: AppColors.white_40,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          height: 45,
                          child: Row(
                            children: [
                              Text(
                                "WIDTH",
                                style: FontStyle.textLabelWhite.copyWith(
                                    color: AppColors.primaryColor,
                                    fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Row(
                            children: [
                              Expanded(
                                  child: SizedBox(
                                height: 40,
                                child: TextFormField(
                                  controller: widthFrom,
                                  style: FontStyle.textInput,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'From (%)',
                                      hintStyle: FontStyle.textHint,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10)),
                                ),
                              )),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: SizedBox(
                                height: 40,
                                child: TextFormField(
                                  controller: widthTo,
                                  style: FontStyle.textInput,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'To (%)',
                                      hintStyle: FontStyle.textHint,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10)),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ],
                    ), //width

                    Column(
                      children: [
                        Container(
                          color: AppColors.white_40,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          height: 45,
                          child: Row(
                            children: [
                              Text(
                                "HEIGHT",
                                style: FontStyle.textLabelWhite.copyWith(
                                    color: AppColors.primaryColor,
                                    fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Row(
                            children: [
                              Expanded(
                                  child: SizedBox(
                                height: 40,
                                child: TextFormField(
                                  controller: heightFrom,
                                  style: FontStyle.textInput,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'From (%)',
                                      hintStyle: FontStyle.textHint,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10)),
                                ),
                              )),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: SizedBox(
                                height: 40,
                                child: TextFormField(
                                  controller: heightTo,
                                  style: FontStyle.textInput,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'To (%)',
                                      hintStyle: FontStyle.textHint,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10)),
                                ),
                              )),
                            ],
                          ),
                        ),
                      ],
                    ), //height
                  ],
                ),
              ),

              InkWell(
                onTap: () {
                  if (isAdvanceSearch) {
                    isAdvanceSearch = false;
                  } else {
                    isAdvanceSearch = true;
                  }
                  setState(() {});
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    isAdvanceSearch
                        ? "HIDE ADVANCED SEARCH >"
                        : "ADVANCED SEARCH >",
                    style: FontStyle.textHint,
                  ),
                ),
              ),

              ElevatedButton(
                  onPressed: () {
                    _formKey.currentState!.save();
                    // bindData();
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => SearchResult(
                    //         sModel: sData,
                    //       ),
                    //     ));
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size.fromHeight(40),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      padding: const EdgeInsets.symmetric(horizontal: 25)),
                  child: const Text(
                    'Search',
                    style: FontStyle.textButton,
                  )),

              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
