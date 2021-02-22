import 'package:MovieProject/widget/detail/detail_header.dart';
import 'package:MovieProject/widget/detail/detail_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:MovieProject/style/theme.dart' as Style;

class DetailScreen extends StatefulWidget {
  final dynamic obj;

  const DetailScreen({Key key, this.obj}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: PreferredSize(
      //     child: DetailWidget(
      //       obj: widget.obj,
      //     ),
      //     preferredSize: Size.fromHeight(220)),
      backgroundColor: Style.ColorScreen.mainColor,
      body: TabBarDetail(
        argument: widget.obj,
      ),
    );
  }
}
