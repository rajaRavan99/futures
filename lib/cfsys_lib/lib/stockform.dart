import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class formpage extends StatefulWidget {
  const formpage({super.key});

  @override
  State<formpage> createState() => _formpageState();
}

class _formpageState extends State<formpage> {
  TextEditingController plain = TextEditingController();
  TextEditingController oty = TextEditingController();
  TextEditingController details = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Row(
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
                                color: Colors.white54,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
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
                        // controller: design,
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
    );
  }
}
