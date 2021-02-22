import 'package:MovieProject/bloc/getmovie_bloc.dart';
import 'package:MovieProject/screen/detail_screen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:MovieProject/bloc/getmovie_bloc.dart';
import 'package:MovieProject/style/theme.dart' as Style;

class ListMovieWidget extends StatefulWidget {
  final bool loading;

  const ListMovieWidget({Key key, this.loading}) : super(key: key);
  @override
  _ListMovieWidgetState createState() => _ListMovieWidgetState();
}

class _ListMovieWidgetState extends State<ListMovieWidget> {
  MovieBloc movieBloc = new MovieBloc();
  int _currentLength = 0;
  @override
  void initState() {
    movieBloc.getMovies();
    _currentLength = 12;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: movieBloc.getMoviesStream(),
        // ignore: missing_return
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return _buildMovie(snapshot.data);
          } else {
            return _buildLoading();
          }
        });
  }

  Widget _buildLoading() {
    return SliverToBoxAdapter(
        child: Center(
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
    ));
  }

  Widget _buildMovie(dynamic data) {
    return NotificationListener(
        // ignore: missing_return
        onNotification: (value) {
          if (value is ScrollUpdateNotification) {
            print(_currentLength);
          }
          if (value is ScrollEndNotification) {
            if (_currentLength + 12 < data.length) {
              _currentLength += 12;
              print(_currentLength);
              setState(() {});
            } else {
              _currentLength += (data.length - _currentLength);
              print(_currentLength);
              setState(() {});
            }
          }
        },
        child: SliverGrid.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height -
                  250 * MediaQuery.of(context).size.height / 760),
          children: _buildListWidget(data),
        ));
  }

  List<Widget> _buildListWidget(dynamic data) {
    print(MediaQuery.of(context).size.height);
    List<Widget> widgets = [];
    if (widget.loading == true) {
      if (_currentLength + 12 < data.length) {
        _currentLength += 12;
      } else {
        _currentLength += (data.length - _currentLength);
      }
    }
    for (int i = 0; i < _currentLength; i++) {
      widgets.add(
        Padding(
            padding: EdgeInsets.all(8),
            // EdgeInsets.only(top: 10, bottom: 10, right: 0, left: 7.5),
            child: GestureDetector(
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                          shape: BoxShape.rectangle,
                        ),
                        child:
                            Image.network(data[i]['imageurl'], fit: BoxFit.fill,
                                errorBuilder: (context, obj, stacktrace) {
                          return Container(
                            child: Text(
                              "Error",
                            ),
                          );
                        }, loadingBuilder: (BuildContext context, Widget child,
                                    ImageChunkEvent loading) {
                          if (loading == null) return child;
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(
                                    value: loading.expectedTotalBytes != null
                                        ? loading.cumulativeBytesLoaded /
                                            loading.expectedTotalBytes
                                        : null,
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [
                                  Style.ColorScreen.mainColor.withOpacity(1.0),
                                  Style.ColorScreen.mainColor.withOpacity(0.0)
                                ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                stops: [0.0, 0.4])),
                      ),
                      Positioned(
                        bottom: 5.0,
                        // height: MediaQuery.of(context).size.height *
                        //     (MediaQuery.of(context).size.width /
                        //         (MediaQuery.of(context).size.height -
                        //             500 *
                        //                 MediaQuery.of(context).size.width /
                        //                 MediaQuery.of(context).size.height)),
                        width: MediaQuery.of(context).size.width -
                            200 * (MediaQuery.of(context).size.width / 360),
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                data[i]['ten'].toString().toUpperCase(),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                softWrap: true,
                                style: TextStyle(
                                    height: 1.5,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
                  // SizedBox(height: 10),
                  // Container(
                  //   width: 100,
                  //   child: Text(
                  //     data[i]['ten'],
                  //     //maxLines: 10,
                  //     overflow: TextOverflow.ellipsis,
                  //     style: TextStyle(
                  //         height: 1.4,
                  //         color: Colors.white,
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 11),
                  //   ),
                  // )
                ],
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => DetailScreen(obj: data[i])));
              },
            )),
      );
    }
    return widgets;
  }
}
