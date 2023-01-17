import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:donor/Library/TextStyle.dart';
import 'package:donor/Login/OtpPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Library/AppColors.dart';
import '../Library/Utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController numController = TextEditingController();
  int type = 1;

  bool isHidden = true;
  final _formKey = GlobalKey<FormState>();

  String? emptyValidator(value) {
    if (value!.isEmpty) {
      return 'Please Enter Password';
    }
    return null;
  }

  Country countryData = CountryPickerUtils.getCountryByPhoneCode('91');

  void openCountryPickerDialog() => showDialog(
      context: context,
      builder: (context) {
        return Theme(
          data:
              Theme.of(context).copyWith(primaryColor: AppColors.primaryColor),
          child: CountryPickerDialog(
            searchCursorColor: Colors.black,
            divider: const Divider(
              height: 5,
              color: AppColors.grey_10,
              thickness: 0.1,
            ),
            searchInputDecoration:
                Utils().inputSmallDecoration("Search Country").copyWith(
                      suffixIcon: const Icon(
                        Icons.search_rounded,
                        color: AppColors.black,
                      ),
                    ),
            isSearchable: true,
            title: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Select your phone code',
                style: FontStyle.textBold,
              ),
            ),
            onValuePicked: (Country country) =>
                setState(() => countryData = country),
            itemBuilder: (Country country) {
              return Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: CountryPickerUtils.getDefaultFlagImage(country),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    "+${country.phoneCode}",
                    style: FontStyle.textBold,
                  ),
                  const SizedBox(width: 8.0),
                  Flexible(
                      child: Text(country.name, style: FontStyle.textLabel)),
                ],
              );
            },
            priorityList: [
              CountryPickerUtils.getCountryByIsoCode('IN'),
              CountryPickerUtils.getCountryByIsoCode('DE'),
            ],
          ),
        );
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.primaryColor,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    color: AppColors.primaryColor,
                    width: context.width,
                    child: Image.asset(
                      'assets/image/logo2.png',
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height -
                        200 -
                        MediaQuery.of(context).padding.top,
                    color: AppColors.white_00,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: const Text(
                                'Sign In',
                                style: FontStyle.textHeader,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(
                                top: 10,
                              ),
                              child: TextFormField(
                                style: FontStyle.inputform,
                                controller: numController,
                                keyboardType: TextInputType.phone,
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if ((value ?? "") == "" ||
                                      value!.length < 10) {
                                    return "Please enter mobile no";
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: Utils()
                                    .inputDecoration("Enter Mobile No")
                                    .copyWith(
                                      prefixIcon: GestureDetector(
                                        onTap: () {
                                          openCountryPickerDialog();
                                        },
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
                                                  child: Text(
                                                      "+${countryData.phoneCode}",
                                                      style: FontStyle.textInput
                                                          .copyWith())),
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
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      if (_formKey.currentState!.validate()) {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => OtpPage(
                                                phoneNumber:
                                                    '+${countryData.phoneCode}${numController.text}'),
                                          ),
                                        );
                                      }
                                    },
                                    child: Utils().primaryButton('Sign in',
                                        MediaQuery.of(context).size.width),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 100,
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
      ),
    );
  }
}
