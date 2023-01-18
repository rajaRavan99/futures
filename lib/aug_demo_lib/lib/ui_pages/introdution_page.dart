// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'package:aug_new_demo/ui_pages/sign_up.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

import 'package:get/get.dart';
// import 'package:test_demo/pages/Ui_pages.dart/loginsinup.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return GetMaterialApp(
      title: 'Introduction screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: OnBoardingPage(),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const signup()),
    );
  }

  // Widget _buildFullscreenImage() {
  //   return Image.asset(
  //     'assets/images/mainlogo.jpg',
  //     fit: BoxFit.cover,
  //     height: double.infinity,
  //     width: double.infinity,
  //     alignment: Alignment.center,
  //   );
  // }

  // Widget _buildImage(String assetName, [double width = 50]) {
  //   return Image.asset(
  //     'assets/images/mainlogo.jpg',
  //     width: width,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      // globalHeader: Align(
      //   alignment: Alignment.topRight,
      //   child: SafeArea(
      //     child: Padding(
      //       padding: EdgeInsets.only(top: 16, right: 16),
      //       child: Image.network(
      //         'https://www.bing.com/th?id=OIP.rpBlLDouIU7fD36E6NFCKQHaHa&w=250&h=250&c=8&rs=1&qlt=90&o=6&dpr=1.38&pid=3.1&rm=2',
      //         width: 50,
      //       ),

      //       // Image.asset(
      //       //   'assets/images/mainlogo.jpg',
      //       //   width: 50,
      //       // ),
      //     ),
      //   ),
      // ),
      globalFooter: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          child: const Text(
            'Let\'s go right away!',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Get.to(const signup());
          },
        ),
      ),
      pages: [
        PageViewModel(
          title: "Welcome User",
          body: "",
          image: Lottie.network(
            "https://assets2.lottiefiles.com/packages/lf20_sw1dbp1d.json",
            height: 250,
          ),
          decoration: const PageDecoration(
            titleTextStyle:
                TextStyle(fontWeight: FontWeight.normal, fontSize: 30.0),
            // bodyTextStyle:
            //     TextStyle(fontWeight: FontWeight.w700, fontSize: 40.0),
          ),
        ),
        PageViewModel(
          title: "We Are Thank You For ",
          body: "Download the app ",
          image: Lottie.network(
              'https://assets10.lottiefiles.com/private_files/lf30_pavucpbw.json',
              height: 250),
          decoration: const PageDecoration(
            titleTextStyle:
                TextStyle(fontWeight: FontWeight.normal, fontSize: 30.0),
            // bodyTextStyle:
            //     TextStyle(fontWeight: FontWeight.w700, fontSize: 40.0),
          ),
        ),
        PageViewModel(
          title: "Confused For How To Use App",
          body: "",
          image: Lottie.network(
              'https://assets10.lottiefiles.com/packages/lf20_unlZRC.json'),
          decoration: const PageDecoration(
            titleTextStyle:
                TextStyle(fontWeight: FontWeight.normal, fontSize: 20.0),
            // bodyTextStyle:
            //     TextStyle(fontWeight: FontWeight.w700, fontSize: 40.0),
          ),
        ),
        PageViewModel(
          title: "Health is wealth",
          body: "For Good Health in Future Eat Healthy from to Now",
          image: Lottie.network(
              'https://assets10.lottiefiles.com/packages/lf20_ginda0jy.json'),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: false,
            bodyFlex: 2,
            imageFlex: 3,
          ),
        ),
        PageViewModel(
          title: "Think Positive",
          body: "When you think positive Good things Happen",
          image: Lottie.network(
              'https://assets4.lottiefiles.com/packages/lf20_yqnh895a.json'),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: false,
            bodyFlex: 2,
            imageFlex: 3,
          ),
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text("This is the screen after Introduction")),
    );
  }
}
