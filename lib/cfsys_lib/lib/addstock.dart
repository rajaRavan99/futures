import 'package:cfsys/userform.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'multiform.dart';

class addstock extends StatefulWidget {
  const addstock({super.key});

  @override
  State<addstock> createState() => _addstockState();
}

class _addstockState extends State<addstock> {
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
                    height: 250,
                    // color: Colors.black38,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: 20, bottom: 5, left: 25, right: 15),
                                padding: EdgeInsets.all(4),
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
                          margin: EdgeInsets.only(
                              top: 10, bottom: 5, left: 25, right: 15),
                          padding: EdgeInsets.all(4),
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
                        Container(
                          margin: EdgeInsets.only(
                              top: 5, bottom: 5, left: 25, right: 25),
                          padding: EdgeInsets.all(4),

                          width: double.infinity,
                          // color: Colors.black,
                          child: TextFormField(
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            controller: chalan,
                            decoration: const InputDecoration(
                              labelText: "Chalan No",
                              labelStyle: TextStyle(
                                color: Colors.black38,
                              ),
                            ),
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
                              top: 10, left: 15, right: 15, bottom: 20),
                          color: Colors.black45,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)),
                          width: context.width,
                          margin: const EdgeInsets.only(
                              left: 5, right: 15, bottom: 20),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.black38, // background
                              onPrimary: Colors.white, // foreground
                            ),
                            onPressed: () {},
                            child: Text(
                              "+ Add Now",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              bottom: 20, left: 30, right: 5, top: 10),
                          child: ClipOval(
                            child: Image.network(
                              'https://th.bing.com/th/id/OIP.qWehang2VHKUsrv0wICFBwHaHH?pid=ImgDet&rs=1',
                              height: 40,
                              width: 40,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 5, bottom: 5, left: 115, right: 20),
                            padding: EdgeInsets.all(4),
                            height: 40,
                            width: double.infinity,
                            child: TextFormField(
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              controller: plain,
                              decoration: const InputDecoration(
                                labelText: "Plain",
                                labelStyle: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.black38)),
                          margin: EdgeInsets.only(
                              top: 5, bottom: 5, left: 20, right: 30),
                          padding: EdgeInsets.only(top: 2, left: 50, right: 50),
                          // height: 40,
                          width: double.infinity,
                          child: TextFormField(
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            controller: oty,
                            decoration: const InputDecoration(
                              labelText: "Oty",
                              labelStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.black38,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 5, bottom: 5, left: 10, right: 20),
                          padding: EdgeInsets.all(4),
                          height: 40,
                          width: double.infinity,
                          child: TextFormField(
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            controller: details,
                            decoration: InputDecoration(
                              labelText: "Detail",
                              labelStyle: GoogleFonts.lato(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black38,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                              top: 5, bottom: 5, left: 190, right: 20),
                          padding: EdgeInsets.all(4),
                          height: 40,
                          width: double.infinity,
                          child: TextFormField(
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            controller: design,
                            decoration: const InputDecoration(
                              labelText: "Design",
                              labelStyle: TextStyle(
                                color: Colors.black26,
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
      ),
    );
  }
}
