import 'package:acadmin/Library/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleSpacing: 5,
        centerTitle: true,
        leading: InkWell(
            onTap: () {},
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 20,
            )),
        title: Text(
          'About Event',
          style: tStyle.text_header,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_active_outlined,
              color: AppColors.white_00,
            ),
            onPressed: () {},
          ),
        ],
        backgroundColor: AppColors.blue,
      ),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "Team Conference By Collage",
                        style:
                            tStyle.text_label_big.copyWith(letterSpacing: 0.5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.30,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: const DecorationImage(
                      image: NetworkImage(
                          "https://img.rawpixel.com/s3fs-private/rawpixel_images/website_content/k-26-j-6142482.jpg?auto=format&bg=transparent&con=3&cs=srgb&dpr=1&fm=jpg&ixlib=php-3.1.0&mark=rawpixel-watermark.png&markalpha=90&markpad=13&markscale=10&markx=25&q=75&usm=15&vib=3&w=1400&s=90899ad9dca93e2b976321dd0a671c70"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.person),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Owner',
                                  style: tStyle.textHint.copyWith(
                                      letterSpacing: 0.5, fontSize: 12),
                                ),
                                Text(
                                  'Aupnda Vishara',
                                  style: tStyle.text_label_big.copyWith(
                                      letterSpacing: 0.5, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(Icons.calendar_month),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Event Date',
                                  style: tStyle.textHint.copyWith(
                                      letterSpacing: 0.5, fontSize: 12),
                                ),
                                Text(
                                  formattedDate,
                                  style: tStyle.text_label_big.copyWith(
                                      letterSpacing: 0.5, fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'A meeting is when two or more people come together to discuss one or more topics.',
                            style: tStyle.textHint.copyWith(letterSpacing: 0.5),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'often in a formal or business setting, but meetings also occur in a variety of other environments.',
                            style: tStyle.textHint.copyWith(letterSpacing: 0.5),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Meetings can be used as form of group decision making.',
                            style: tStyle.textHint.copyWith(letterSpacing: 0.5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        "Location :-",
                        style:
                            tStyle.text_label_big.copyWith(letterSpacing: 0.5),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Surat',
                            style: tStyle.text_label_big
                                .copyWith(letterSpacing: 0.5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
