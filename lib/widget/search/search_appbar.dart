import 'package:MovieProject/bloc/getmovie_bloc.dart';
import 'package:MovieProject/screen/detail_screen.dart';
import 'package:MovieProject/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:MovieProject/style/theme.dart' as Style;
import 'package:nice_button/nice_button.dart';

class SearchWidget extends StatefulWidget {
  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget>
    with TickerProviderStateMixin {
  MovieBloc _bloc = MovieBloc();
  TextEditingController _seachController = TextEditingController();
  Widget initWidget;
  String search = "";
  String _choose = "Theo ngày cập nhật";
  List<String> _listChoose = ["Theo ngày cập nhật", "Theo lượt xem"];
  Map<String, bool> _listTheLoai = {
    "Action": false,
    "Adventure": false,
    "Chuyển Sinh": false,
    "Comedy": false,
    "Cổ Đại": false,
    "Drama": false,
    "Fantasy": false,
    "Harem": false,
    "Historical": false,
    "Manga": false,
    "Manhua": false,
    "Manhwa": false,
    "Martirial Arts": false,
    "Mecha": false,
    "Mystery": false,
    "Ngôn Tình": false,
    "Psychological": false,
    "Romance": false,
    "School Life": false,
    "Seinen": false,
    "Shoujo": false,
    "Shounen": false,
    "Slice of Life": false,
    "Supernatural": false,
    "Truyện Màu": false,
    "Xuyên Không": false
  };
  Map<String, bool> _temp = {
    "Action": false,
    "Adventure": false,
    "Chuyển Sinh": false,
    "Comedy": false,
    "Cổ Đại": false,
    "Drama": false,
    "Fantasy": false,
    "Harem": false,
    "Historical": false,
    "Manga": false,
    "Manhua": false,
    "Manhwa": false,
    "Martirial Arts": false,
    "Mecha": false,
    "Mystery": false,
    "Ngôn Tình": false,
    "Psychological": false,
    "Romance": false,
    "School Life": false,
    "Seinen": false,
    "Shoujo": false,
    "Shounen": false,
    "Slice of Life": false,
    "Supernatural": false,
    "Truyện Màu": false,
    "Xuyên Không": false
  };
  List<String> _searchListTemp = [];
  List<String> _searchList = [];
  bool _checkIconDropDown = false;
  bool _checkSortByView = false;
  bool _checkButtonSearch = false;
  int _currentLength = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc.getMovies();
    _currentLength = 12;
    // initWidget = Center(
    //   child: Container(
    //     child: Text(
    //       "Trống",
    //       style: TextStyle(color: Colors.white),
    //     ),
    //   ),
    // );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _seachController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Style.ColorScreen.mainColor,
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          backgroundColor: Style.ColorScreen.mainColor,
          title: TextField(
            controller: _seachController,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            onChanged: (text) {
              search = _seachController.text;
              _searchList = [];
              if (_choose == "Theo ngày cập nhật") {
                _bloc.getNullByView();
                _bloc.getNull();
                _bloc.getMovies();
              } else {
                _bloc.getNull();
                _bloc.getNullByView();
                _bloc.getMoviesByView();
              }
              setState(() {});
            },
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
                hintText: "Nhập tên để tìm kiếm",
                hintStyle: TextStyle(color: Colors.white)),
          ),
        ),
        endDrawer: Drawer(
          child: Container(
              color: Style.ColorScreen.mainColor,
              child: Column(
                children: [
                  Container(
                    height: 75,
                    width: double.infinity,
                    child: Center(
                      child: Text("Tìm kiếm nâng cao",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.white,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height - 152,
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                // height: 50,
                                width: double.infinity,
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                        padding: EdgeInsets.only(left: 20),
                                        height: 50,
                                        // color: Colors.white,
                                        width: double.infinity,
                                        child: DropdownButtonFormField(
                                            style:
                                                TextStyle(color: Colors.white),
                                            dropdownColor:
                                                Style.ColorScreen.mainColor,
                                            //iconEnabledColor: Colors.white,
                                            value: _choose,
                                            items: _listChoose
                                                .map((e) => DropdownMenuItem(
                                                      child: Text(e,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          )),
                                                      value: e,
                                                    ))
                                                .toList(),
                                            onChanged: (String value) {
                                              setState(() {
                                                this._choose = value;
                                              });
                                            }))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SliverAppBar(
                          floating: false,
                          pinned: true,
                          snap: false,
                          automaticallyImplyLeading: false,
                          // centerTitle: true,
                          actions: [
                            Container(
                              padding: EdgeInsets.only(bottom: 15),
                              child: Center(
                                child: IconButton(
                                    icon: Icon(
                                      _checkIconDropDown == false
                                          ? Icons.arrow_right
                                          : Icons.arrow_drop_down_sharp,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                                    onPressed: () {
                                      _checkIconDropDown = !_checkIconDropDown;
                                      setState(() {});
                                    }),
                              ),
                            )
                          ],
                          title: Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Text("Thể loại",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold)),
                          ),
                          backgroundColor: Style.ColorScreen.mainColor,
                        ),
                        SliverList(
                            delegate: SliverChildListDelegate(
                                _checkIconDropDown == false
                                    ? []
                                    : _listTheLoai.keys
                                        .map((e) => Container(
                                              height: 50,
                                              child: CheckboxListTile(
                                                title: Text(e,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    )),
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .leading,
                                                value: _listTheLoai[e],
                                                onChanged: (value) {
                                                  if (value == true) {
                                                    _searchListTemp.add(e);
                                                  } else {
                                                    _searchListTemp.remove(e);
                                                  }
                                                  _listTheLoai[e] = value;
                                                  setState(() {});
                                                },
                                                activeColor:
                                                    Style.ColorScreen.mainColor,
                                                checkColor: Colors.white,
                                              ),
                                            ))
                                        .toList()))
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.white,
                  ),
                  Container(
                    height: 75,
                    // color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FlatButton(
                            onPressed: () {
                              _seachController.text = "";
                              search = _seachController.text;
                              // _checkButtonSearch = true;
                              _searchList = [];
                              _searchListTemp.forEach((element) {
                                _searchList.add(element);
                              });
                              if (_choose == "Theo ngày cập nhật") {
                                _checkSortByView = false;
                                _bloc.getNullByView();
                                _bloc.getNull();
                                _bloc.getMovies();
                              } else {
                                _checkSortByView = true;
                                _bloc.getNull();
                                _bloc.getNullByView();
                                _bloc.getMoviesByView();
                              }
                              _currentLength = 12;
                              Navigator.of(context).pop();
                              setState(() {});
                            },
                            child: Container(
                              height: 50,
                              width: 100,
                              child: Center(
                                child: Text("Tìm",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    )),
                              ),
                            )),
                        FlatButton(
                            onPressed: () {
                              _listTheLoai = _temp;
                              _choose = "Theo ngày cập nhật";
                              // _searchList = [];
                              _searchListTemp = [];
                              setState(() {});
                            },
                            child: Container(
                              height: 50,
                              width: 100,
                              child: Center(
                                child: Text("Mặc định",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    )),
                              ),
                            ))
                      ],
                    ),
                  )
                ],
              )),
        ),
        body: StreamBuilder(
            stream: _checkSortByView == false
                ? _bloc.getMoviesStream()
                : _bloc.getMoviesByViewStream(),
            builder: (context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                // print(snapshot.data);
                if (snapshot.data == "Error") {
                  return _buildError();
                }
                return NotificationListener(
                    onNotification: (v) {
                      if (v is ScrollEndNotification) {
                        if (_currentLength + 12 < snapshot.data.length) {
                          _currentLength += 12;
                        } else {
                          _currentLength +=
                              (snapshot.data.length - _currentLength);
                        }
                        Future.delayed(
                            const Duration(seconds: 1), () => setState(() {}));
                        // print("End");
                      }
                    },
                    child: _buildListWidget(snapshot.data, search));
              } else {
                return _buildLoading();
              }
            }));
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
                if (_choose == "Theo ngày cập nhật") {
                  // _bloc.getNullByView();
                  _bloc.getNull();
                  _bloc.getMovies();
                } else {
                  // _bloc.getNull();
                  _bloc.getNullByView();
                  _bloc.getMoviesByView();
                }
              },
              child: Text("Thử lại"),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildListWidget(dynamic data, String search) {
    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: MediaQuery.of(context).size.width /
          (MediaQuery.of(context).size.height + 50),
      children: _buildList(data, search),
    );
  }

  List<Widget> _buildList(dynamic data, String search) {
    List<Widget> widgets = [];
    List list = data as List;
    List temp = list
        .where((element) => element['ten']
            .toString()
            .toUpperCase()
            .contains(search.toUpperCase()))
        .toList();
    if (search == "") {
      if (_searchList.isNotEmpty) {
        List<Widget> listtemp = [];
        for (var i = 0; i < temp.length; i++) {
          if (_checkListInsideList(temp[i]['theloai'] as List, _searchList)) {
            listtemp.add(
              Padding(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
                  child: GestureDetector(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            // width: 120,
                            // height: 180,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2)),
                              shape: BoxShape.rectangle,
                            ),
                            child: Image.network(temp[i]['imageurl'],
                                fit: BoxFit.fitHeight,
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
                                        value: loading.expectedTotalBytes !=
                                                null
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
                            temp[i]['ten'].toUpperCase(),
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailScreen(obj: temp[i])));
                    },
                  )),
            );
            widgets = [];
            for (var i = 0; i < _currentLength; i++) {
              if (i < listtemp.length) {
                widgets.add(listtemp[i]);
              }
            }
          }
        }
      } else {
        for (var i = 0; i < _currentLength; i++) {
          if (_checkListInsideList(temp[i]['theloai'] as List, _searchList)) {
            widgets.add(
              Padding(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
                  child: GestureDetector(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            // width: 120,
                            // height: 180,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2)),
                              shape: BoxShape.rectangle,
                            ),
                            child: Image.network(temp[i]['imageurl'],
                                fit: BoxFit.fitHeight,
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
                                        value: loading.expectedTotalBytes !=
                                                null
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
                            temp[i]['ten'],
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DetailScreen(obj: temp[i])));
                    },
                  )),
            );
          }
        }
      }
    } else {
      for (var i = 0; i < temp.length; i++) {
        if (_checkListInsideList(temp[i]['theloai'] as List, _searchList)) {
          widgets.add(
            Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
                child: GestureDetector(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          // width: 120,
                          // height: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(2)),
                            shape: BoxShape.rectangle,
                          ),
                          child: Image.network(temp[i]['imageurl'],
                              fit: BoxFit.fitHeight,
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
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: 100,
                        child: Text(
                          temp[i]['ten'],
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DetailScreen(obj: temp[i])));
                  },
                )),
          );
        }
      }
    }

    return widgets;
  }

  _checkListInsideList(List listFarther, List listChild) {
    if (listChild.every((element) => listFarther.contains(element))) {
      return true;
    } else {
      return false;
    }
  }
}
