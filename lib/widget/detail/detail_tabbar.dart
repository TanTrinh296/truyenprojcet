import 'dart:async';
import 'dart:convert';

import 'package:MovieProject/ads/adsmanager.dart';
import 'package:MovieProject/bloc/gethistory_bloc.dart';
import 'package:MovieProject/bloc/getmoviebyid_bloc.dart';
import 'package:MovieProject/bloc/updateviewbyid_bloc.dart';
import 'package:MovieProject/preference_share/preference_share.dart';
import 'package:MovieProject/repository/updateviewbyidrepository.dart';
import 'package:MovieProject/screen/listcomic_screen.dart';
import 'package:MovieProject/widget/detail/detail_header.dart';
import 'package:MovieProject/widget/detail/offer.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:MovieProject/style/theme.dart' as Style;
// import 'package:flutter_native_admob/flutter_native_admob.dart';
// import 'package:flutter_native_admob/native_admob_controller.dart';

class TabBarDetail extends StatefulWidget {
  final dynamic argument;
  const TabBarDetail({Key key, this.argument}) : super(key: key);
  @override
  _TabBarDetailState createState() => _TabBarDetailState();
}

class _TabBarDetailState extends State<TabBarDetail>
    with TickerProviderStateMixin {
  PreferenceShare _preferenceShare = PreferenceShare();
  MovieByIDBloc _movieByIDBloc = MovieByIDBloc();
  HistoryBloc _historyBloc = HistoryBloc();
  TabController _tabController;
  // final _nativeAd = NativeAdmob(adUnitID: AdsManager.bannerId);
  // final _nativeAdController = NativeAdmobController();
  // final _nativeAd = NativeAdmob(adUnitID: AdsManager.bannerId);
  double _height = 0;
  StreamSubscription _subscription;
  // bool _checkTabbar;
  bool _checkReverse = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _subscription = _nativeAdController.stateChanged.listen(_onStateChanged);
    // _checkTabbar = false;
    _movieByIDBloc.getMovies(widget.argument["_id"]);
    _tabController = TabController(length: 2, vsync: this);
    _checkTabbarController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _subscription.cancel();
    // _nativeAdController.dispose();
    _tabController.dispose();
  }

  // void _onStateChanged(AdLoadState state) {
  //   switch (state) {
  //     case AdLoadState.loading:
  //       setState(() {
  //         _height = 0;
  //       });
  //       break;
  //
  //     case AdLoadState.loadCompleted:
  //       setState(() {
  //         _height = 150;
  //       });
  //       break;
  //
  //     default:
  //       break;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _movieByIDBloc.getMoviesStream(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            // print(snapshot.data);
            if (snapshot.data == "Error") {
              return _buildError();
            }
            // print(snapshot.data);
            return build_container(snapshot.data[0]);
          } else {
            return _buildLoading();
          }
        });
    // build_container(widget.argument);
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 25,
            width: 25,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
              strokeWidth: 4,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildError() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Có lỗi xảy ra",
              style: TextStyle(
                  height: 1.5,
                  color: Colors.white,
                  // fontWeight: FontWeight.bold,
                  fontSize: 20.0),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: () {
                _movieByIDBloc.getNull();
                _movieByIDBloc.getMovies(widget.argument["_id"]);
              },
              child: Text("Thử lại"),
            )
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget build_container(dynamic data) {
    List temp = data['episode'];
    List list = [];
    _checkReverse == false ? list = temp : list = temp.reversed.toList();
    return NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            SliverAppBar(
              floating: false,
              pinned: true,
              snap: false,
              expandedHeight: 220,
              backgroundColor: Style.ColorScreen.mainColor,
              flexibleSpace: DetailWidget(
                obj: data,
              ),
            ),
            SliverAppBar(
              //floating: false,
              pinned: true,
              snap: false,
              backgroundColor: Style.ColorScreen.mainColor,
              automaticallyImplyLeading: false,
              flexibleSpace: Center(
                child: PreferredSize(
                    child: TabBar(
                      tabs: [
                        Container(
                          padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
                          child: Text(
                            "Chi tiết",
                            style: TextStyle(
                                fontSize: 14.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          "Chapters",
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                      controller: _tabController,
                      indicatorColor: Style.ColorScreen.secondColor,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorWeight: 3.0,
                      unselectedLabelColor: Style.ColorScreen.titleColor,
                      labelColor: Colors.white,
                      isScrollable: true,
                    ),
                    preferredSize: Size.fromHeight(50.0)),
              ),
            )
          ];
        },
        // floatHeaderSlivers: false,
        body: Container(
          child: TabBarView(
            children: [
              CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Container(
                      // color: Style.ColorScreen.mainColor,
                      child: Column(
                        children: <Widget>[
                          // Container(
                          //     height: MediaQuery.of(context).size.height,
                          //     // color: Style.ColorScreen.mainColor,
                          //     child: ListView(
                          //       children: <Widget>[
                          //Container của chi tiết
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Table(
                                children: [
                                  TableRow(children: [
                                    Container(
                                      margin: EdgeInsets.all(5),
                                      child: Text(
                                        "Tên",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(5),
                                      child: Text(
                                        data['ten'],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Container(
                                      margin: EdgeInsets.all(5),
                                      child: Text(
                                        "Trạng thái",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(5),
                                      child: Text(
                                        data['trangthai'],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Container(
                                      margin: EdgeInsets.all(5),
                                      child: Text(
                                        "Tác giả",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(5),
                                      child: Text(
                                        data['tacgia'],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Container(
                                      margin: EdgeInsets.all(5),
                                      child: Text(
                                        "Thể loại",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                        margin: EdgeInsets.all(5),
                                        child: Text(_getTyle(data['theloai']),
                                            style: TextStyle(
                                                color: Colors.white))),
                                  ]),
                                  TableRow(children: [
                                    Container(
                                      margin: EdgeInsets.all(5),
                                      child: Text(
                                        "Lượt xem",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(5),
                                      child: Text(
                                        data['view'].toString(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Container(
                                      margin: EdgeInsets.all(5),
                                      child: Text(
                                        "Chương mới nhất",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(5),
                                      child: Text(
                                        data['episode']
                                                [data['episode'].length - 1]
                                            ["title"],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ]),
                                  TableRow(children: [
                                    Container(
                                      margin: EdgeInsets.all(5),
                                      child: Text(
                                        "Ngày cập nhật",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(5),
                                      child: Text(
                                        data['episode']
                                                [data['episode'].length - 1]
                                            ["date"],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ])
                                ],
                              ),
                            ),
                          ),
                          //Container của nội dung
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          "Nội dung:",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.all(5),
                                      child: Text(
                                        data['noidung'],
                                        style: TextStyle(
                                            color: Colors.yellowAccent),
                                      ))
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      "Đề xuất",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(height: 200, child: OfferWidget()),
                                  // Container(
                                  //   height: _height,
                                  //   padding: EdgeInsets.all(10),
                                  //   margin:
                                  //       EdgeInsets.only(top: 20.0),
                                  //   child: NativeAdmob(
                                  //     // Your ad unit id
                                  //     adUnitID: AdsManager.bannerId,
                                  //     controller: _nativeAdController,
                                  //     type: NativeAdmobType.banner,
                                  //     // Don't show loading widget when in loading state
                                  //     loading: Container(),
                                  //
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          )
                          //   ],
                          // )
                          // ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Stack(
                children: [
                  data['episode'] == []
                      ? Container()
                      : ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                child: GestureDetector(
                                    onTap: () async {
                                      _preferenceShare
                                          .deletePreference(data['_id']);
                                      _preferenceShare.setPreference(
                                          data['_id'], data);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ListComicScreen(
                                                    arguments: data['episode'],
                                                    position: list[index]
                                                        ['title'],
                                                    id: data['_id'],
                                                  )));
                                    },
                                    child: FutureBuilder(
                                        future: _historyBloc.existHistory(
                                            data['_id'] +
                                                "_" +
                                                list[index]['title']),
                                        builder:
                                            (context, AsyncSnapshot snapshot) {
                                          if (snapshot.hasData) {
                                            //print(snapshot.data);
                                            return Container(
                                              decoration: BoxDecoration(
                                                  color: Style
                                                      .ColorScreen.mainColor),
                                              child: ListTile(
                                                title: Text(
                                                  "Chapter " +
                                                      list[index]['title'],
                                                  style: TextStyle(
                                                    color: snapshot.data[
                                                                'result'] ==
                                                            "true"
                                                        ? Colors.white10
                                                        : Colors.white,
                                                  ),
                                                ),
                                                trailing: Text(
                                                  list[index]['date'],
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: snapshot.data[
                                                                'result'] ==
                                                            "true"
                                                        ? Colors.white10
                                                        : Colors.white,
                                                  ),
                                                ),
                                              ),
                                            );
                                          } else {
                                            return _buildLoading();
                                          }
                                        })));
                          },
                          itemCount: list.length,
                          shrinkWrap: true,
                          physics: AlwaysScrollableScrollPhysics(),
                        ),
                  Positioned(
                      bottom: 15 * (MediaQuery.of(context).size.height / 760),
                      right: 15 * (MediaQuery.of(context).size.width / 360),
                      child: FloatingActionButton(
                        backgroundColor: Colors.white70,
                        foregroundColor: Colors.black,
                        child: Icon(Icons.sort),
                        heroTag: 1,
                        onPressed: () {
                          _checkReverse = !_checkReverse;
                          setState(() {});
                        },
                      ))
                ],
              )
            ],
            controller: _tabController,
            physics: AlwaysScrollableScrollPhysics(),
          ),
        ));
  }

  _checkTabbarController() {}

  String _getTyle(dynamic argument) {
    var list = argument as List;
    String stringList = list.join(", ");
    return stringList;
  }
}
