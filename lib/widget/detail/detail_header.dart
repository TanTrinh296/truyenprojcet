import 'package:flutter/material.dart';
import 'package:MovieProject/style/theme.dart' as Style;
import 'package:page_indicator/page_indicator.dart';

class DetailWidget extends StatefulWidget {
  final dynamic obj;

  const DetailWidget({Key key, this.obj}) : super(key: key);
  @override
  _DetailWidgetState createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  @override
  Widget build(BuildContext context) {
   // print(widget.obj);
    return Container(
      height: 220,
      child: Stack(children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: 220,
          child: Image.network(
            widget.obj['paper'],
            fit: BoxFit.cover,
            errorBuilder: (context, obj, stacktrace) {
              return Container(
                child: Text(
                  "Error",
                ),
              );
            },
            loadingBuilder:
                (BuildContext context, Widget child, ImageChunkEvent loading) {
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
            },
          ),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
          ),
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
                  stops: [0.0, 1.2])),
        ),
      ]),
    );
  }
}
