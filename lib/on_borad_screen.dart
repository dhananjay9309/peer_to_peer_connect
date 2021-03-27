import 'package:flutter/material.dart';
import 'package:flutter_offline_chat/main.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => MainScreen()),
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/$assetName.jpg', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    PageDecoration pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.only(top: 150),
    );

    return SafeArea(
      child: IntroductionScreen(
        key: introKey,
        pages: [
          PageViewModel(
            title: "No Internet Required",
            body:
            "Connect offline to nearby users directly by IP .",
            image: Align(
              child: Image.network('https://cdn1.iconfinder.com/data/icons/network-element-32-px/32/network-no-internet-connection-512.png', width: 350.0),
              alignment: Alignment.bottomCenter,
            ),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Secure and Private",
            body:
            "Peer to Peer chat, no backend server",
            image: Align(
              child: Image.network('https://image.flaticon.com/icons/png/512/1629/1629128.png', width: 350.0),
              alignment: Alignment.bottomCenter,
            ),
            decoration: pageDecoration,
          ),PageViewModel(
            title: "Chat Dispose",
            body:
            "All messages dispose after you disconnect from user.",
            image: Align(
              child: Image.network('https://img.icons8.com/ios/452/litter-disposal.png', width: 350.0),
              alignment: Alignment.bottomCenter,
            ),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => _onIntroEnd(context),
        //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: true,
        skipFlex: 0,
        nextFlex: 0,
        skip: const Text('Skip'),
        next: const Icon(Icons.arrow_forward),
        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
  }
}