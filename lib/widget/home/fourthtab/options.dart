import 'package:MovieProject/bloc/getpreferencebackgroundcolors_bloc.dart';
import 'package:flutter/material.dart';
import 'package:MovieProject/style/theme.dart' as Style;
import 'package:url_launcher/url_launcher.dart';

class OptionsWidget extends StatefulWidget {
  @override
  _OptionsWidgetState createState() => _OptionsWidgetState();
}

class _OptionsWidgetState extends State<OptionsWidget> {
  // bool enableDarkMode = true;
  BackGroundColorsBloc _backGroundColorsBloc = BackGroundColorsBloc();
  bool _enableBackGroundColor;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.ColorScreen.mainColor,
        title: Text("Cài đặt"),
        centerTitle: true,
      ),
      body: Container(
        color: Style.ColorScreen.mainColor,
        child: FutureBuilder(
          future: _backGroundColorsBloc.existBackGroundColors("checkcolor"),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              // ignore: unrelated_type_equality_checks
              return _buildWidget(snapshot.data);
            } else {
              return _buildLoading();
            }
          },
        ),
      ),
    );
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

  Widget _buildWidget(data) {
    return ListView(
      children: [
        Card(
            margin: EdgeInsets.all(10),
            color: Style.ColorScreen.mainColor,
            // elevation: 8.0,
            child: SwitchListTile(
              secondary: Icon(Icons.colorize, color: Colors.white),
              title: Text(
                "Màu nền",
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                data == false ? "Trắng" : "Đen",
                style: TextStyle(color: Colors.white60),
              ),
              value: data,
              onChanged: (v) {
                // _enableBackGroundColor = !_enableBackGroundColor;
                if (data == true) {
                  _backGroundColorsBloc.deleteBackGroundColors("checkcolor");
                } else {
                  _backGroundColorsBloc.setBackGroundColors("checkcolor", "On");
                }
                _backGroundColorsBloc.existBackGroundColors("checkcolor");
                setState(() {});
              },
            )),
        Card(
          margin: EdgeInsets.all(10),
          color: Style.ColorScreen.mainColor,
          child: ListTile(
            onTap: () async {
              String mailto = "wigaret@gmail.com";
              String subject = 'Góp ý';
              var email = 'mailto:$mailto?subject=$subject';
              await launch(email);
            },
            leading: Icon(
              Icons.contact_mail,
              color: Colors.white,
            ),
            title: Text(
              "Liên hệ",
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              "Góp ý qua gmail",
              style: TextStyle(color: Colors.white60),
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.all(10),
          color: Style.ColorScreen.mainColor,
          child: ListTile(
            leading: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            title: Text(
              "Clean cache",
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              "Giải phóng cache hình ảnh",
              style: TextStyle(color: Colors.white60),
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.all(10),
          color: Style.ColorScreen.mainColor,
          child: ListTile(
            leading: Icon(
              Icons.rate_review,
              color: Colors.white,
            ),
            title: Text(
              "Đánh giá ứng dụng",
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              "Đánh giá ứng dụng qua CHPlay",
              style: TextStyle(color: Colors.white60),
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.all(10),
          color: Style.ColorScreen.mainColor,
          child: ListTile(
            onTap: () {
              return showDialog(
                  context: context,
                  child: Dialog(
                    child: Container(
                        height:
                            350 * (MediaQuery.of(context).size.height / 760),
                        child: ListView(
                          children: [
                            SizedBox(
                              height: 20 *
                                  (MediaQuery.of(context).size.height / 760),
                            ),
                            ListTile(
                              title: Text(
                                "Hình ảnh trang mở đầu",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                  "Pinterest: https://ar.pinterest.com/pin/692076667716298441/\nhttps://i.pinimg.com/originals/69/ba/79/69ba7915d638b86e48242b181ce57ea2.jpg"),
                            ),
                            ListTile(
                              title: Text(
                                "Trang tin tức",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text("https://tinanime.com/tin-tuc"),
                            ),
                            ListTile(
                              title: Text(
                                "Dữ liệu hình ảnh",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text("https://truyentranh24.com/"),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: Text(
                                      'Tắt',
                                      style: TextStyle(color: Colors.blue),
                                    )),
                              ],
                            ),
                          ],
                        )),
                  ));
            },
            leading: Icon(
              Icons.insert_link,
              color: Colors.white,
            ),
            title: Text(
              "Nguồn",
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              "Nguồn tài nguyên sử dụng cho ứng dụng",
              style: TextStyle(color: Colors.white60),
            ),
          ),
        ),
        Card(
          margin: EdgeInsets.all(10),
          color: Style.ColorScreen.mainColor,
          child: ListTile(
            leading: Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
            title: Text(
              "Thông tin ứng dụng",
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              "Phiên bản: 1.0.1",
              style: TextStyle(color: Colors.white60),
            ),
          ),
        ),
      ],
    );
  }
}
