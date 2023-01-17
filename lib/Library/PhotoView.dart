import 'package:flutter/material.dart';
import 'package:future/Library/TextStyle.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import '../model/DocModel.dart';
import 'AppColors.dart';

class PhotoView extends StatefulWidget {
  const PhotoView({Key? key, required this.docList, required this.index})
      : super(key: key);
  final List<DocModel> docList;
  final int index;

  @override
  PhotoViewState createState() => PhotoViewState();
}

class PhotoViewState extends State<PhotoView> {
  List<DocModel> docList = [];

  @override
  void initState() {
    docList = widget.docList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PageController _pageController =
        PageController(initialPage: widget.index.toInt());
    return Scaffold(
      backgroundColor: AppColors.grey_90,
      body: Center(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.only(left: 2, right: 2),
              width: MediaQuery.of(context).size.width,
              color: AppColors.grey_90,
              child: PhotoViewGallery.builder(
                itemCount: docList.length,
                pageController: _pageController,
                builder: (context, index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(docList[index].show_path!),
                    minScale: PhotoViewComputedScale.contained * 1,
                    maxScale: PhotoViewComputedScale.covered * 2,
                  );
                },
                scrollPhysics: const BouncingScrollPhysics(),
                backgroundDecoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: AppColors.grey_90,
                ),
                enableRotation: false,
                loadingBuilder: (context, event) => Center(
                  child: SizedBox(
                    width: 30.0,
                    height: 30.0,
                    child: CircularProgressIndicator(
                      backgroundColor: AppColors.primaryColor,
                      value: event == null
                          ? 0
                          : event.cumulativeBytesLoaded /
                              event.expectedTotalBytes!,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 15,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white_00,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: AppColors.black,
                          size: 25,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          "Back",
                          style: FontStyle.textLabel,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
