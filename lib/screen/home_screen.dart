import 'dart:async';

import 'package:MovieProject/ads/adsmanager.dart';
import 'package:MovieProject/bloc/getmovie_bloc.dart';
import 'package:MovieProject/widget/home/firsttab/listmovie.dart';
import 'package:MovieProject/widget/home/firsttab/movietitle.dart';
import 'package:MovieProject/widget/home/fourthtab/options.dart';
import 'package:MovieProject/widget/webview/webview.dart';
import 'package:MovieProject/widget/home/secondtab/classifyhome.dart';
import 'package:MovieProject/widget/home/thirdtab/history.dart';
import 'package:MovieProject/widget/search/search_appbar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:MovieProject/style/theme.dart' as Style;
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  MovieBloc bloc = MovieBloc();
  TabController _tabController;
  List<dynamic> data;
  ScrollController _scrollController = ScrollController();
  AnimationController _animationController;
  AnimationController _flippingAnimationController;
  Animation _animation;
  Animation _rotationAnimation;
  Animation _flippingAnimation;
  DefaultCacheManager _cacheManager = DefaultCacheManager();
  bool _loading = false;
  InterstitialAd _interstitialAd;
  bool _isInterstitialAdReady;
  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    _tabController = TabController(length: 4, vsync: this);
    _checkLoading();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    // _flippingAnimationController =
    //     AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    _rotationAnimation = Tween(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    // _flippingAnimation = Tween(begin: 0.0, end: 360.0).animate(CurvedAnimation(
    //     parent: _flippingAnimationController, curve: Curves.easeOut));
    _animationController.addListener(() {
      setState(() {});
    });
    // _flippingAnimationController.addListener(() {
    //   print(_flippingAnimation.value);
    //   setState(() {});
    // });
    // Timer.periodic(Duration(seconds: 1), (Timer timer) {
    //   if (_flippingAnimationController.isCompleted) {
    //     _flippingAnimationController.forward();
    //   }
    //   // if (_animationController.isCompleted) {
    //   //   _animationController.reverse();
    //   // } else {
    //   //   _animationController.forward();
    //   // }
    // });
    // _isInterstitialAdReady = false;

    // print(AdsManager.appId);
    _initAdMob();
    _loadInterstitialAd();
    _isInterstitialAdReady = false;
    Timer.periodic(Duration(minutes: 15), (Timer timer) {
      _loadInterstitialAd();
      setState(() {});
    });
    super.initState();
  }

  void _loadInterstitialAd() {
    _interstitialAd = InterstitialAd(
      adUnitId: AdsManager.appId,
      listener: _onInterstitialAdEvent,
    );
    _interstitialAd..load();
  }

  void _showInterstitialAd() {
    _interstitialAd..show();
  }

  void _onInterstitialAdEvent(MobileAdEvent event) {
    // print(event);
    // if (event == MobileAdEvent.closed) {
    //   // _loadInterstitialAd();
    // }
    switch (event) {
      case MobileAdEvent.loaded:
        _isInterstitialAdReady = true;
        setState(() {});
        break;
      case MobileAdEvent.failedToLoad:
        _isInterstitialAdReady = false;
        setState(() {});
        print('Failed to load an interstitial ad');
        break;
      case MobileAdEvent.closed:
        break;
      default:
      // do nothing
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
    _animationController.dispose();
    // _flippingAnimationController.dispose();
    _cacheManager.emptyCache();
    _interstitialAd?.dispose();
  }

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        backgroundColor: Style.ColorScreen.mainColor,
        body: Stack(
          children: [
            TabBarView(controller: _tabController, children: [
              CustomScrollView(
                controller: _scrollController,
                slivers: <Widget>[
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    floating: false,
                    pinned: true,
                    snap: false,
                    expandedHeight: 220,
                    backgroundColor: Style.ColorScreen.mainColor,
                    centerTitle: true,
                    // leading: Icon(
                    //   EvaIcons.menu2Outline,
                    //   color: Colors.white,
                    // ),
                    title: Text("WiGa"),
                    flexibleSpace: MovieTitleWidget(),
                    actions: <Widget>[
                      IconButton(
                          icon: Icon(
                            EvaIcons.searchOutline,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SearchWidget()));
                          })
                    ],
                  ),
                  ListMovieWidget(
                    loading: _loading,
                  )
                ],
              ),
              ClassifyHome(),
              HistoryWidget(),
              OptionsWidget()
              // WebViewWidget()
            ]),
            Positioned(
                height: 300,
                width: 300,
                right: 20 * (MediaQuery.of(context).size.width / 360),
                bottom: 20 * (MediaQuery.of(context).size.width / 760),
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Transform.translate(
                      offset: Offset.fromDirection(
                          getRadiansFromDegree(270), _animation.value * 100),
                      child: Transform(
                        transform: Matrix4.rotationZ(
                            getRadiansFromDegree(_rotationAnimation.value)),
                        alignment: Alignment.center,
                        child: FloatingActionButton(
                            heroTag: "btn_note",
                            backgroundColor: Colors.black54,
                            focusColor: Colors.white70,
                            child: Icon(Icons.error_outline),
                            onPressed: () {
                              return showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                        child: Container(
                                          height: 700,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: ListView(
                                            children: [
                                              ListTile(
                                                leading: Text(
                                                  "Load lâu?",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              ListTile(
                                                subtitle: Text(
                                                    "Xin lỗi vì sự bất tiện này! Nếu trong quá trình trải nghiệm ứng dụng load hơn bình thường thì mong bạn đọc cố găng chờ từ 15 đến 30 giây hoặc xem tin tức trong thời gian chờ."),
                                              ),
                                              ListTile(
                                                leading: Text(
                                                  "Hình ảnh lỗi?",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              ListTile(
                                                subtitle: Text(
                                                    "Nếu tải ảnh bị lỗi thì hãy tắt app và mở lại, hãy chắc chắn rằng thiết bị đang kết nối với internet."),
                                              ),
                                              ListTile(
                                                leading: Text(
                                                  "Lời nhắn",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              ListTile(
                                                  subtitle: Text(
                                                      "Ứng dụng này được phát triển chỉ nhằm mục đích học tập và mang tính chất cộng đồng. Nếu bạn đọc cảm thấy có trải nghiệm tốt trong quá trình sử dụng thì có thể nhấn vào xem quảng cáo để ủng hộ và tạo động lực để mình phát triển ứng dụng trong tương lai. Quảng cáo sẽ được đưa vào mục chọn lựa để không ảnh hưởng đến trải nghiệm của bạn đọc.")),
                                              ListTile(
                                                subtitle: Text(
                                                    "Ứng dụng được phát triển bởi một sinh viên nên kinh nghiệm và kinh phí thấp. Chỉ có thể tận dụng những công nghệ sẳn có và miễn phí nên có thể sẽ cản trở bạn đọc trong việc trải nghiệm. Xin lỗi vì sự bất tiện này!"),
                                              ),
                                              ListTile(
                                                leading: Text(
                                                  "Kết",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              ListTile(
                                                subtitle: Text(
                                                    "Ứng dụng này cũng vì mục đích nhận phản hồi của người dùng. Vì vậy, nếu bạn đọc trong quá trình trải nghiệm có điểm gì hài lòng hoặc không hài lòng thì hãy viết đánh giá cho mình biết nhé! "),
                                              ),
                                              ListTile(
                                                subtitle: Text("Cảm ơn!"),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  FlatButton(
                                                      onPressed: () {
                                                        // Navigator.of(context)
                                                        //     .pop(false);
                                                      },
                                                      child: Text(
                                                        'Đánh giá',
                                                        style: TextStyle(
                                                            color: Colors.blue),
                                                      )),
                                                  FlatButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(false);
                                                      },
                                                      child: Text(
                                                        'Tắt',
                                                        style: TextStyle(
                                                            color: Colors.blue),
                                                      )),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ));
                            }),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset.fromDirection(
                          getRadiansFromDegree(225), _animation.value * 100),
                      child: Transform(
                        transform: Matrix4.rotationZ(
                            getRadiansFromDegree(_rotationAnimation.value)),
                        alignment: Alignment.center,
                        child: FloatingActionButton(
                            heroTag: "btn_news",
                            backgroundColor: Colors.black54,
                            focusColor: Colors.white70,
                            child: Icon(Icons.article_outlined),
                            onPressed: () {
                              print("Press");
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => WebViewWidget()));
                            }),
                      ),
                    ),
                    Transform.translate(
                      offset: Offset.fromDirection(
                          getRadiansFromDegree(180), _animation.value * 100),
                      child: Transform(
                        transform: Matrix4.rotationZ(
                            getRadiansFromDegree(_rotationAnimation.value)),
                        alignment: Alignment.center,
                        child: FloatingActionButton(
                            heroTag: "btn_ads",
                            backgroundColor: Colors.black54,
                            focusColor: Colors.white70,
                            child: Stack(
                              children: _isInterstitialAdReady == true
                                  ? enableAds()
                                  : disableAds(),
                            ),
                            onPressed: () {
                              if (_isInterstitialAdReady) {
                                _showInterstitialAd();
                                _isInterstitialAdReady = false;
                                setState(() {});
                              } else {
                                return showDialog(
                                  context: context,
                                  builder: (context) => new AlertDialog(
                                    //title: new Text('Thoát ứng dụng'),
                                    content: new Text(
                                        'Không có quảng cáo vui lòng quay lại sau'),
                                    actions: <Widget>[
                                      FlatButton(
                                          onPressed: () {
                                            Navigator.of(context).pop(true);
                                          },
                                          child: Text('Tắt')),
                                    ],
                                  ),
                                );
                              }

                              // setState(() {});
                            }),
                      ),
                    ),
                    Transform(
                      transform: Matrix4.rotationZ(
                          getRadiansFromDegree(_rotationAnimation.value)),
                      alignment: Alignment.center,
                      child: FloatingActionButton(
                          heroTag: "btn_menu",
                          backgroundColor: Colors.black,
                          focusColor: Colors.white70,
                          child: Icon(Icons.add),
                          onPressed: () {
                            if (_animationController.isCompleted) {
                              _animationController.reverse();
                            } else {
                              _animationController.forward();
                            }
                          }),
                    ),
                  ],
                ))
          ],
        ),
        bottomNavigationBar: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: new Icon(Icons.home),
            ),
            Tab(
              icon: new Icon(Icons.auto_awesome_motion),
            ),
            Tab(
              icon: new Icon(Icons.history),
            ),
            Tab(
              icon: new Icon(Icons.settings),
            )
          ],
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorPadding: EdgeInsets.all(5.0),
          indicatorColor: Colors.red,
        ),
      ),
    );
  }

  List<Widget> enableAds() {
    List<Widget> list = [];
    list.add(
      Icon(Icons.video_collection),
    );
    list.add(Positioned(
      right: 0,
      child: Container(
        padding: EdgeInsets.all(1),
        decoration: new BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(6),
        ),
        constraints: BoxConstraints(
          minWidth: 5,
          minHeight: 5,
        ),
      ),
    ));
    return list;
  }

  List<Widget> disableAds() {
    List<Widget> list = [];
    list.add(
      Icon(Icons.video_collection),
    );

    return list;
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            //title: new Text('Thoát ứng dụng'),
            content: new Text('Bạn có chắc chắn muốn thoát?'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    _cacheManager.emptyCache();
                  },
                  child: Text('Có')),
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: new Text('Không')),
            ],
          ),
        ) ??
        false;
  }

  Future<void> _initAdMob() {
    return FirebaseAdMob.instance.initialize(appId: AdsManager.appId);
  }

  void _checkLoading() {
    _scrollController.addListener(() {
      if (_scrollController.offset >=
              _scrollController.position.maxScrollExtent &&
          !_scrollController.position.outOfRange) {
        _loading = true;
        // print(_loading);
        Future.delayed(const Duration(seconds: 1), () => setState(() {}));
      } else {
        _loading = false;
        // print(_loading);
        // setState(() {});
      }
    });
  }
}
