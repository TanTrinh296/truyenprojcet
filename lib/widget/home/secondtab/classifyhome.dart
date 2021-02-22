import 'package:MovieProject/bloc/getmovie_bloc.dart';
import 'package:MovieProject/screen/detail_screen.dart';
import 'package:MovieProject/widget/search/search_appbar.dart';
import 'package:flutter/material.dart';
import 'package:MovieProject/style/theme.dart' as Style;

class ClassifyHome extends StatefulWidget {
  @override
  _ClassifyHomeState createState() => _ClassifyHomeState();
}

class _ClassifyHomeState extends State<ClassifyHome>
    with TickerProviderStateMixin {
  MovieBloc _movieBloc = MovieBloc();
  TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 14, vsync: this);
    _movieBloc.getMovies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 10,
        child: Scaffold(
          backgroundColor: Style.ColorScreen.mainColor,
          appBar: PreferredSize(
              child: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Style.ColorScreen.mainColor,
                title: Text("Phân loại"),
                centerTitle: true,
                actions: [
                  IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SearchWidget()));
                      })
                ],
                bottom: TabBar(
                  tabs: [
                    Text('Manga'),
                    Text('Manhua'),
                    Text('Comedy'),
                    Text('Romance'),
                    Text('Adventure'),
                    Text('School Life'),
                    Text('Fantasy'),
                    Text('Shounen'),
                    Text('Drama'),
                    Text('Action'),
                    Text('Historical'),
                    Text('Chuyển Sinh'),
                    Text('Xuyên Không'),
                    Text('Harem')
                  ],
                  controller: _tabController,
                  indicatorColor: Style.ColorScreen.secondColor,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 5.0,
                  unselectedLabelColor: Style.ColorScreen.titleColor,
                  labelColor: Colors.white,
                  isScrollable: true,
                ),
              ),
              preferredSize: Size.fromHeight(80)),
          body: StreamBuilder(
              stream: _movieBloc.getMoviesStream(),
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == "Error") {
                    return _buildError();
                  }
                  // print(snapshot.data);
                  return buildWidget(snapshot.data, context);
                } else {
                  return _buildLoading();
                }
              }),
        ));
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
                _movieBloc.getNull();
                _movieBloc.getMovies();
              },
              child: Text("Thử lại"),
            )
          ],
        ),
      ),
    );
  }

  Widget buildWidget(data, context) {
    return TabBarView(controller: _tabController, children: [
      buildTabBarView(data, "Manga", context),
      buildTabBarView(data, "Manhua", context),
      buildTabBarView(data, "Comedy", context),
      buildTabBarView(data, "Romance", context),
      buildTabBarView(data, "Adventure", context),
      buildTabBarView(data, "School Life", context),
      buildTabBarView(data, "Fantasy", context),
      buildTabBarView(data, "Shounen", context),
      buildTabBarView(data, "Drama", context),
      buildTabBarView(data, "Action", context),
      buildTabBarView(data, "Historical", context),
      buildTabBarView(data, "Chuyển Sinh", context),
      buildTabBarView(data, "Xuyên Không", context),
      buildTabBarView(data, "Harem", context)
    ]);
  }

  Widget buildTabBarView(data, String s, context) {
    return GridView.count(
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: MediaQuery.of(context).size.width /
          (MediaQuery.of(context).size.height + 50),
      children: buildListWidget(data, s, context),
    );
  }
}

List<Widget> buildListWidget(data, String s, context) {
  List<Widget> widgets = [];
  for (var item in data) {
    if (item['theloai'].toString().contains(s)) {
      widgets.add(
        Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
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
                      child:
                          Image.network(item['imageurl'], fit: BoxFit.fitHeight,
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
                      item['ten'].toString().toUpperCase(),
                      maxLines: 1,
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
                    builder: (context) => DetailScreen(obj: item)));
              },
            )),
      );
    }
    ;
  }
  return widgets;
}
