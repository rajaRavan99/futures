import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stonesearch/Liabrary/DbProvider.dart';
import 'package:stonesearch/Liabrary/TextStyle.dart';
import 'package:stonesearch/Models/NewSearchModel.dart';
import 'DiamondSearch.dart';
import 'Liabrary/AppColors.dart';
import 'Liabrary/Utils.dart';
import 'package:http/http.dart' as http;


class DashBoard2 extends StatefulWidget {
  const DashBoard2({Key? key}) : super(key: key);

  @override
  State<DashBoard2> createState() => _DashBoard2State();
}

class _DashBoard2State extends State<DashBoard2> {

  bool isError = false;
  bool isScroll = true;

  List shapeList = [
    'RD',
    'FNY',
  ];

  List colorList = [
    'D',
    'E',
    'L',
    'M',
    'K',
    'J',
    'H',
    'G',
    'I',
    'N',
  ];

  List clarityList = [
    'IF',
    'VVS1',
    'VVS2',
    'VS1',
    'VS2',
    'SI1',
    'SI2',
    'SI3',
    'I1',
    'I2',
    'I3',
  ];

  List discountList = [
    '-99.00',
    '-98.50',
    '-98.00',
    '-97.50',
    '-97.00',
    '-96.50',
    '-96.00',
    '-95.50',
    '-95.00',
    '-94.50',
    '-94.00',
    '-93.50',
    '-93.00',
    '-92.50',
    '-92.00',
    '-91.50',
    '-91.00',
    '-90.50',
    '-90.00',
    '-89.50',
    '-89.00',
    '-88.50',
    '-88.00',
    '-87.50',
    '-87.00',
    '-86.50',
    '-86.00',
    '-85.50',
    '-85.00',
    '-84.50',
    '-84.00',
    '-83.50',
    '-83.00',
    '-82.50',
    '-82.00',
    '-81.50',
    '-81.00',
    '-80.50',
    '-80.00',
    '-79.50',
    '-79.00',
    '-78.50',
    '-78.00',
    '-77.50',
    '-77.00',
    '-76.50',
    '-76.00',
    '-75.50',
    '-75.00',
    '-74.50',
    '-74.00',
    '-73.50',
    '-73.00',
    '-72.50',
    '-72.00',
    '-71.50',
    '-71.00',
    '-70.50',
    '-70.00',
    '-69.50',
    '-69.00',
    '-68.50',
    '-68.00',
    '-67.50',
    '-67.00',
    '-66.50',
    '-66.00',
    '-65.50',
    '-65.00',
    '-64.50',
    '-64.00',
    '-63.50',
    '-63.00',
    '-62.50',
    '-62.00',
    '-61.50',
    '-61.00',
    '-60.50',
    '-60.00',
    '-59.50',
    '-59.00',
    '-58.50',
    '-58.00',
    '-57.50',
    '-57.00',
    '-56.50',
    '-56.00',
    '-55.50',
    '-55.00',
    '-54.50',
    '-54.00',
    '-53.50',
    '-53.00',
    '-52.50',
    '-52.00',
    '-51.50',
    '-51.00',
    '-50.50',
    '-50.00',
    '-49.50',
    '-49.00',
    '-48.50',
    '-48.00',
    '-47.50',
    '-47.00',
    '-46.50',
    '-46.00',
    '-45.50',
    '-45.00',
    '-44.50',
    '-44.00',
    '-43.50',
    '-43.00',
    '-42.50',
    '-42.00',
    '-41.50',
    '-41.00',
    '-40.50',
    '-40.00',
    '-39.50',
    '-39.00',
    '-38.50',
    '-38.00',
    '-37.50',
    '-37.00',
    '-36.50',
    '-36.00',
    '-35.50',
    '-35.00',
    '-34.50',
    '-34.00',
    '-33.50',
    '-33.00',
    '-32.50',
    '-32.00',
    '-31.50',
    '-31.00',
    '-30.50',
    '-30.00',
    '-29.50',
    '-29.00',
    '-28.50',
    '-28.00',
    '-27.50',
    '-27.00',
    '-26.50',
    '-26.00',
    '-25.50',
    '-25.00',
    '-24.50',
    '-24.00',
    '-23.50',
    '-23.00',
    '-22.50',
    '-22.00',
    '-21.50',
    '-21.00',
    '-20.50',
    '-20.00',
    '-19.50',
    '-19.00',
    '-18.50',
    '-18.00',
    '-17.50',
    '-17.00',
    '-16.50',
    '-16.00',
    '-15.50',
    '-15.00',
    '-14.50',
    '-14.00',
    '-13.50',
    '-13.00',
    '-12.50',
    '-12.00',
    '-11.50',
    '-11.00',
    '-10.50',
    '-10.00',
    '-9.50',
    '-9.00',
    '-8.50',
    '-8.00',
    '-7.50',
    '-7.00',
    '-6.50',
    '-6.00',
    '-5.50',
    '-5.00',
    '-4.50',
    '-4.00',
    '-3.50',
    '-3.00',
    '-2.50',
    '-2.00',
    '-1.50',
    '-1.00',
    '-0.50',
    '0.00',
    '0.50',
    '1.00',
    '1.50',
    '2.00',
    '2.50',
    '3.00',
    '3.50',
    '4.00',
    '4.50',
    '5.00',
    '5.50',
    '6.00',
    '6.50',
    '7.00',
    '7.50',
    '8.00',
    '8.50',
    '9.00',
    '9.50',
    '10.00',
    '10.50',
    '11.00',
    '11.50',
    '12.00',
    '12.50',
    '13.00',
    '13.50',
    '14.00',
    '14.50',
    '15.00',
    '15.50',
    '16.00',
    '16.50',
    '17.00',
    '17.50',
    '18.00',
    '18.50',
    '19.00',
    '19.50',
    '20.00',
    '20.50',
    '21.00',
    '21.50',
    '22.00',
    '22.50',
    '23.00',
    '23.50',
    '24.00',
    '24.50',
    '25.00',
    '25.50',
    '26.00',
    '26.50',
    '27.00',
    '27.50',
    '28.00',
    '28.50',
    '29.00',
    '29.50',
    '30.00',
    '30.50',
    '31.00',
    '31.50',
    '32.00',
    '32.50',
    '33.00',
    '33.50',
    '34.00',
    '34.50',
    '35.00',
    '35.50',
    '36.00',
    '36.50',
    '37.00',
    '37.50',
    '38.00',
    '38.50',
    '39.00',
    '39.50',
    '40.00',
    '40.50',
    '41.00',
    '41.50',
    '42.00',
    '42.50',
    '43.00',
    '43.50',
    '44.00',
    '44.50',
    '45.00',
    '45.50',
    '46.00',
    '46.50',
    '47.00',
    '47.50',
    '48.00',
    '48.50',
    '49.00',
    '49.50',
    '50.00',
    '50.50',
    '51.00',
    '51.50',
    '52.00',
    '52.50',
    '53.00',
    '53.50',
    '54.00',
    '54.50',
    '55.00',
    '55.50',
    '56.00',
    '56.50',
    '57.00',
    '57.50',
    '58.00',
    '58.50',
    '59.00',
    '59.50',
    '60.00',
    '60.50',
    '61.00',
    '61.50',
    '62.00',
    '62.50',
    '63.00',
    '63.50',
    '64.00',
    '64.50',
    '65.00',
    '65.50',
    '66.00',
    '66.50',
    '67.00',
    '67.50',
    '68.00',
    '68.50',
    '69.00',
    '69.50',
    '70.00',
    '70.50',
    '71.00',
    '71.50',
    '72.00',
    '72.50',
    '73.00',
    '73.50',
    '74.00',
    '74.50',
    '75.00',
    '75.50',
    '76.00',
    '76.50',
    '77.00',
    '77.50',
    '78.00',
    '78.50',
    '79.00',
    '79.50',
    '80.00',
    '80.50',
    '81.00',
    '81.50',
    '82.00',
    '82.50',
    '83.00',
    '83.50',
    '84.00',
    '84.50',
    '85.00',
    '85.50',
    '86.00',
    '86.50',
    '87.00',
    '87.50',
    '88.00',
    '88.50',
    '89.00',
    '89.50',
    '90.00',
    '90.50',
    '91.00',
    '91.50',
    '92.00',
    '92.50',
    '93.00',
    '93.50',
    '94.00',
    '94.50',
    '95.00',

  ];

