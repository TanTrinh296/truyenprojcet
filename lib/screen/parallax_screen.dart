import 'package:MovieProject/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nice_button/nice_button.dart';
// import 'package:parallax_image/parallax_image.dart';

class ParallaxScreen extends StatefulWidget {
  @override
  _ParallaxScreenState createState() => _ParallaxScreenState();
}

class _ParallaxScreenState extends State<ParallaxScreen>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  double rate0 = 0;
  double rate2 = 0;
  double rate1 = 0;
  double rate3 = 0;
  double rate4 = 0;
  double rate5 = 0;
  double rate6 = 0;
  double rate7 = 0;
  double rate8 = 0;
  ScrollController _scrollController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    _scrollController = ScrollController();
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.landscapeLeft,
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
  }

  @override
  void didChangeMetrics() {
    // TODO: implement didChangeMetrics
    super.didChangeMetrics();
    _scrollController.jumpTo(0);
    setState(() {
      rate0 = 0;
      rate2 = 0;
      rate1 = 0;
      rate3 = 0;
      rate4 = 0;
      rate5 = 0;
      rate6 = 0;
      rate7 = 0;
      rate8 = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        return _screen();
      } else {
        return _screen();
      }
    });
  }

  Widget _screen() {
    return NotificationListener(
        // ignore: missing_return
        onNotification: (v) {
          if (v is ScrollUpdateNotification) {
            setState(() {
              rate8 -= v.scrollDelta / 1.5;
              rate7 -= v.scrollDelta / 2;
              rate6 -= v.scrollDelta / 2.5;
              rate5 -= v.scrollDelta / 3;
              rate4 -= v.scrollDelta / 3.5;
              rate3 -= v.scrollDelta / 4;
              rate2 -= v.scrollDelta / 4.5;
              rate1 -= v.scrollDelta / 5;
              rate0 -= v.scrollDelta / 5.5;
            });
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              ParallaxWidget(top: rate0, asset: "images/Layout0.png"),
              ParallaxWidget(top: rate1, asset: "images/Layout1.png"),
              ParallaxWidget(top: rate3, asset: "images/Layout2.png"),
              ParallaxWidget(top: rate4, asset: "images/Layout3.png"),
              ParallaxWidget(top: rate5, asset: "images/Layout4.png"),
              ParallaxWidget(top: rate6, asset: "images/Layout5.png"),
              ParallaxWidget(top: rate7, asset: "images/Layout6.png"),
              ParallaxWidget(top: rate8, asset: "images/Layout7.png"),
              ParallaxWidget(top: rate8, asset: "images/Layout8.png"),
              ListView(
                controller: _scrollController,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height-200,
                    color: Colors.transparent,
                  ),
                  Container(
                    color: Colors.transparent,
                    width: double.infinity,
                    padding: EdgeInsets.only(top: 70),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Welcome to",
                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: "MontSerrat-ExtraLight",
                              letterSpacing: 1.8,
                              color: Colors.deepOrangeAccent
                              //Color(0xffffaf00)
                              ),
                        ),
                        Text(
                          "WiGa",
                          style: TextStyle(
                              fontSize: 51,
                              fontFamily: "MontSerrat-Regular",
                              letterSpacing: 1.8,
                              color: Colors.deepOrangeAccent),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 190,
                          child: Divider(
                            height: 1,
                            color: Colors.deepOrangeAccent,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        NiceButton(
                          radius: 40,
                          padding: const EdgeInsets.all(15),
                          text: "Continue",
                          gradientColors: [
                            Colors.deepOrangeAccent,
                            Colors.deepOrangeAccent[100],
                            Colors.deepOrangeAccent[100],
                            Colors.deepOrangeAccent,
                          ],
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen()));
                          },
                          background: Colors.deepOrangeAccent,
                        ),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

class ParallaxWidget extends StatelessWidget {
  const ParallaxWidget({
    Key key,
    @required this.top,
    @required this.asset,
  }) : super(key: key);

  final double top;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      // left: -45,
      top: top,
      child: Container(
        height: MediaQuery.of(context).size.height + 200,
        width: 1000,
        child: Image.asset(asset, fit: BoxFit.fill),
      ),
    );
  }
}
