import 'package:cached_network_image/cached_network_image.dart';
import 'package:donor/AdminDashborad/AddUser.dart';
import 'package:donor/Library/TextStyle.dart';
import 'package:donor/model/UserModel.dart';
import 'package:flutter/material.dart';
import '../Library/ApiData.dart';
import '../Library/AppColors.dart';
import '../Library/Utils.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List<UserModel> uList = [];
  late Future fetchUserList;

  getUserList() async {
    try {
      var data = {};
      data['utype'] = '';
      var res = await ApiData().postData('admin_list', data);
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
    fetchUserList = getUserList();
    super.initState();
  }

  deleteUser(uId) async {
    Utils().loading(context);
    try {
      var data = {};
      data = {};
      data['uid'] = uId;
      var res = await ApiData().postData('delete_user', data);
      if (res['st'] == 'success') {
        if (!mounted) return;
        fetchUserList = getUserList();
        Utils().successSnack(context, res["msg"]);
      } else {
        if (!mounted) return;
        Utils().errorSnack(context, res["msg"]);
      }
    } catch (e) {
      print('print error: $e');
      Utils().errorSnack(context, "Failed");
    }
    Navigator.pop(context);
  }

  userCard(UserModel uData, index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2),
      child: SizedBox(
        // height: 80,
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
                        ),
                      ),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  'Usertype : ',
                                  style: FontStyle.textCardValue.copyWith(
                                      fontSize: 12, color: AppColors.grey_90),
                                ),
                                Expanded(
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    uData.utype.toString() == "3"
                                        ? "Sub Admin"
                                        : uData.utype.toString() == "4"
                                            ? "Teacher"
                                            : uData.utype.toString(),
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
            Positioned(
              top: 0,
              right: 0,
              child: PopupMenuButton(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  iconSize: 20,
                  icon: const Icon(
                    Icons.more_vert,
                    color: AppColors.black,
                  ),
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        value: "edit",
                        child: Text(
                          "Edit",
                          style: FontStyle.textLableBold,
                        ),
                      ),
                      const PopupMenuItem(
                        value: "delete",
                        child: Text(
                          "Delete",
                          style: FontStyle.textLableBold,
                        ),
                      ),
                    ];
                  },
                  onSelected: (value) {
                    if (value == "edit") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddUser(
                              userModel: uData,
                              uId: uData.uid,
                            ),
                          ));
                    }
                    if (value == "delete") {
                      Utils().deletePop(context, () {
                        deleteUser(uData.uid);
                      }, 'Are you sure? You want to delete this user.', true);
                    }
                  }),
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
          'User List',
          style: FontStyle.appBarText,
        ),
      ),
      body: FutureBuilder(
        future: fetchUserList,
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