  TextEditingController stoneWeightController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  FixedExtentScrollController scrollController = FixedExtentScrollController();
  String totalPrice = "0.00";
  String discountedPrice = "0.00";
  String rapPrice = "0.00";

  int selectedShape = 0;
  int selectedColor = 0;
  int selectedClarity = 0;
  int selectedDiscount = 0;


  getRapList() async {
    var response;
    List<NewSearchModel> sList = [];
    Utils().loading(context);
    try {
      http.Response res = await http.get(Uri.parse("https://status.cfsys.xyz/rap.json"));
      if(res.statusCode == 200){
        response = jsonDecode(res.body);
        print("APi DATA:**************");
        print(response);
        sList = NewSearchModelList(response);
        insertIntoDatabase(sList);
      }else{
        Utils().errorSnack(context, "Internal Server Error");
      }
    } catch (e) {
      print('print error: $e');
      Utils().errorSnack(context, "Internal Server Error");
    }
    Navigator.pop(context);
    return response;
  }

  insertIntoDatabase(List<NewSearchModel> sList)async{
    int count = await DbProvider().getCount();
    print("count is $count");
    if(count == 0){
      for (int i = 0; i< sList.length; i++) {
        DbProvider().insertData(sList[i]);
        print(sList[i]);
      }
    }
  }

