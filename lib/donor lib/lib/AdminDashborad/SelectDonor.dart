import 'package:donor/Library/AppColors.dart';
import 'package:donor/Library/TextStyle.dart';
import 'package:flutter/material.dart';

import '../Library/Utils.dart';

class SelectDonor extends StatefulWidget {
  const SelectDonor({Key? key}) : super(key: key);

  @override
  State<SelectDonor> createState() => _SelectDonorState();
}

class _SelectDonorState extends State<SelectDonor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      appBar: AppBar(
        title: const Text(
          'Select Donor',
          style: FontStyle.textLabelWhite,
        ),
      ),

      bottomNavigationBar: Card(
        margin: EdgeInsets.zero,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        child: SizedBox(
          height: 70,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Utils().primaryButton('Next', MediaQuery.of(context).size.width*0.3),
                Text('60,000',style: FontStyle.textHeaderPrimary.copyWith(color: AppColors.black),)
              ],
            ),
          ),
        ),
      ),

      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 2,
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: Checkbox(

                              value: false,
                              onChanged: (value) {

                              },
                            ),
                          )
                        ],
                      ),
                    ),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            'Donor Name',
                            style: FontStyle.textCardTitle.copyWith(fontFamily: 'SemiBold',fontSize: 14),
                          ),

                          Text(
                            'Date',
                            style: FontStyle.textHintform.copyWith(fontSize: 13,fontFamily: 'Medium'),
                          ),

                        ],
                      ),
                    ),

                    Column(
                      children: [

                        SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width*0.30,
                          child: TextFormField(
                            decoration: Utils().inputDecoration('msg').copyWith(isDense: true,contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10)),
                            keyboardType: TextInputType.number,
                          ),
                        )

                      ],
                    ),

                  ],
                ),
              ),
            ),
          );
        },
      ),

    );
  }
}
