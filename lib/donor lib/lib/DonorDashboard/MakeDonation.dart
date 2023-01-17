import 'package:donor/Library/TextStyle.dart';
import 'package:donor/model/DonationTransModel.dart';
import 'package:flutter/material.dart';
import '../Library/ApiData.dart';
import '../Library/Utils.dart';

class MakeDonation extends StatefulWidget {
  const MakeDonation({Key? key}) : super(key: key);

  @override
  State<MakeDonation> createState() => _MakeDonationState();
}

class _MakeDonationState extends State<MakeDonation> {
  DonationTransModel dModel = DonationTransModel();
  TextEditingController amount = TextEditingController(text: '');
  final formKey = GlobalKey<FormState>();

  makeDonation() async {
    try {
      var data = {};
      data['amount'] = amount.text;

      var res = await ApiData().postData('make_donation', data);
      if (res['st'] == 'success') {
        Navigator.pop(context);
        Utils().successSnack(context, res["msg"]);
      } else {
        if (!mounted) return;
        Utils().errorSnack(context, res["msg"]);
      }
    } catch (e) {
      print('print error: $e');
      Utils().errorSnack(context, "Internal Catch Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: InkWell(
        onTap: () {
          if (formKey.currentState!.validate()) {
            makeDonation();
            // Navigator.of(context).push(
            //     MaterialPageRoute(
            //         builder: (context) => )));

          } else {
            return;
          }
        },
        child: Utils().primaryIconButton(
            Icons.payment, 'Donate', MediaQuery.of(context).size.width * 0.7),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 150,
                ),
                const Text(
                  'Enter Amount',
                  style: FontStyle.textInput,
                ),
                const SizedBox(
                  height: 2,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: SizedBox(
                    width: 190,
                    child: TextFormField(
                      autofocus: true,
                      enabled: true,
                      maxLength: 8,
                      maxLines: null,
                      // textAlign: TextAlign.center,
                      controller: amount,
                      enableInteractiveSelection: true,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,

                      style: FontStyle.textInputBig,
                      decoration: InputDecoration(
                        hintText: '0',
                        hintStyle: FontStyle.textHint.copyWith(
                          fontSize: 25,
                        ),
                        counterText: '',
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
                          child: Text(
                            '₹',
                            style: FontStyle.textInputBig,
                          ),
                        ),
                        isDense: true,
                        contentPadding:
                            const EdgeInsets.only(right: 10, top: 5),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please Enter Amount';
                        } else if (double.parse(value) < 1) {
                          return 'Please Enter Amount Upto 1';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