  getAllData() async {
    List<NewSearchModel> sModel = [];
    sModel = await DbProvider().getData();
    print("length is ${sModel.length}");
    // for (var element in sModel) {
    //   print("${element.toJson()}");
    // }
  }

  calculatePrice() async {
    if(stoneWeightController.text.isNotEmpty){
      final db = await DbProvider().init();
      String query = "SELECT * FROM ${DbProvider.tableUser} WHERE Shape='${shapeList[selectedShape]}' AND Color='${colorList[selectedColor]}' AND Clarity='${clarityList[selectedClarity]}' AND Fromcts <= ${stoneWeightController.text} AND Tocts >= ${stoneWeightController.text}";
      List res = await db.rawQuery(query);

      if(res.isNotEmpty){
        rapPrice = res.first['price'];
        discountController.text = discountList[selectedDiscount];

        double discount = double.parse(rapPrice) * (double.parse(discountController.text) / 100);
        if(double.parse(discountController.text).isNegative){
          discountedPrice = ( double.parse(rapPrice) - (-discount) ).toStringAsFixed(2);
        }else{
          discountedPrice = ( double.parse(rapPrice) + discount ).toStringAsFixed(2);
        }

        if(stoneWeightController.text.isNotEmpty){
          totalPrice = (double.parse(discountedPrice) * double.parse(stoneWeightController.text)).toStringAsFixed(2);
        }else{
          totalPrice = double.parse(discountedPrice).toStringAsFixed(2);
        }
        isError = false;
        setState(() {});
      }else{
        setState(() {
          isError = true;
        });
      }
    }
  }

  setDiscount(bool isField){
    if(isField){
      setState(() {
        isScroll = false;
      });
      double checkValue = double.parse(((2 * double.parse(discountController.text.isEmpty?"0":discountController.text)).floorToDouble() / 2).toString());
      int indexDisc = discountList.indexWhere((element) => double.parse(element) == checkValue);
      scrollController.jumpToItem(indexDisc);
      setState(() {
        isScroll = true;
      });
      calculatePriceNoCheck();
    }else{
      if(isScroll) {
        discountController.text = discountList[selectedDiscount];
        discountController.selection = TextSelection.fromPosition(TextPosition(offset: discountController.text.length));
        calculatePriceNoCheck();
      }
    }
  }

  calculatePriceNoCheck(){
    if(rapPrice.isNotEmpty){
      double discount = double.parse(rapPrice) * (double.parse(discountController.text) / 100);
      if(double.parse(discountController.text).isNegative){
        discountedPrice = ( double.parse(rapPrice) - (-discount) ).toStringAsFixed(2);
      }else{
        discountedPrice = ( double.parse(rapPrice) + discount ).toStringAsFixed(2);
      }

      if(stoneWeightController.text.isNotEmpty){
        totalPrice = (double.parse(discountedPrice) * double.parse(stoneWeightController.text)).toStringAsFixed(2);
      }else{
        totalPrice = double.parse(discountedPrice).toStringAsFixed(2);
      }
      isError = false;
      setState(() {});
    }
  }

