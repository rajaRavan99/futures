import 'package:image_picker/image_picker.dart';
import 'package:roadapp/Library/TextStyle.dart';
import 'package:flutter/material.dart';
import '../Library/AppColors.dart';

class NewUpload extends StatefulWidget {
  NewUpload({Key? key}) : super(key: key);

  @override
  _NewUploadState createState() => _NewUploadState();
}

class _NewUploadState extends State<NewUpload> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoading = false;
  List<XFile>? imagefiles;
  List<dynamic> images = [];


  @override
  void initState() {
    super.initState();
  }

  Future<void> getImageFromGallery() async {
    List<XFile> pickedFile = await ImagePicker().pickMultiImage();

    print("111111111111111111111111111");
    print(pickedFile);
    print("222222222222222222222222222");
  }

  Widget photolist() {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: 130,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: images.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(left:10.0,right: 10.0),
                  child: SizedBox(
                    height: 120,
                    width: 110,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 120,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.black,width: 1),
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: AssetImage("imagefiles"),
                              ),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(right:10.0,bottom: 10),
                          child: InkWell(
                            onTap: (){
                              setState(() {
                                images.removeAt(index);
                              });
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                color: AppColors.red_55,
                                shape: BoxShape.circle,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Icon(Icons.close_rounded,color: AppColors.white_00,size: 20,),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        titleSpacing: 5,
        title: const Padding(
          padding: EdgeInsets.only(bottom: 5, left: 10.0),
          child: Text("News Upload", style: FontStyle.textHeader),
        ),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [

          Row(
            children: [
              InkWell(
                onTap: (){
                  getImageFromGallery();
                },
                child: Container(
                  height: 130,
                  width: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.grey_10.withOpacity(0.6),width: 1.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.add_circle,color: AppColors.grey_09,size: 35,),

                        SizedBox(height: 3.0,),

                        Text("Upload\nPhotos",style: FontStyle.greyTextSmall,textAlign: TextAlign.center,),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          ],
        ),
      ),
    );
  }
}
