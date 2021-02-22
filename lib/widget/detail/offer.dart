import 'dart:math';

import 'package:MovieProject/bloc/getmovie_bloc.dart';
import 'package:MovieProject/screen/detail_screen.dart';
import 'package:flutter/material.dart';

class OfferWidget extends StatefulWidget {
  @override
  _OfferWidgetState createState() => _OfferWidgetState();
}

class _OfferWidgetState extends State<OfferWidget> {
  MovieBloc _movieBloc = MovieBloc();
  @override
  void initState() {
    _movieBloc.getMoviesRandom(); // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _movieBloc.getMoviesRandomStream(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return _buildData(snapshot.data, context);
          } else {
            return _buildLoading();
          }
        });
  }

  Widget _buildData(dynamic data, BuildContext context) {
    var _listRandom = data as List;
    return _buildWidget(_listRandom, context);
  }

  Widget _buildWidget(data, BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: data.length,
        itemBuilder: (context, int index) {
          // return Container(child: Text(data[index]["ten"]),);
          return Padding(
              padding:
                  EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
              child: GestureDetector(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        width: 100,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                          shape: BoxShape.rectangle,
                        ),
                        child: Image.network(data[index]['imageurl'],
                            fit: BoxFit.fill,
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
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 100,
                      child: Text(
                        data[index]['ten'],
                        //maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            height: 1.4,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11),
                      ),
                    )
                  ],
                ),
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => DetailScreen(obj: data[index])));
                },
              ));
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

  // List<Widget> _buildListWidget(data) {
  //   List<Widget> widgets = [];
  //   for (var item in data) {
  //     widgets.add(
  //       Padding(
  //           padding: EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
  //           child: GestureDetector(
  //             child: Column(
  //               children: <Widget>[
  //                 Expanded(
  //                   child: Container(
  //                     // width: 120,
  //                     // height: 180,
  //                     decoration: BoxDecoration(
  //                       borderRadius: BorderRadius.all(Radius.circular(2)),
  //                       shape: BoxShape.rectangle,
  //                     ),
  //                     child:
  //                         Image.network(item['imageurl'], fit: BoxFit.fitHeight,
  //                             errorBuilder: (context, obj, stacktrace) {
  //                       return Container(
  //                         child: Text(
  //                           "Error",
  //                         ),
  //                       );
  //                     }, loadingBuilder: (BuildContext context, Widget child,
  //                                 ImageChunkEvent loading) {
  //                       if (loading == null) return child;
  //                       return Center(
  //                         child: Column(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           children: <Widget>[
  //                             SizedBox(
  //                               height: 25,
  //                               width: 25,
  //                               child: CircularProgressIndicator(
  //                                 value: loading.expectedTotalBytes != null
  //                                     ? loading.cumulativeBytesLoaded /
  //                                         loading.expectedTotalBytes
  //                                     : null,
  //                               ),
  //                             )
  //                           ],
  //                         ),
  //                       );
  //                     }),
  //                   ),
  //                 ),
  //                 SizedBox(height: 10),
  //                 Container(
  //                   width: 100,
  //                   child: Text(
  //                     item['ten'],
  //                     //maxLines: 10,
  //                     overflow: TextOverflow.ellipsis,
  //                     style: TextStyle(
  //                         height: 1.4,
  //                         color: Colors.white,
  //                         fontWeight: FontWeight.bold,
  //                         fontSize: 11),
  //                   ),
  //                 )
  //               ],
  //             ),
  //             onTap: () {
  //               Navigator.of(context).push(MaterialPageRoute(
  //                   builder: (context) => DetailScreen(obj: item)));
  //             },
  //           )),
  //     );
  //   }
  //   return widgets;
  // }
}