  changeDiscount(){
    if(discountController.text.isNotEmpty){
      double value = double.parse(((2*double.parse(discountController.text)).floorToDouble()/2).toString());
      if(value.isNegative){
        value = value.abs();
      }else{
        value = double.parse("-$value");
      }
      int index = discountList.indexWhere((element) => double.parse(element) == value);
      scrollController.jumpToItem(index);
      if(index != -1) {
        discountController.text = discountList[index];
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),

      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
        elevation: 1,
        backgroundColor: AppColors.white_00,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            getAllData();
          },
          child: Icon(
            Icons.calculate_outlined,
            color: AppColors.black.withOpacity(0.9),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Row(
              children: [
                Icon(
                  Icons.file_copy,
                  color: AppColors.black.withOpacity(0.2),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Report',
                  style: FontStyle.textHeaderBB
                      .copyWith(fontSize: 25)
                      .copyWith(color: AppColors.black.withOpacity(0.2)),
                ),
              ],
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    getRapList();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: MediaQuery.of(context).size.height / 25,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.black,
                    ),
                    child: Center(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.refresh,
                              color: AppColors.white_00,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Update Price',
                              style: FontStyle.appBarText.copyWith(fontSize: 13),
                            ),
                          ],
                        )),
                  ),
                ),
              ],
            )
          ],
        ),
      ),

      bottomNavigationBar: Container(
        color: Colors.black,
        height: MediaQuery.of(context).size.height / 8,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 18,
                  width: MediaQuery.of(context).size.width * 0.20,
                  color: AppColors.red_00,
                  child: InkWell(
                    splashColor: AppColors.grey_10,
                    onTap: () {
                      // _onItemTapped;
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const DiamondSearch(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.delete_rounded,
                      size: 15,
                      color: AppColors.white_00,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 18,
                  width: MediaQuery.of(context).size.width * 0.20,
                  color: AppColors.grey_10,
                  child: InkWell(
                    splashColor: AppColors.grey_10,
                    onTap: () {
                      // _onItemTapped;
                    },
                    child: const Icon(
                      Icons.share,
                      size: 15,
                      color: AppColors.white_00,
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: MediaQuery.of(context).size.height / 18,
                    color: AppColors.red_30,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.share,
                          size: 15,
                          color: AppColors.white_00,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Recut',
                          style:
                          FontStyle.textLabelWhite.copyWith(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    height: MediaQuery.of(context).size.height / 18,
                    color: AppColors.blue_00,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.file_copy,
                          size: 15,
                          color: AppColors.white_00,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Add St.',
                          style:
                          FontStyle.textLabelWhite.copyWith(fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    splashColor: AppColors.grey_10,
                    onTap: () {
                      // _onItemTapped;
                    },
                    child: Column(
                      children: [
                        const Icon(
                          Icons.calculate,
                          size: 15,
                          color: AppColors.white_00,
                        ),
                        Text(
                          'Calculator',
                          style:
                          FontStyle.textLabelWhite.copyWith(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    splashColor: AppColors.grey_10,
                    onTap: () {},
                    child: Column(
                      children: [
                        const Icon(
                          Icons.picture_as_pdf,
                          size: 15,
                          color: AppColors.white_00,
                        ),
                        Text(
                          'PDF',
                          style:
                          FontStyle.textLabelWhite.copyWith(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    splashColor: AppColors.grey_10,
                    onTap: () {},
                    child: Column(
                      children: [
                        const Icon(
                          Icons.handyman,
                          size: 15,
                          color: AppColors.white_00,
                        ),
                        Text(
                          'Service',
                          style:
                          FontStyle.textLabelWhite.copyWith(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    splashColor: AppColors.grey_10,
                    onTap: () {},
                    child: Column(
                      children: [
                        const Icon(
                          Icons.folder_open_outlined,
                          size: 15,
                          color: AppColors.white_00,
                        ),
                        Text(
                          'Folder',
                          style:
                          FontStyle.textLabelWhite.copyWith(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    splashColor: AppColors.grey_10,
                    onTap: () {},
                    child: Column(
                      children: [
                        const Icon(
                          Icons.settings,
                          size: 15,
                          color: AppColors.white_00,
                        ),
                        Text(
                          'Setting',
                          style:
                          FontStyle.textLabelWhite.copyWith(fontSize: 15),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: AppColors.black.withOpacity(0.12),
          child: SingleChildScrollView(
            child: Column(
              children: [

                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                    child: Column(
                      children: [

                        // Stone Weight Field
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.black.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            controller: stoneWeightController,
                            style: FontStyle.textInput,
                            cursorColor: AppColors.red_00,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}'))
                            ],
                            decoration: Utils().inputDecoration("Stone Weight",true).copyWith(
                              hintStyle: FontStyle.textHint.copyWith(fontSize: 15),
                              prefixIcon: Icon(
                                Icons.email_rounded,
                                color: AppColors.black.withOpacity(0.4),
                              ),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[

                                    const Text(
                                      'Ct.',
                                      style: FontStyle.textHeaderBB,
                                    ),

                                    const SizedBox(
                                      width: 10,
                                    ),

                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          stoneWeightController.clear();
                                        });
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.grey_10
                                        ),
                                        padding: const EdgeInsets.all(4),
                                        child: const Icon(
                                          Icons.close,
                                          size: 10,
                                          color: AppColors.white_00,
                                        ),
                                      ),
                                    )

                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10,),

                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.grey_09),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                    const SizedBox(
                                      height: 5,
                                    ),

                                    const Text('Shape', style: FontStyle.greyTextSmall),

                                    const SizedBox(
                                      height: 5,
                                    ),

                                    SizedBox(
                                      height: MediaQuery.of(context).size.height / 10,
                                      child: CupertinoPicker(
                                        itemExtent: 30,
                                        children: shapeList.map((item) => Center(
                                            child: Text(
                                              item.toString(),
                                              style: FontStyle.textBlack,
                                            ),
                                          ),
                                        ).toList(),
                                        onSelectedItemChanged: (index) {
                                          setState(() {
                                            selectedShape = index;
                                          });
                                          calculatePrice();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                width: 0.2,
                                color: AppColors.grey_00,
                              ),

                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                    const SizedBox(height: 5,),

                                    const Text('Color', style: FontStyle.greyTextSmall),

                                    const SizedBox(height: 5,),

                                    SizedBox(
                                      height: MediaQuery.of(context).size.height / 10,
                                      child: CupertinoPicker(
                                        itemExtent: 30,
                                        children: colorList.map((item) => Center(
                                          child: Text(item.toString(),
                                              style:
                                              FontStyle.textBlack),
                                        )).toList(),
                                        onSelectedItemChanged: (index) {
                                          setState(() {
                                            selectedColor = index;
                                          });
                                          calculatePrice();
                                        },
                                      ),
                                    ),

                                  ],
                                ),
                              ),

                              Container(
                                width: 0.2,
                                color: AppColors.grey_00,
                              ),

                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                    const SizedBox(height: 5,),

                                    const Text('Clarity', style: FontStyle.greyTextSmall),

                                    const SizedBox(height: 5,),

                                    SizedBox(
                                      height: MediaQuery.of(context).size.height / 10,
                                      child: CupertinoPicker(
                                        itemExtent: 30,
                                        children: clarityList.map((item) => Center(
                                          child: Text(item.toString(),
                                              style:
                                              FontStyle.textBlack),
                                        )).toList(),
                                        onSelectedItemChanged: (index) {
                                          setState(() {
                                            selectedClarity = index;
                                          });
                                          calculatePrice();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Container(
                                width: 0.2,
                                color: AppColors.grey_00,
                              ),

                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [

                                    const SizedBox(height: 5,),

                                    const Text('Discount', style: FontStyle.greyTextSmall,),

                                    const SizedBox(height: 5,),

                                    SizedBox(
                                      height: MediaQuery.of(context).size.height / 10,
                                      child: CupertinoPicker(
                                        scrollController: scrollController,
                                        itemExtent: 30,
                                        children: discountList.map((percentage) => Center(
                                            child: Text(
                                              "$percentage %",
                                              style: FontStyle.textBold
                                                  .copyWith(
                                                color: AppColors.red_50,
                                                fontSize: 15,
                                              ),
                                            ),
                                          ),
                                        ).toList(),
                                        onSelectedItemChanged: (index) {
                                          selectedDiscount = index;
                                          setDiscount(false);
                                        },
                                      ),
                                    ),

                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),

                        const SizedBox(height: 10,),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            const Padding(
                              padding: EdgeInsets.only(left: 4.0),
                              child: Text(
                                'RAP PRICE / CT.',
                                style: FontStyle.textLabelRed,
                              ),
                            ),

                            Visibility(
                              visible: isError,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColors.red_40,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 4.0,left: 5),
                                  child: Text(
                                    'No Value Found',
                                    style: FontStyle.textLabelWhite.copyWith(fontSize: 14),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),

                        const SizedBox(height: 5,),

                        Row(
                          children: [

                            Expanded(
                              child: Container(
                                height: 45,
                                decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.grey_10,width: 2),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.attach_money_outlined,
                                        color: AppColors.grey_10,
                                      ),

                                      Expanded(child: Text(rapPrice, style: FontStyle.textInput,overflow: TextOverflow.ellipsis,)),

                                      Align(
                                        alignment: AlignmentDirectional.centerEnd,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 5),
                                          child: IntrinsicWidth(
                                            child: Row(
                                              children: [
                                                Text(
                                                  '/Ct.',
                                                  style: FontStyle.textBlack.copyWith(fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(
                              width: 10,
                            ),

                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.grey_09,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Row(
                                  children: [

                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                      child: Text('DISC.',style: FontStyle.textLabelRed.copyWith(fontSize: 14),),
                                    ),

                                    Expanded(
                                      child: Container(
                                        height: 45,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: AppColors.grey_10,width: 2),
                                            borderRadius: BorderRadius.circular(10),
                                          color: AppColors.white_00
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                          child: Row(
                                            children: [

                                              InkWell(
                                                onTap: () {
                                                  changeDiscount();
                                                },
                                                child: const Padding(
                                                  padding: EdgeInsets.only(right: 5.0),
                                                  child: Icon(
                                                    Icons.remove_circle,
                                                    color: AppColors.red_50,
                                                  ),
                                                ),
                                              ),

                                              Expanded(
                                                child: TextFormField(
                                                  controller: discountController,
                                                  keyboardType: TextInputType.number,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    border: InputBorder.none,
                                                    hintText: "0.00",
                                                    hintStyle: FontStyle.textBlack.copyWith(fontFamily: "Regular")
                                                  ),
                                                  onChanged: (value) {
                                                    setDiscount(true);
                                                  },
                                                )
                                              ),

                                              const Icon(
                                                Icons.percent,
                                                size: 20,
                                                color: AppColors.red_50,
                                              )

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                                    
                                  ],
                                ),
                              ),
                            ),


                          ],
                        ),

                        const SizedBox(height: 15,),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [

                              Text(
                                'PRICE / CT.',
                                style: FontStyle.textLabelGrey,
                              ),

                              Text(
                                'TOTAL PRICE',
                                style: FontStyle.textLabelGrey,
                              ),

                            ],
                          ),
                        ),

                        const SizedBox(height: 5,),

                        Row(
                          children: [

                            Expanded(
                              child: Container(
                                height: 45,
                                decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.grey_10,width: 2),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.attach_money_outlined,
                                        color: AppColors.grey_10,
                                      ),

                                      Expanded(child: Text(discountedPrice, style: FontStyle.textInput,overflow: TextOverflow.ellipsis,)),

                                      Align(
                                        alignment: AlignmentDirectional.centerEnd,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 5),
                                          child: IntrinsicWidth(
                                            child: Row(
                                              children: [
                                                Text(
                                                  '/Ct.',
                                                  style: FontStyle.textBlack.copyWith(fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(width: 10,),

                            Expanded(
                              child: Container(
                                height: 45,
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.grey_10,width: 2),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.attach_money_outlined,
                                        color: AppColors.grey_10,
                                      ),

                                      Expanded(child: Text(totalPrice, style: FontStyle.textInput,overflow: TextOverflow.ellipsis,)),

                                      Align(
                                        alignment: AlignmentDirectional.centerEnd,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 5),
                                          child: IntrinsicWidth(
                                            child: Row(
                                              children: [
                                                Text(
                                                  'TTL',
                                                  style: FontStyle.textBlack.copyWith(fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
