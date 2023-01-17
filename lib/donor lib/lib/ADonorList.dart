import 'package:cached_network_image/cached_network_image.dart';
import 'package:donor/Library/TextStyle.dart';
import 'package:flutter/material.dart';
import '../Library/ApiData.dart';
import '../Library/AppColors.dart';
import '../Library/Utils.dart';
import '../model/UserModel.dart';

class ADonorList extends StatefulWidget {
  const ADonorList({super.key});

  @override
  State<ADonorList> createState() => _StudListPageState();
}

class _StudListPageState extends State<ADonorList> {
  List<UserModel> sList = [];
  late Future fetchStudentListPage;

  getUserList() async {
    try {
      var data = {};
      data['utype'] = '2';

      var res = await ApiData().postData('admin_list', data);
      if (res['st'] == 'success') {
        if (!mounted) return;
        sList = UserModelList(res['data'] ?? []);
      } else {
        if (!mounted) return;
        Utils().errorSnack(context, res["msg"]);
      }
    } catch (e) {
      print('print error: $e');
      Utils().errorSnack(context, "Internal Server Error");
    }
    return sList;
  }

  userCard(index) {
    return InkWell(
      onTap: () {},
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
                      border: Border.all(width: 1.5, color: AppColors.grey_09),
                    ),
                    child: ClipOval(
                        child: CachedNetworkImage(
                      height: 70,
                      width: 70,
                      imageUrl: sList[index].uphoto.toString(),
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
                                  sList[index].uname.toString(),
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
                                  sList[index].umobile.toString(),
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
                                  sList[index].uemail.toString(),
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
    );
  }

  @override
  void initState() {
    fetchStudentListPage = getUserList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Donor List',
          style: FontStyle.textLabelWhite,
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
            if (sList.isNotEmpty) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    width: double.infinity,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: sList.length,
                      itemBuilder: (context, index) {
                        return userCard(index);
                      },
                    )),
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
