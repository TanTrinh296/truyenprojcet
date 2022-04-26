import 'dart:async';
import 'dart:math';

import 'package:MovieProject/bloc/getmovie_bloc.dart';
import 'package:MovieProject/bloc/getmovietitle_bloc.dart';
import 'package:MovieProject/model/movie.dart';
import 'package:MovieProject/model/movietitle.dart';
import 'package:MovieProject/model/movietitle_response.dart';
import 'package:MovieProject/screen/detail_screen.dart';
import 'package:dart_random_choice/dart_random_choice.dart';
import 'package:flutter/material.dart';
import 'package:MovieProject/bloc/getmovietitle_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:optimized_cached_image/optimized_cached_image.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:MovieProject/style/theme.dart' as Style;

class MovieTitleWidget extends StatefulWidget {
  @override
  _MovieTitleWidgetState createState() => _MovieTitleWidgetState();
}

class _MovieTitleWidgetState extends State<MovieTitleWidget> {
  // MovieTitleBloc movieTitleBloc = new MovieTitleBloc();
  MovieBloc _movieBloc = MovieBloc();
  int _currentPage = 0;
  PageController _pagecontroller = PageController(initialPage: 0);
  Timer timer;
  @override
  void initState() {
    // movieTitleBloc.getMovies();
    //_movieBloc.getMovies();
    super.initState();
    _movieBloc.getMoviesRandom();
    timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 4) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pagecontroller.animateToPage(_currentPage,
          duration: Duration(milliseconds: 400), curve: Curves.easeIn);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child: Text("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",style: TextStyle(color: Colors.white),),
    // );
    return StreamBuilder(
        stream: _movieBloc.getMoviesRandomStream(),
        // ignore: missing_return
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            return _buildMovieTile(snapshot.data);
          } else {
            return _buildLoading();
          }
        });
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

  Widget _buildMovieTile(dynamic data) {
    List _listRandom = data as List;
    if (_listRandom.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[Text("No Movie")],
        ),
      );
    } else {
      return Container(
        height: 220,
        child: PageIndicatorContainer(
            shape: IndicatorShape.circle(size: 5.0),
            align: IndicatorAlign.bottom,
            indicatorSpace: 8.0,
            padding: EdgeInsets.all(5.0),
            indicatorColor: Style.ColorScreen.secondColor,
            child: PageView.builder(
                //allowImplicitScrolling: true,
                //pageSnapping: true,
                controller: _pagecontroller,
                scrollDirection: Axis.horizontal,
                itemCount: _listRandom.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              DetailScreen(obj: _listRandom[index])));
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 220,
                          child:
                              //  OptimizedCacheImage(
                              //   fit: BoxFit.cover,
                              //   imageUrl: _listRandom[index]["paper"],
                              //   progressIndicatorBuilder: (context, url, progress) {
                              //     return Container(
                              //       height: 300,
                              //       width: MediaQuery.of(context).size.width,
                              //       child: Center(
                              //         child: SizedBox(
                              //           height: 25,
                              //           width: 25,
                              //           child: CircularProgressIndicator(
                              //               value: progress.totalSize != null
                              //                   ? progress.downloaded.toDouble() /
                              //                       progress.totalSize.toDouble()
                              //                   : null),
                              //         ),
                              //       ),
                              //     );
                              //   },
                              //   errorWidget: (context, url, error) =>
                              //       Icon(Icons.error),
                              // ),
                              Image.network(_listRandom[index]["paper"],
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, obj, stacktrace) {
                            return Container(
                              child: Text(
                                "Error",
                              ),
                            );
                          }, loadingBuilder: (BuildContext context,
                                      Widget child, ImageChunkEvent loading) {
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
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Style.ColorScreen.mainColor
                                        .withOpacity(1.0),
                                    Style.ColorScreen.mainColor.withOpacity(0.0)
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  stops: [0.0, 0.9])),
                        ),
                        Positioned(
                          bottom: 20.0,
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 10.0),
                            width: 400.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  _listRandom[index]["ten"]
                                      .toString()
                                      .toUpperCase(),
                                  style: TextStyle(
                                      height: 1.5,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
            length: _listRandom.length),
      );
    }
  }
}
