import 'dart:async';

import 'package:MovieProject/bloc/getEpisode_bloc.dart';
import 'package:MovieProject/bloc/getEpisode_bloc.dart';
import 'package:MovieProject/bloc/gethistory_bloc.dart';
import 'package:MovieProject/bloc/getpreferencebackgroundcolors_bloc.dart';
import 'package:MovieProject/bloc/updateviewbyid_bloc.dart';
import 'package:flutter/material.dart';
import 'package:MovieProject/style/theme.dart' as Style;
import 'package:flutter/rendering.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:vector_math/vector_math_64.dart' hide Colors;
// import 'package:flutter_sticky_header/flutter_sticky_header.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
// import 'package:sticky_headers/sticky_headers/widget.dart';

class ListImage extends StatefulWidget {
  final String id;
  final dynamic arguments;
  final String position;
  const ListImage({Key key, this.arguments, this.position, this.id})
      : super(key: key);
  @override
  _ListImageState createState() => _ListImageState();
}

class _ListImageState extends State<ListImage>
    with SingleTickerProviderStateMixin {
  UpdateViewByIDBloc _updateViewByIDBloc = UpdateViewByIDBloc();
  // ItemScrollController itemScrollController = ItemScrollController();
  // ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  HistoryBloc _historyBloc = HistoryBloc();
  BackGroundColorsBloc _backGroundColorsBloc = BackGroundColorsBloc();
  String currentPosion;
  TransformationController _transformationController =
      TransformationController();
  ScrollController _bottomNavigationBar = ScrollController();
  bool _show = true;
  bool out_range = false;
  bool _isDisableBack = false;
  bool _isDisablePre = false;
  DefaultCacheManager _cacheManager = DefaultCacheManager();
  MovieEpisodeByIDBloc _movieEpisodeByIDBloc = MovieEpisodeByIDBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _updateViewByIDBloc.getMovies(widget.id);
    currentPosion = widget.position;
    _transformationController.value = Matrix4.identity();
    _movieEpisodeByIDBloc.getEpisode(widget.id, currentPosion);
    _historyBloc.setHistoryReading(widget.id + "_reading", widget.position);
    _checkButtonBack();
    _checkButtonPre();
    _myScrolling();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bottomNavigationBar.dispose();
    _cacheManager.emptyCache();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _backGroundColorsBloc.existBackGroundColors("checkcolor"),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
              backgroundColor: snapshot.data == false
                  ? Colors.white
                  : Style.ColorScreen.mainColor,
              bottomNavigationBar: _show == true
                  ? Container(
                      color: Style.ColorScreen.mainColor,
                      height: 60,
                      child: Center(
                        child: Row(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              child: IconButton(
                                  disabledColor: Colors.white12,
                                  icon: Icon(
                                    Icons.arrow_back_outlined,
                                    // color: Colors.white,
                                  ),
                                  color: Colors.white,
                                  iconSize: 50,
                                  onPressed: _isDisableBack == true
                                      ? null
                                      : () {
                                          if (out_range == false) {
                                            return showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  new AlertDialog(
                                                //title: new Text('Thoát ứng dụng'),
                                                content: new Text(
                                                    'Chương này chưa đọc xong, bạn chắc chắn muốn sang chương khác?'),
                                                actions: <Widget>[
                                                  FlatButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(false);
                                                        for (int i = 0;
                                                            i <
                                                                widget.arguments
                                                                    .length;
                                                            i++) {
                                                          if (widget.arguments[
                                                                  i]['title'] ==
                                                              currentPosion) {
                                                            if (i > 0) {
                                                              // _historyBloc
                                                              //     .deleteHistory(widget.id + "_reading");
                                                              _historyBloc.setHistoryReading(
                                                                  widget.id +
                                                                      "_reading",
                                                                  widget.arguments[
                                                                          i - 1]
                                                                      [
                                                                      'title']);
                                                              // _updateViewByIDBloc.getMovies(widget.id);
                                                              currentPosion =
                                                                  widget.arguments[
                                                                          i - 1]
                                                                      ['title'];

                                                              break;
                                                            }
                                                          }
                                                        }
                                                        // print(currentPosion);
                                                        //Navigator.of(context).pop(false);
                                                        out_range = false;
                                                        _bottomNavigationBar
                                                            .jumpTo(0);
                                                        _movieEpisodeByIDBloc
                                                            .getNull();
                                                        _movieEpisodeByIDBloc
                                                            .getEpisode(
                                                                widget.id,
                                                                currentPosion);
                                                        setState(() {});
                                                        _checkButtonBack();
                                                        _checkButtonPre();
                                                      },
                                                      child: Text('Có')),
                                                  FlatButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(false);
                                                      },
                                                      child: new Text('Không')),
                                                ],
                                              ),
                                            );
                                          } else {
                                            for (int i = 0;
                                                i < widget.arguments.length;
                                                i++) {
                                              if (widget.arguments[i]
                                                      ['title'] ==
                                                  currentPosion) {
                                                if (i > 0) {
                                                  // _historyBloc
                                                  //     .deleteHistory(widget.id + "_reading");
                                                  _historyBloc
                                                      .setHistoryReading(
                                                          widget.id +
                                                              "_reading",
                                                          widget.arguments[
                                                              i - 1]['title']);
                                                  // _updateViewByIDBloc.getMovies(widget.id);
                                                  currentPosion =
                                                      widget.arguments[i - 1]
                                                          ['title'];

                                                  break;
                                                }
                                              }
                                            }

                                            out_range = false;
                                            _bottomNavigationBar.jumpTo(0);
                                            _movieEpisodeByIDBloc.getNull();
                                            _movieEpisodeByIDBloc.getEpisode(
                                                widget.id, currentPosion);
                                            setState(() {});
                                            _checkButtonBack();
                                            _checkButtonPre();
                                          }
                                        }),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Center(
                                child: Text(
                                  "Chương " + currentPosion,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Center(
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.arrow_forward_outlined,
                                      ),
                                      color: Colors.white,
                                      disabledColor: Colors.white12,
                                      iconSize: 50,
                                      onPressed: _isDisablePre == true
                                          ? null
                                          : () {
                                              if (out_range == false) {
                                                return showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      new AlertDialog(
                                                    //title: new Text('Thoát ứng dụng'),
                                                    content: new Text(
                                                        'Chương này chưa đọc xong, bạn chắc chắn muốn sang chương khác?'),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                          onPressed: () {
                                                            for (int i = 0;
                                                                i <
                                                                    widget
                                                                        .arguments
                                                                        .length;
                                                                i++) {
                                                              if (widget.arguments[
                                                                          i][
                                                                      'title'] ==
                                                                  currentPosion) {
                                                                if (i <
                                                                    widget.arguments
                                                                            .length -
                                                                        1) {
                                                                  // _historyBloc
                                                                  // .deleteHistory(widget.id + "_reading");
                                                                  _historyBloc.setHistoryReading(
                                                                      widget.id +
                                                                          "_reading",
                                                                      widget.arguments[i +
                                                                              1]
                                                                          [
                                                                          'title']);

                                                                  currentPosion =
                                                                      widget.arguments[i +
                                                                              1]
                                                                          [
                                                                          'title'];

                                                                  break;
                                                                }
                                                              }
                                                            }

                                                            out_range = false;
                                                            _bottomNavigationBar
                                                                .jumpTo(0);
                                                            Navigator.of(
                                                                    context)
                                                                .pop(false);
                                                            _movieEpisodeByIDBloc
                                                                .getNull();
                                                            _movieEpisodeByIDBloc
                                                                .getEpisode(
                                                                    widget.id,
                                                                    currentPosion);
                                                            setState(() {});
                                                            _checkButtonBack();
                                                            _checkButtonPre();
                                                          },
                                                          child: Text('Có')),
                                                      FlatButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(false);
                                                          },
                                                          child: new Text(
                                                              'Không')),
                                                    ],
                                                  ),
                                                );
                                              } else {
                                                for (int i = 0;
                                                    i < widget.arguments.length;
                                                    i++) {
                                                  if (widget.arguments[i]
                                                          ['title'] ==
                                                      currentPosion) {
                                                    if (i <
                                                        widget.arguments
                                                                .length -
                                                            1) {
                                                      // _historyBloc
                                                      // .deleteHistory(widget.id + "_reading");
                                                      _historyBloc
                                                          .setHistoryReading(
                                                              widget.id +
                                                                  "_reading",
                                                              widget.arguments[
                                                                      i + 1]
                                                                  ['title']);

                                                      currentPosion = widget
                                                              .arguments[i + 1]
                                                          ['title'];

                                                      break;
                                                    }
                                                  }
                                                }

                                                out_range = false;
                                                _bottomNavigationBar.jumpTo(0);
                                                _movieEpisodeByIDBloc.getNull();
                                                _movieEpisodeByIDBloc
                                                    .getEpisode(widget.id,
                                                        currentPosion);
                                                setState(() {});
                                              }
                                              _checkButtonBack();
                                              _checkButtonPre();
                                            }),
                                ))
                          ],
                        ),
                      ))
                  : Container(
                      height: 0,
                    ),
              body: StreamBuilder(
                  stream: _movieEpisodeByIDBloc.getEpisodeStream(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data == "Error") {
                        return _buildError();
                      }
                      return GestureDetector(
                        onTap: () {
                          if (_show == true) {
                            _show = false;
                          } else {
                            _show = true;
                          }
                          setState(() {});
                        },
                        onDoubleTap: () {
                          if (_transformationController.value !=
                              Matrix4.identity()) {
                            _transformationController.value =
                                Matrix4.identity();
                            setState(() {});
                          }
                        },
                        child: InteractiveViewer(
                            transformationController: _transformationController,
                            panEnabled: true,
                            maxScale: 4,
                            minScale: 1,
                            child: _listImage(snapshot.data, currentPosion)),
                      );
                    } else {
                      return _buildLoading();
                    }
                  }));
        } else {
          return _buildLoading();
        }
      },
    );
  }

  Widget _listImage(argument, String s) {
    Widget list = Container();

    // print(argument[]);

    list = ListView.builder(
      controller: _bottomNavigationBar,
      physics: AlwaysScrollableScrollPhysics(),
      // scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: argument[0]['episode'][0]['url'].length,
      itemBuilder: (context, index) {
        return Container(
            //padding: EdgeInsets.fromLTRB(5, 2, 5, 2),

            child: OptimizedCacheImage(
                fit: BoxFit.fill,
                imageUrl: argument[0]['episode'][0]['url'][index],
                progressIndicatorBuilder: (context, url, progress) {
                  return Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: SizedBox(
                        height: 25,
                        width: 25,
                        child: CircularProgressIndicator(
                            value: progress.totalSize != null
                                ? progress.downloaded.toDouble() /
                                    progress.totalSize.toDouble()
                                : null),
                      ),
                    ),
                  );
                },
                errorWidget: (context, url, error) => Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: Center(child: Icon(Icons.error_outline)),
                    )));
      },
    );

    return list;
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
              valueColor: AlwaysStoppedAnimation(Colors.blue),
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
      child: ListView(
        controller: _bottomNavigationBar,
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2 -
                MediaQuery.of(context).size.height / 6,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Có lỗi xảy ra",
                  style: TextStyle(
                      height: 1.5,
                      color: Colors.black,

                      // fontWeight: FontWeight.bold,

                      fontSize: 20.0),
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  onPressed: () {
                    _movieEpisodeByIDBloc.getNull();

                    _movieEpisodeByIDBloc.getEpisode(widget.id, currentPosion);
                  },
                  child: Text("Thử lại"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _myScrolling() {
    _bottomNavigationBar.addListener(() {
      if (_bottomNavigationBar.offset >=
              _bottomNavigationBar.position.maxScrollExtent &&
          !_bottomNavigationBar.position.outOfRange) {
        if (out_range == false) {
          _updateViewByIDBloc.getMovies(widget.id);
        }
        _historyBloc.setHistoryReading(widget.id + "_" + currentPosion, "");
        setState(() {
          out_range = true;
        });
      }
      if (_bottomNavigationBar.position.userScrollDirection ==
          ScrollDirection.reverse) {
        _show = false;
        setState(() {});
      }
    });
  }

  _checkButtonBack() {
    for (int i = 0; i < widget.arguments.length; i++) {
      if (widget.arguments[i]['title'] == currentPosion) {
        if (i != 0) {
          _isDisableBack = false;
          setState(() {});
        } else {
          _isDisableBack = true;
          setState(() {});
        }
      }
    }
  }

  _checkButtonPre() {
    for (int i = 0; i < widget.arguments.length; i++) {
      if (widget.arguments[i]['title'] == currentPosion) {
        if (i != widget.arguments.length - 1) {
          _isDisablePre = false;
          setState(() {});
        } else {
          _isDisablePre = true;
        }
      }
    }
  }
}
