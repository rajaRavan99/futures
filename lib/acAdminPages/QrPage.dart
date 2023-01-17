import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class GenerateScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GenerateScreenState();
}

class GenerateScreenState extends State<GenerateScreen> {
  static const double _topSectionTopPadding = 50.0;
  static const double _topSectionBottomPadding = 20.0;
  static const double _topSectionHeight = 50.0;

  GlobalKey globalKey = new GlobalKey();
  String _dataString = "Hello from this QR";
  late String _inputErrorText;
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
        actions: <Widget>[
          IconButton(onPressed: () {

          },
            icon: Icon(Icons.share),
            // onPressed: createImageFromRepaintBoundary,
          )
        ],
      ),
      body: _contentWidget(),
    );
  }

  Future<Uint8List?> createImageFromRepaintBoundary(
    GlobalKey boundaryKey, {
    double? pixelRatio,
    Size? imageSize,
  }) async {
    assert(
      boundaryKey.currentContext?.findRenderObject() is RenderRepaintBoundary,
    );
    final RenderRepaintBoundary boundary =
        boundaryKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
    final BoxConstraints constraints = boundary.constraints;
    double? outputRatio = pixelRatio;
    if (imageSize != null) {
      outputRatio = imageSize.width / constraints.maxWidth;
    }
    final ui.Image image = await boundary.toImage(
      pixelRatio:
          outputRatio ?? MediaQueryData.fromWindow(ui.window).devicePixelRatio,
    );
    final ByteData? byteData = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    final Uint8List? imageData = byteData?.buffer.asUint8List();
    return imageData;
  }

  _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
    return Container(
      color: const Color(0xFFFFFFFF),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: _topSectionTopPadding,
              left: 20.0,
              right: 10.0,
              bottom: _topSectionBottomPadding,
            ),
            child: Container(
              height: _topSectionHeight,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: "Enter a custom message",
                        errorText: _inputErrorText,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          _dataString = _textController.text;
                          _inputErrorText = 'sd';
                        });
                      },
                      child: Container(
                        child: Text("SUBMIT"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: RepaintBoundary(
                key: globalKey,
                child: QrImage(
                  data: _dataString,
                  size: 0.5 * bodyHeight,
                  // onError: (ex) {
                  //   print("[QR] ERROR - $ex");
                  //   setState(() {
                  //     _inputErrorText =
                  //         "Error! Maybe your input value is too long?";
                  //   });
                  // },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
