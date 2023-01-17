import 'package:donor/Library/TextStyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Library/AppColors.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:donor/AdminDashborad/AddUser.dart';
import 'package:donor/Library/TextStyle.dart';
import 'package:donor/model/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../Library/ApiData.dart';
import '../Library/AppColors.dart';
import '../Library/Utils.dart';
import 'DStudentDetail.dart';

class StudentListPage extends StatefulWidget {
  const StudentListPage({Key? key}) : super(key: key);

  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  List<UserModel> uList = [];
  late Future fetchStudentListPage;

  getStudentListPage() async {
    try {
      var data = {};
      data['utype'] = '1';

      var res = await ApiData().postData('student_list', data);
      if (res['st'] == 'success') {
        if (!mounted) return;
        uList = UserModelList(res['data'] ?? []);
      } else {
        if (!mounted) return;
        Utils().errorSnack(context, res["msg"]);
      }
    } catch (e) {
      print('print error: $e');
      Utils().errorSnack(context, "Internal Server Error");
    }
    return uList;
  }

  @override
  void initState() {
    fetchStudentListPage = getStudentListPage();
    super.initState();
  }

  userCard(UserModel uData, index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DStudentDetail(
                    uid: uData.uid!,
                  )));
        },
        child: Stack(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:
                            Border.all(width: 1.5, color: AppColors.grey_09),
                      ),
                      child: ClipOval(
                          child: CachedNetworkImage(
                        height: 70,
                        width: 70,
                        imageUrl: uData.uphoto.toString(),
                        errorWidget: (context, url, error) => ClipOval(
                          child: Image.asset(
                            'assets/image/person.png',
                            width: 70,
                            height: 70,
                            fit: BoxFit.fill,
                          ),
                        ),
                      )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 30),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    // 'Tushar',
                                    uData.uname.toString(),
                                    style: FontStyle.textHint.copyWith(
                                        fontSize: 15, color: AppColors.black),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    uData.umobile.toString(),
                                    style: FontStyle.textCardValue.copyWith(
                                        fontSize: 12, color: AppColors.grey_90),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    uData.uemail.toString(),
                                    style: FontStyle.textCardValue.copyWith(
                                        fontSize: 12, color: AppColors.grey_90),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Student List',
          style: FontStyle.appBarText,
        ),
      ),
      body: FutureBuilder(
        future: fetchStudentListPage,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            );
          } else {
            if (uList.isNotEmpty) {
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: uList.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return userCard(uList[index], index);
                },
              );
            } else {
              return Utils().noItem('No Data Found');
            }
          }
        },
      ),
    );
  }
}
