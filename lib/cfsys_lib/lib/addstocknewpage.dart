import 'package:cfsys/colors.dart';
import 'package:cfsys/stylepage/textstyles.dart';
import 'package:cfsys/userform.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'multiform.dart';

class addstocknew extends StatefulWidget {
  const addstocknew({super.key});

  @override
  State<addstocknew> createState() => _addstockState();
}

class _addstockState extends State<addstocknew> {
  var itemlist = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];

  List<UserForm> users = [];

  TextEditingController invoicedate = TextEditingController(text: "");
  TextEditingController chalan = TextEditingController(text: "");
  TextEditingController plain = TextEditingController(text: "");
  TextEditingController details = TextEditingController(text: "");
  TextEditingController oty = TextEditingController(text: "");
  TextEditingController design = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final form = GlobalKey<FormState>();
    var selecteddata;
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black38,
          title: Text(
            "Add Stock",
            style: GoogleFonts.lato(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          leading: IconButton(
            splashRadius: 20,
            iconSize: 18,
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () {},
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: form,
              child: Column(
                children: [
                  Container(
                    height: 200,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: 20, bottom: 5, left: 25, right: 15),
                                padding: const EdgeInsets.all(4),
                                // height: 40,
                                width: double.infinity,
                                child: TextFormField(
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  controller: invoicedate,
                                  decoration: const InputDecoration(
                                    labelText: "Invoice No",
                                    labelStyle: TextStyle(
                                      color: Colors.black38,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // date selection form :-
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(
                                    top: 20, bottom: 5, left: 0, right: 15),
                                // padding: EdgeInsets.all(4),
                                // height: 40,
                                width: double.infinity,
                                // color: Colors.black,
                                child: DateTimePicker(
                                  type: DateTimePickerType.date,
                                  dateMask: 'd MMM, yyyy',
                                  // initialValue: DateTime.now().toString(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                  // icon: Icon(
                                  //   Icons.event,
                                  //   color: Colors.black54,
                                  // ),
                                  dateLabelText: 'Date',
                                  // timeLabelText: "Hour",
                                  selectableDayPredicate: (date) {
                                    // Disable weekend days to select from the calendar
                                    if (date.weekday == 6 ||
                                        date.weekday == 7) {
                                      return false;
                                    }

                                    return true;
                                  },
                                  onChanged: (val) => print(val),
                                  validator: (val) {
                                    print(val);
                                    return null;
                                  },
                                  onSaved: (val) => print(val),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: 10, bottom: 5, left: 25, right: 15),
                          padding: const EdgeInsets.all(4),
                          height: 40,
                          width: double.infinity,
                          child: DropdownButton(
                            value: selecteddata,
                            hint: const Text(
                              "Select Party",
                              style: TextStyle(
                                  color: Colors.black38, fontSize: 15),
                            ),
                            underline: Container(),
                            isExpanded: true,
                            iconEnabledColor: Colors.black,
                            dropdownColor: Colors.white,
                            focusColor: Colors.black,
                            items: itemlist.map((String items) {
                              return DropdownMenuItem(
                                  value: items, child: Text(items));
                            }).toList(),
                            onChanged: (
                              selecteddata,
                            ) {
                              // setState(() {
                              //   initialValue = Text;
                              // });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 2,
                          width: context.width,
                          margin: const EdgeInsets.only(
                              top: 10, left: 15, right: 2, bottom: 25),
                          color: AppColors.grey_20,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.grey_20,
                        ),
                        height: 35,
                        width: 120,
                        margin: const EdgeInsets.only(
                            left: 5, right: 15, bottom: 20),
                        child: Center(
                          child: Text(
                            "+ Add New",
                            style: CustomTextStyle.style333,
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceArou/nd,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  bottom: 20, left: 30, right: 5, top: 0),
                              child: ClipOval(
                                child: Image.network(
                                  'https://th.bing.com/th/id/OIP.qWehang2VHKUsrv0wICFBwHaHH?pid=ImgDet&rs=1',
                                  height: 40,
                                  width: 40,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColors.grey_20,
                              ),
                              height: 35,
                              width: 120,
                              child: Center(
                                child: Text(
                                  "+ Add Photo",
                                  style: CustomTextStyle.style333,
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 50),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    bottom: 0, left: 0, right: 5, top: 10),
                                child: ClipOval(
                                  child: Image.network(
                                    'https://th.bing.com/th/id/OIP.qWehang2VHKUsrv0wICFBwHaHH?pid=ImgDet&rs=1',
                                    height: 40,
                                    width: 40,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 5, bottom: 5, left: 0, right: 0),

                                // height: 40,
                                width: 150,
                                child: TextFormField(
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  controller: oty,
                                  decoration: InputDecoration(
                                      labelText: "Oty",
                                      labelStyle: CustomTextStyle.style111),
                                ),
                              ),
                              Container(
                                width: 150,
                                child: DateTimePicker(
                                  type: DateTimePickerType.date,
                                  dateMask: 'd MMM, yyyy',
                                  // initialValue: DateTime.now().toString(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                  // icon: Icon(
                                  //   Icons.event,
                                  //   color: Colors.black54,
                                  // ),
                                  dateLabelText: 'Date',
                                  style: CustomTextStyle.style111,
                                  // timeLabelText: "Hour",
                                  selectableDayPredicate: (date) {
                                    // Disable weekend days to select from the calendar
                                    if (date.weekday == 6 ||
                                        date.weekday == 7) {
                                      return false;
                                    }

                                    return true;
                                  },
                                  onChanged: (val) => print(val),
                                  validator: (val) {
                                    print(val);
                                    return null;
                                  },
                                  onSaved: (val) => print(val),
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
        ),
      ),
    );
  }
}
