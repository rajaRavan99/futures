// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:cfsys/stylepage/textstyles.dart';
import 'package:cfsys/user.dart';
import 'package:cfsys/userform.dart';

import 'colors.dart';
import 'emptystate.dart';

class MultiForm extends StatefulWidget {
  @override
  _MultiFormState createState() => _MultiFormState();
}

class _MultiFormState extends State<MultiForm> {
  List<UserForm> users = [];
  int itemcount = 1;
  int currentindex = 0;
  var sum = 1;

  // ignore: unused_element
  void _incrementCounter() {
    List<UserForm> users = [];

    for (var i = 0; i < users.length; i++) {
      sum += users[i] as int;
    }

    print("Sum : ${sum}");
    setState(() {
      itemcount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      //Bottom Navigation bar Start :-
      bottomNavigationBar: Container(
        // padding: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          color: AppColors.white_50,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 15.0, // soften the shadow
              spreadRadius: 5.0, //extend the shadow
              offset: Offset(
                5.0, // Move to right 5  horizontally
                5.0, // Move to bottom 5 Vertically
              ),
            )
          ],
        ),
        child: Container(
          margin: EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(width: 2, color: AppColors.grey_90),
                  ),
                  child: Center(
                    child: Text(
                      itemcount.toString(),
                      // "Total",
                      style: CustomTextStyle.bigtextblack,
                    ),
                  )),
              GestureDetector(
                onTap: () {
                  // onAddForm(itemcount);
                  // setState(() {
                  //   itemcount++;
                  // });
                  // print('object $Value');
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.grey_90,
                  ),
                  height: 50,
                  width: 150,
                  // margin: const EdgeInsets.only(left: 5, right: 15, bottom: 20),
                  child: Center(
                    child: Text(
                      "Submit ",
                      style: CustomTextStyle.style44445,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      //Bottom Navigation bar End :-
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: AppColors.grey_90,
        centerTitle: false,
        title: Text(
          'Add Stock',
          style: CustomTextStyle.style3,
        ),
        leading: IconButton(
          splashRadius: 20,
          iconSize: 18,
          icon: const Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.of(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Center(
                child: EmptyState(
                  index: '',
                  title: 'Oops',
                  message: 'Add form by tapping add button below',
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: NeverScrollableScrollPhysics(),
                addAutomaticKeepAlives: true,
                itemCount: users.length,
                itemBuilder: (_, i) => users[i],
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
                  GestureDetector(
                    onTap: () {
                      onAddForm(itemcount);
                      setState(() {
                        itemcount++;
                      });
                      print('object $Value');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColors.grey_90,
                      ),
                      height: 35,
                      width: 120,
                      margin:
                          const EdgeInsets.only(left: 5, right: 15, bottom: 20),
                      child: Center(
                        child: Text(
                          "+ Add New",
                          style: CustomTextStyle.style4444,
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
    );
  }

  ///on form user deleted
  void onDelete(User _user) {
    setState(() {
      var find = users.firstWhere(
        (it) => it.user == _user,
        orElse: () => null!,
      );
      if (find != null) users.removeAt(users.indexOf(find));
    });
  }

  ///on add form
  void onAddForm(index) {
    setState(() {
      var _user = User();
      users.add(UserForm(
        user: _user,
        onDelete: () => onDelete(_user),
        index: index,
      ));
    });
  }

  ///on save forms

}
