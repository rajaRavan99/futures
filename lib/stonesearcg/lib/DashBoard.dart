// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:stonesearch/DiamondSearch.dart';
// import 'package:stonesearch/Liabrary/AppColors.dart';
// import 'package:stonesearch/Liabrary/TextStyle.dart';
// import 'package:stonesearch/Models/SearchModel.dart';
// import 'Liabrary/DbHelper.dart';
// import 'Liabrary/Utils.dart';
//
// class DashBoard extends StatefulWidget {
//   const DashBoard({super.key});
//
//   @override
//   State<DashBoard> createState() => _DashBoardState();
// }
//
// class _DashBoardState extends State<DashBoard> {
//   final fieldText = TextEditingController();
//   List<SearchModel> data = [];
//   SearchModel aData = SearchModel();
//   String resulttext = "0";
//   var per = 0;
//
//   void clearText() {
//     fieldText.clear();
//   }
//
//   int index = 0;
//   int selectedindex = 0;
//   int selectedShape = 0;
//   int selectedColor = 0;
//   int selectedClarity = 0;
//   int selectedFromcts = 0;
//   int selectedTocts = 0;
//
//   void _onItemTapped(int index) {
//     setState(() {
//       selectedindex = index;
//     });
//   }
//
//   List shapeList = [
//     'RD',
//     'FNY',
//   ];
//
//   List colorList = [
//     'D',
//     'E',
//     'L',
//     'M',
//     'K',
//     'J',
//     'H',
//     'G',
//     'I',
//     'N',
//   ];
//
//   List clarityList = [
//     'IF',
//     'VVS1',
//     'VVS2',
//     'VS1',
//     'VS2',
//     'SI1',
//     'SI2',
//     'SI3',
//     'I1',
//     'I2',
//     'I3',
//   ];
//
//   List fromCTSList = [
//     '0.01%',
//     '0.04%',
//     '0.08%',
//     '0.15%',
//     '0.18%',
//     '0.23%',
//     '0.3%',
//     '0.5%',
//     '0.7%',
//     '1%',
//     '1.5%',
//     '2.0%',
//     '3.0%',
//     '4.0%',
//     '5.0%',
//     '10.0%',
//     '0.18%',
//     '0.23%',
//   ];
//
//   List toCTSList = [
//     '0.03%',
//     '0.07%',
//     '0.14%',
//     '0.17%',
//     '0.22%',
//     '0.29%',
//     '0.39%',
//     '0.49%',
//     '0.69%',
//     '0.89%',
//     '0.99%',
//     '1.49%',
//     '1.99%',
//     '2.99%',
//     '3.99%',
//     '4.99%',
//     '5.99%',
//     '10.99%',
//   ];
//
//   List<Map<String, dynamic>> arrUsers = [];
//   late Future listOfData;
//   static const tableUser = "Search";
//
//   @override
//   void initState() {
//     getUserListFromDB();
//     getPrice();
//     toctsController.text = '${toCTSList[selectedTocts]}';
//     super.initState();
//     setState(() {});
//   }
//
//   bool value = false;
//
//   getUserListFromDB() async {
//     arrUsers = await DBHelper.getData();
//     print(arrUsers.length);
//     setState(() {});
//   }
//
//   getData() {
//     for (int i = 0; i < arrUsers.length; i++) {
//       if (arrUsers[i]['Shape'] == selectedShape) {
//         if (arrUsers[i]['Clarity'] == selectedClarity) {
//           if (arrUsers[i]['Color'] == selectedColor) {
//             if (arrUsers[i]['Fromcts'] == selectedFromcts) {
//               if (arrUsers[i]['Tocts'] == selectedTocts) {
//                 totalController.text = arrUsers[i]['price'];
//                 setState(() {});
//                 print(totalController);
//               }
//             }
//           }
//         }
//       }
//     }
//     print('i');
//     print('asdasd: ${arrUsers.length}');
//   }
//
//   Future<List<Map<String, dynamic>>> getPrice() async {
//     final db = await DBHelper.database();
//     List<Map<String, dynamic>> list = await db.rawQuery(
//         'SELECT * FROM $tableUser WHERE Shape = ${shapeList[selectedShape]} AND Clarity = ${clarityList[selectedClarity]} AND Color = ${colorList[selectedColor]} AND price BETWEEN ${fromCTSList[selectedFromcts]} AND ${toCTSList[selectedTocts]}');
//     print(list);
//     return list;
//   }
//
//   void countTotal() {
//     setState(() {
//       var totalprice = int.parse(rateController.text) *
//           int.parse(rapPriceController.text) /
//           100;
//       print('sadasdasd : ${totalprice}');
//       resulttext = totalprice.toString();
//     });
//   }
//
//   TextEditingController toctsController = TextEditingController(text: '');
//   TextEditingController stoneWController = TextEditingController(text: '');
//   TextEditingController rapPriceController = TextEditingController(text: '');
//   TextEditingController rateController = TextEditingController(text: '');
//   TextEditingController totalController = TextEditingController(text: '');
//
//   snackBar(String? message) {
//     return ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message!),
//         duration: const Duration(seconds: 2),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: const Drawer(),
//       bottomNavigationBar: Container(
//         color: Colors.black,
//         height: MediaQuery.of(context).size.height / 8,
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   height: MediaQuery.of(context).size.height / 18,
//                   width: MediaQuery.of(context).size.width * 0.20,
//                   color: AppColors.red_00,
//                   child: InkWell(
//                     splashColor: AppColors.grey_10,
//                     onTap: () {
//                       _onItemTapped;
//                       Navigator.of(context).pushReplacement(
//                         MaterialPageRoute(
//                           builder: (context) => const DiamondSearch(),
//                         ),
//                       );
//                     },
//                     child: const Icon(
//                       Icons.delete_rounded,
//                       size: 15,
//                       color: AppColors.white_00,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   height: MediaQuery.of(context).size.height / 18,
//                   width: MediaQuery.of(context).size.width * 0.20,
//                   color: AppColors.grey_10,
//                   child: InkWell(
//                     splashColor: AppColors.grey_10,
//                     onTap: () {
//                       _onItemTapped;
//                     },
//                     child: const Icon(
//                       Icons.share,
//                       size: 15,
//                       color: AppColors.white_00,
//                     ),
//                   ),
//                 ),
//                 Flexible(
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 15),
//                     height: MediaQuery.of(context).size.height / 18,
//                     color: AppColors.red_30,
//                     child: Row(
//                       children: [
//                         const Icon(
//                           Icons.share,
//                           size: 15,
//                           color: AppColors.white_00,
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           'Recut',
//                           style:
//                               FontStyle.textLabelWhite.copyWith(fontSize: 15),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Flexible(
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 15),
//                     height: MediaQuery.of(context).size.height / 18,
//                     color: AppColors.blue_00,
//                     child: Row(
//                       children: [
//                         const Icon(
//                           Icons.file_copy,
//                           size: 15,
//                           color: AppColors.white_00,
//                         ),
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Text(
//                           'Add St.',
//                           style:
//                               FontStyle.textLabelWhite.copyWith(fontSize: 15),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   InkWell(
//                     splashColor: AppColors.grey_10,
//                     onTap: () {
//                       _onItemTapped;
//                     },
//                     child: Column(
//                       children: [
//                         const Icon(
//                           Icons.calculate,
//                           size: 15,
//                           color: AppColors.white_00,
//                         ),
//                         Text(
//                           'Calculator',
//                           style:
//                               FontStyle.textLabelWhite.copyWith(fontSize: 15),
//                         )
//                       ],
//                     ),
//                   ),
//                   InkWell(
//                     splashColor: AppColors.grey_10,
//                     onTap: () {},
//                     child: Column(
//                       children: [
//                         const Icon(
//                           Icons.picture_as_pdf,
//                           size: 15,
//                           color: AppColors.white_00,
//                         ),
//                         Text(
//                           'PDF',
//                           style:
//                               FontStyle.textLabelWhite.copyWith(fontSize: 15),
//                         )
//                       ],
//                     ),
//                   ),
//                   InkWell(
//                     splashColor: AppColors.grey_10,
//                     onTap: () {},
//                     child: Column(
//                       children: [
//                         const Icon(
//                           Icons.handyman,
//                           size: 15,
//                           color: AppColors.white_00,
//                         ),
//                         Text(
//                           'Service',
//                           style:
//                               FontStyle.textLabelWhite.copyWith(fontSize: 15),
//                         )
//                       ],
//                     ),
//                   ),
//                   InkWell(
//                     splashColor: AppColors.grey_10,
//                     onTap: () {},
//                     child: Column(
//                       children: [
//                         const Icon(
//                           Icons.folder_open_outlined,
//                           size: 15,
//                           color: AppColors.white_00,
//                         ),
//                         Text(
//                           'Folder',
//                           style:
//                               FontStyle.textLabelWhite.copyWith(fontSize: 15),
//                         )
//                       ],
//                     ),
//                   ),
//                   InkWell(
//                     splashColor: AppColors.grey_10,
//                     onTap: () {},
//                     child: Column(
//                       children: [
//                         const Icon(
//                           Icons.settings,
//                           size: 15,
//                           color: AppColors.white_00,
//                         ),
//                         Text(
//                           'Setting',
//                           style:
//                               FontStyle.textLabelWhite.copyWith(fontSize: 15),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       appBar: AppBar(
//         iconTheme: const IconThemeData(color: AppColors.primaryColor),
//         elevation: 1,
//         backgroundColor: AppColors.white_00,
//         centerTitle: true,
//         leading: Icon(
//           Icons.calculate_outlined,
//           color: AppColors.black.withOpacity(0.9),
//         ),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Row(
//               children: [
//                 Icon(
//                   Icons.file_copy,
//                   color: AppColors.black.withOpacity(0.2),
//                 ),
//                 const SizedBox(
//                   width: 5,
//                 ),
//                 Text(
//                   'Report',
//                   style: FontStyle.textHeaderBB
//                       .copyWith(fontSize: 25)
//                       .copyWith(color: AppColors.black.withOpacity(0.2)),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 InkWell(
//                   onTap: () {
//                     // DBHelper.(aData);
//                   },
//                   child: Container(
//                     // margin: const EdgeInsets.all(5),
//                     padding: const EdgeInsets.symmetric(horizontal: 15),
//                     height: MediaQuery.of(context).size.height / 25,
//
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: AppColors.black,
//                     ),
//                     child: Center(
//                         child: Row(
//                       children: [
//                         const Icon(
//                           Icons.refresh,
//                           color: AppColors.white_00,
//                           size: 18,
//                         ),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         Text(
//                           'Update Price',
//                           style: FontStyle.appBarText.copyWith(fontSize: 13),
//                         ),
//                       ],
//                     )),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//
//       body: Padding(
//         padding: const EdgeInsets.all(2.0),
//         child: Container(
//           height: MediaQuery.of(context).size.height,
//           color: AppColors.black.withOpacity(0.12),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Card(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                   elevation: 2,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 8.0, vertical: 10),
//                     child: Column(
//                       children: [
//                         // stone Weight Field
//
//                         Container(
//                           decoration: BoxDecoration(
//                             color: AppColors.black.withOpacity(0.1),
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           child: TextFormField(
//                             controller: stoneWController,
//                             style: FontStyle.textInput,
//                             cursorColor: AppColors.red_00,
//                             decoration: Utils()
//                                 .inputDecoration(fromCTSList[selectedFromcts])
//                                 .copyWith(
//                                   hintStyle:
//                                       FontStyle.textHint.copyWith(fontSize: 15),
//                                   prefixIcon: Icon(
//                                     Icons.email_rounded,
//                                     color: AppColors.black.withOpacity(0.4),
//                                   ),
//                                   suffixIcon: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 15),
//                                     child: Row(
//                                       mainAxisSize: MainAxisSize.min,
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       children: <Widget>[
//                                         Text(
//                                           'Ct.',
//                                           style: FontStyle.textBlack
//                                               .copyWith(fontSize: 18),
//                                         ),
//                                         const SizedBox(
//                                           width: 10,
//                                         ),
//                                         InkWell(
//                                           onTap: () {
//                                             clearText();
//                                           },
//                                           child: const Icon(
//                                             Icons.close,
//                                             size: 20,
//                                             color: AppColors.black,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                           ),
//                         ),
//
//                         const SizedBox(
//                           height: 10,
//                         ),
//
//                         Container(
//                           height: MediaQuery.of(context).size.height * 0.20,
//                           decoration: BoxDecoration(
//                               color: AppColors.white_90,
//                               borderRadius: BorderRadius.circular(10)),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Flexible(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     const SizedBox(
//                                       height: 5,
//                                     ),
//                                     const Text('Shape',
//                                         style: FontStyle.textBlack),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height /
//                                               10,
//                                       // width: MediaQuery.of(context).size.width,
//                                       child: CupertinoPicker(
//                                         itemExtent: 30,
//                                         children: shapeList
//                                             .map(
//                                               (item) => Center(
//                                                 child: Text(
//                                                   item.toString(),
//                                                   style: FontStyle.textBlack,
//                                                 ),
//                                               ),
//                                             )
//                                             .toList(),
//                                         onSelectedItemChanged: (index) {
//                                           setState(() {
//                                             selectedShape = index;
//                                             getData();
//                                           });
//                                           final item = shapeList[index];
//                                           print('Seleted item : $item');
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 width: 0.2,
//                                 color: AppColors.grey_00,
//                               ),
//                               Flexible(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     const SizedBox(
//                                       height: 5,
//                                     ),
//                                     const Text('Color',
//                                         style: FontStyle.textBlack),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height /
//                                               10,
//                                       child: CupertinoPicker(
//                                         itemExtent: 30,
//                                         children: colorList
//                                             .map((item) => Center(
//                                                   child: Text(item.toString(),
//                                                       style:
//                                                           FontStyle.textBlack),
//                                                 ))
//                                             .toList(),
//                                         onSelectedItemChanged: (index) {
//                                           setState(() {
//                                             selectedColor = index;
//                                             getData();
//                                           });
//                                           final item = colorList[index];
//                                           print('Seleted item : $item');
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 width: 0.2,
//                                 color: AppColors.grey_00,
//                               ),
//                               Flexible(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     const SizedBox(
//                                       height: 5,
//                                     ),
//                                     const Text('Clarity',
//                                         style: FontStyle.textBlack),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height /
//                                               10,
//                                       child: CupertinoPicker(
//                                         itemExtent: 30,
//                                         children: clarityList
//                                             .map((item) => Center(
//                                                   child: Text(item.toString(),
//                                                       style:
//                                                           FontStyle.textBlack),
//                                                 ))
//                                             .toList(),
//                                         onSelectedItemChanged: (index) {
//                                           setState(
//                                             () {
//                                               selectedClarity = index;
//                                               getData();
//                                             },
//                                           );
//                                           final item = clarityList[index];
//                                           print('Seleted item : $item');
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 width: 0.2,
//                                 color: AppColors.grey_00,
//                               ),
//                               Flexible(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     const SizedBox(
//                                       height: 5,
//                                     ),
//                                     const Text(
//                                       'Fromcts',
//                                       style: FontStyle.textBlack,
//                                     ),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height /
//                                               10,
//                                       child: CupertinoPicker(
//                                         itemExtent: 30,
//                                         children: fromCTSList
//                                             .map(
//                                               (percentage) => Center(
//                                                 child: Text(
//                                                   percentage.toString(),
//                                                   style: FontStyle.textBold
//                                                       .copyWith(
//                                                     color: AppColors.red_70,
//                                                     fontSize: 15,
//                                                   ),
//                                                 ),
//                                               ),
//                                             )
//                                             .toList(),
//                                         onSelectedItemChanged: (index) {
//                                           setState(() {
//                                             selectedFromcts = index;
//                                             getData();
//                                           });
//                                           final per = fromCTSList[index];
//                                           print('Selected item : $per');
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 width: 0.2,
//                                 color: AppColors.grey_00,
//                               ),
//                               Flexible(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     const SizedBox(
//                                       height: 5,
//                                     ),
//                                     const Text(
//                                       'Tocts',
//                                       style: FontStyle.textBlack,
//                                     ),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     SizedBox(
//                                       height:
//                                           MediaQuery.of(context).size.height /
//                                               10,
//                                       child: CupertinoPicker(
//                                         itemExtent: 30,
//                                         looping: false,
//                                         children: toCTSList
//                                             .map(
//                                               (value) => Center(
//                                                 child: Text(value.toString(),
//                                                     style: FontStyle.textBlack),
//                                               ),
//                                             )
//                                             .toList(),
//                                         onSelectedItemChanged: (index) {
//                                           setState(() {
//                                             selectedTocts = index;
//                                             // getData();
//                                             toctsController.text =
//                                                 toCTSList[index];
//                                             print(
//                                                 'Selected item : $toctsController.text');
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//
//                         const SizedBox(
//                           height: 10,
//                         ),
//
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Text(
//                               'RAP PRICE / CT',
//                               style: FontStyle.textBold.copyWith(
//                                 color: AppColors.red_70,
//                               ),
//                             ),
//                           ],
//                         ),
//
//                         const SizedBox(
//                           height: 10,
//                         ),
//
//                         Row(
//                           children: [
//                             SizedBox(
//                               width: MediaQuery.of(context).size.width * 0.45,
//                               child: TextFormField(
//                                 controller: rapPriceController,
//                                 style: FontStyle.textInput,
//                                 cursorColor: AppColors.red_00,
//                                 decoration: Utils()
//                                     .inputDecoration('0')
//                                     .copyWith(
//                                       hintStyle: FontStyle.textBlack
//                                           .copyWith(fontSize: 15),
//                                       prefixIcon: Icon(
//                                         Icons.monetization_on,
//                                         color: AppColors.black.withOpacity(0.4),
//                                       ),
//                                       suffixIcon: Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 15),
//                                         child: Row(
//                                           mainAxisSize: MainAxisSize.min,
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.end,
//                                           children: [
//                                             Text(
//                                               '/Ct.',
//                                               style: FontStyle.textBlack
//                                                   .copyWith(fontSize: 12),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                 // onChanged: (value) =>
//                                 //     resulttext = (double.parse(value) / 100) as int,
//                               ),
//                             ),
//                             const SizedBox(
//                               width: 10,
//                             ),
//                             Container(
//                               width: MediaQuery.of(context).size.width * 0.43,
//                               decoration: BoxDecoration(
//                                   color: AppColors.black.withOpacity(0.0),
//                                   borderRadius: BorderRadius.circular(10)),
//                               child: TextFormField(
//                                 controller: toctsController,
//                                 style: FontStyle.textInput,
//                                 cursorColor: AppColors.red_00,
//                                 decoration:
//                                     Utils().inputDecoration('0').copyWith(
//                                           hintStyle: FontStyle.textBlack
//                                               .copyWith(fontSize: 15),
//                                           prefixIcon: const Icon(
//                                             Icons.remove_circle,
//                                             color: AppColors.red_70,
//                                           ),
//                                           suffixIcon: const Icon(
//                                             Icons.percent,
//                                             color: AppColors.red_70,
//                                           ),
//                                         ),
//                               ),
//
//                               // TextFormField(
//                               //   controller: toctsController,
//                               //   style: FontStyle.textInput,
//                               //   cursorColor: AppColors.red_00,
//                               //   decoration: Utils()
//                               //       .inputDecoration('')
//                               //       .copyWith(
//                               //         hintStyle: FontStyle.textBold
//                               //             .copyWith(fontSize: 15),
//                               //         prefixIcon: InkWell(
//                               //           onTap: () {},
//                               //           child: const Icon(
//                               //             Icons.remove_circle,
//                               //             color: AppColors.red_70,
//                               //           ),
//                               //         ),
//                               //         suffixIcon: Padding(
//                               //           padding:
//                               //               const EdgeInsets.only(
//                               //                   right: 10),
//                               //           child: Row(
//                               //             mainAxisSize: MainAxisSize.min,
//                               //             mainAxisAlignment:
//                               //                 MainAxisAlignment.end,
//                               //             children: [
//                               //               Text(
//                               //                 '%',
//                               //                 style: FontStyle
//                               //                     .textHeaderBB
//                               //                     .copyWith(
//                               //                         fontSize: 15,
//                               //                         color: AppColors
//                               //                             .red_70),
//                               //               ),
//                               //             ],
//                               //           ),
//                               //         ),
//                               //       ),
//                               // ),
//
//                               // Row(
//                               //   children: [
//                               //     Padding(
//                               //       padding: const EdgeInsets.all(5.0),
//                               //       child: Text(
//                               //         'DISC.',
//                               //         style: FontStyle.textBold.copyWith(
//                               //           color: AppColors.red_70,
//                               //         ),
//                               //       ),
//                               //     ),
//                               //     Flexible(
//                               //       child: Container(
//                               //         height: 50,
//                               //         decoration: BoxDecoration(
//                               //             border: Border.all(
//                               //                 color: AppColors.red_70,
//                               //                 width: 1),
//                               //             color: AppColors.white_00,
//                               //             borderRadius:
//                               //                 BorderRadius.circular(10)),
//                               //         child: Padding(
//                               //           padding: const EdgeInsets.all(2.0),
//                               //           child: Row(
//                               //             mainAxisAlignment:
//                               //                 MainAxisAlignment.spaceBetween,
//                               //             children: [
//                               //               const Icon(
//                               //                 Icons.remove_circle,
//                               //                 color: AppColors.red_70,
//                               //                 size: 20,
//                               //               ),
//                               //               Text(
//                               //                 fromCTS[selectedFromcts],
//                               //                 style: FontStyle.textHeaderBB
//                               //                     .copyWith(
//                               //                         fontSize: 15,
//                               //                         color: AppColors.red_70),
//                               //               ),
//                               //               const Icon(
//                               //                 Icons.percent,
//                               //                 color: AppColors.red_70,
//                               //                 size: 20,
//                               //               ),
//                               //             ],
//                               //           ),
//                               //         ),
//                               //
//                               //
//                               //       ),
//                               //     ),
//                               //   ],
//                               // ),
//                             ),
//                           ],
//                         ),
//
//                         const SizedBox(
//                           height: 10,
//                         ),
//
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               'PRICE / CT.',
//                               style: FontStyle.textBold.copyWith(
//                                 color: AppColors.grey_10,
//                               ),
//                             ),
//                             Text(
//                               'TOTAL PRICE',
//                               style: FontStyle.textBold.copyWith(
//                                 color: AppColors.grey_10,
//                               ),
//                             ),
//                           ],
//                         ),
//
//                         const SizedBox(
//                           height: 2,
//                         ),
//
//                         Row(
//                           children: [
//                             SizedBox(
//                               width: MediaQuery.of(context).size.width * 0.45,
//                               child: TextFormField(
//                                 controller: rateController,
//                                 style: FontStyle.textInput,
//                                 cursorColor: AppColors.red_00,
//                                 decoration: Utils()
//                                     .inputDecoration('0')
//                                     .copyWith(
//                                       hintStyle: FontStyle.textBlack
//                                           .copyWith(fontSize: 15),
//                                       labelStyle: FontStyle.textBlack
//                                           .copyWith(fontSize: 15),
//                                       prefixIcon: InkWell(
//                                         onTap: () {},
//                                         child: Icon(
//                                           Icons.monetization_on,
//                                           color:
//                                               AppColors.black.withOpacity(0.4),
//                                         ),
//                                       ),
//                                       suffixIcon: Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 15),
//                                         child: Row(
//                                           mainAxisSize: MainAxisSize.min,
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.end,
//                                           children: [
//                                             Text(
//                                               '/Ct.',
//                                               style: FontStyle.textBlack
//                                                   .copyWith(fontSize: 12),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                               ),
//                             ),
//                             const SizedBox(
//                               width: 10,
//                             ),
//                             SizedBox(
//                               width: MediaQuery.of(context).size.width * 0.43,
//                               child: TextFormField(
//                                 controller: totalController,
//                                 style: FontStyle.textInput,
//                                 cursorColor: AppColors.red_00,
//                                 onChanged: (value) {},
//                                 decoration: Utils()
//                                     .inputDecoration('${resulttext}')
//                                     .copyWith(
//                                       hintStyle: FontStyle.textBlack
//                                           .copyWith(fontSize: 15),
//                                       labelStyle: FontStyle.textBlack
//                                           .copyWith(fontSize: 15),
//                                       prefixIcon: InkWell(
//                                         onTap: () {},
//                                         child: Icon(
//                                           Icons.monetization_on,
//                                           color:
//                                               AppColors.black.withOpacity(0.4),
//                                         ),
//                                       ),
//                                       suffixIcon: Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 15),
//                                         child: Row(
//                                           mainAxisSize: MainAxisSize.min,
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.end,
//                                           children: [
//                                             Text(
//                                               'TTL',
//                                               style: FontStyle.textBlack
//                                                   .copyWith(fontSize: 12),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Text(
//                       'tocts : ${toCTSList[selectedTocts]}',
//                       style: FontStyle.textBlack.copyWith(fontSize: 15),
//                     ),
//                     Text(
//                       'fromCTS : ${fromCTSList[selectedFromcts]}',
//                       style: FontStyle.textBlack.copyWith(fontSize: 15),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: [
//                     Text(
//                       'color : ${colorList[selectedColor]}',
//                       style: FontStyle.textBlack.copyWith(fontSize: 15),
//                     ),
//                     Text(
//                       'clarity : ${clarityList[selectedClarity]}',
//                       style: FontStyle.textBlack.copyWith(fontSize: 15),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 Text(
//                   'shape : ${shapeList[selectedShape]}',
//                   style: FontStyle.textBlack.copyWith(fontSize: 15),
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 Text(
//                   '${resulttext}',
//                   style: FontStyle.textBlack.copyWith(fontSize: 15),
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 InkWell(
//                   onTap: () {
//                     countTotal();
//                     getPrice();
//                   },
//                   child: Container(
//                     height: 50,
//                     width: 100,
//                     color: AppColors.blue_40,
//                     child: const Center(
//                       child: Text(
//                         'Get Price',
//                         style: FontStyle.textLabelWhite,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
