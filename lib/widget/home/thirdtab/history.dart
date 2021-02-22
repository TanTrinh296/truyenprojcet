import 'package:MovieProject/bloc/gethistory_bloc.dart';
import 'package:MovieProject/screen/detail_screen.dart';
import 'package:MovieProject/screen/listcomic_screen.dart';
import 'package:flutter/material.dart';
import 'package:MovieProject/style/theme.dart' as Style;

class HistoryWidget extends StatefulWidget {
  @override
  _HistoryWidgetState createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  HistoryBloc _historyBloc = HistoryBloc();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _historyBloc.getAllHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Style.ColorScreen.mainColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Style.ColorScreen.mainColor,
          title: Text("Lịch sử"),
          centerTitle: true,
        ),
        body: StreamBuilder(
            stream: _historyBloc.getMoviesStream(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                // print(snapshot.data);
                return _buildWidget(snapshot.data, context);
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

  Widget _buildWidget(data, BuildContext context) {
    List temp = data;
    List list = temp.reversed.toList();
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, int index) {
          return _buildItems(list[index]);
        });
  }

  Widget _buildItems(data) {
    return FutureBuilder(
        future: _historyBloc.getHistoryReading(data['_id'] + "_reading"),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Card(
              elevation: 8,
              child: Container(
                height: 150,
                color: Style.ColorScreen.mainColor,
                child: ListTile(
                  // contentPadding:
                  //     EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  subtitle: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 150,
                        child: GestureDetector(
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2)),
                                    shape: BoxShape.rectangle,
                                  ),
                                  child: 
                                  Image.network(data['imageurl'],
                                      fit: BoxFit.fill,
                                      errorBuilder: (context, obj, stacktrace) {
                                    return Container(
                                      child: Text(
                                        "Error",
                                      ),
                                    );
                                  }, loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent loading) {
                                    if (loading == null) return child;
                                    return Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 25,
                                            width: 25,
                                            child: CircularProgressIndicator(
                                              value: loading
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loading
                                                          .cumulativeBytesLoaded /
                                                      loading.expectedTotalBytes
                                                  : null,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  }
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailScreen(obj: data)));
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 90,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 220,
                                    child: Text(
                                      data['ten'],
                                      //maxLines: 10,
                                      textAlign: TextAlign.left,
                                      // overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        height: 1.4,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      child: Text(
                                    "Chương gần nhất: " +
                                        snapshot.data['title'],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15),
                                  )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              height: 30,
                              width: 220,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        Icons.delete_forever_outlined,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        return showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                content: new Text(
                                                  "Bạn chắc chắn muốn xóa lịch sử này?",
                                                ),
                                                actions: <Widget>[
                                                  FlatButton(
                                                      onPressed: () {
                                                        _historyBloc
                                                            .deleteHistory(
                                                                data['_id']);
                                                        _historyBloc
                                                            .getAllHistory();
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('Có')),
                                                  FlatButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: new Text('Không')),
                                                ],
                                              );
                                            });
                                      }),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  IconButton(
                                      icon: Icon(
                                        Icons.double_arrow,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        _historyBloc.deleteHistory(data['_id']);
                                        _historyBloc.setHistory(
                                            data['_id'], data);
                                        _historyBloc.getAllHistory();
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ListComicScreen(
                                                      arguments:
                                                          data['episode'],
                                                      position: snapshot
                                                          .data['title'],
                                                      id: data['_id'],
                                                    )));
                                      }),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return _buildLoading();
          }
        });
  }
}
