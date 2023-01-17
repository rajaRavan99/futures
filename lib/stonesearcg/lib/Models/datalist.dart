import 'package:flutter/material.dart';
import 'package:stonesearch/DashBoard.dart';
import 'package:stonesearch/Liabrary/AppColors.dart';
import 'package:stonesearch/Liabrary/TextStyle.dart';

import '../Liabrary/DbHelper.dart';
import '../Liabrary/Utils.dart';

class Contactpage extends StatefulWidget {
  const Contactpage({Key? key}) : super(key: key);

  @override
  State<Contactpage> createState() => _ContactpageState();
}

class _ContactpageState extends State<Contactpage> {
  final cname = TextEditingController();
  final cnumber = TextEditingController();
  late Future listofata;
  final form = GlobalKey<FormState>();

  //editcontroller
  final editcname = TextEditingController();
  final editcnumber = TextEditingController();

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  List<dynamic> arrUsers = [];

  @override
  void initState() {
    listofata = getUserListFromDB();
    super.initState();
  }

  getUserListFromDB() async {
    // arrUsers = await DBHelper.getData();
    print(arrUsers.length);
    setState(() {});
    return arrUsers;
  }

  addAlert(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: AlertDialog(
              insetPadding: const EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Add Contact',
                    textAlign: TextAlign.center,
                    style: FontStyle.textHeaderBB.copyWith(fontSize: 18),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        style: FontStyle.textMedium,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        controller: cname,
                        decoration: Utils().inputDecoration('Contact Name', false),
                        onSaved: (val) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return " Filed can't be Empty";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        style: FontStyle.textMedium,
                        keyboardType: TextInputType.number,
                        controller: cnumber,
                        textInputAction: TextInputAction.next,
                        // onSaved: (val) {
                        //   setState(() {
                        //     user.umobile = val;
                        //   });
                        // },
                        validator: (value) {
                          if ((value ?? "") == "" || value!.length < 10) {
                            return "Please enter mobile no";
                          } else {
                            return null;
                          }
                        },
                        decoration:
                            Utils().inputDecoration("Enter Mobile No", false).copyWith(
                                  prefixIcon: GestureDetector(
                                    onTap: () {},
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // CountryPickerUtils.getDefaultFlagImage(country),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          child: Center(
                                              child: Text("",
                                                  style: FontStyle.textHeaderBB
                                                      .copyWith(fontSize: 15))),
                                        ),
                                        const SizedBox(
                                          height: 45.0,
                                          child: VerticalDivider(
                                            color: AppColors.black,
                                            indent: 10,
                                            endIndent: 10,
                                            thickness: 1,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const Contactpage()));
                          snackBar("Added");
                          // if (form.currentState!.validate()) {
                          //   DBContact.insertData(
                          //     cname.text.trim(),
                          //     int.parse(cnumber.text.trim()),
                          //   );
                          //   Navigator.of(context).pushReplacement(
                          //       MaterialPageRoute(
                          //           builder: (context) => const Contactpage()));
                          //   snackBar("Added");
                          // }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Utils().primaryButton(
                              'Add', MediaQuery.of(context).size.width * 0.3),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  card(User, int index) {
    return Stack(
      children: [
        InkWell(
          onTap: () {},
          child: Card(
            color: AppColors.white_00,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            elevation: 1,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Card(
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: const Icon(Icons.fitness_center),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    User['cname'].toString(),
                                    style: FontStyle.textHint.copyWith(
                                        fontSize: 15, color: AppColors.black),
                                  ),
                                  Text(
                                    User['cnumber'].toString(),
                                    style: FontStyle.textHint.copyWith(
                                        fontSize: 15, color: AppColors.black),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Icon(
                                Icons.edit,
                                color: AppColors.primaryColor,
                                size: 22,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Icon(
                                Icons.delete,
                                color: AppColors.primaryColor,
                                size: 22,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          addAlert(context);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
        elevation: 0,
        backgroundColor: AppColors.white_00,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const DashBoard()));
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: Row(
              children: [
                const Icon(
                  Icons.arrow_back_ios,
                ),
                Text(
                  "Back",
                  style: FontStyle.textHeaderBB.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
        ),
        title: const Text(
          "Contact",
          style: FontStyle.textHeaderBB,
        ),
      ),
      body: FutureBuilder(
          future: listofata,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (arrUsers.isNotEmpty) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 2.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: arrUsers.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> User = arrUsers[index];
                      return card(User, index);
                    },
                  ),
                );
              } else {
                return Center(
                    child: Image.asset('assets/image/no_data_found.png'));
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              );
            }
          }),
    );
  }
}
