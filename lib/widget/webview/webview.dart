import 'dart:async';
import 'dart:io';
import 'package:MovieProject/style/theme.dart' as Style;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidget extends StatefulWidget {
  @override
  _WebViewWidgetState createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Style.ColorScreen.mainColor,
      //   title: Text("Tin tức Anime & Manga"),
      //   centerTitle: true,
      // ),
      body: WebView(
        initialUrl: "https://tinanime.com/tin-tuc",
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          _completer.complete(webViewController);
        },
        navigationDelegate: (NavigationRequest request) {
          if (!request.url.startsWith("https://tinanime.com/")) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
      floatingActionButton: FutureBuilder<WebViewController>(
          future: _completer.future,
          builder: (BuildContext context,
              AsyncSnapshot<WebViewController> controller) {
            if (controller.hasData) {
              return FloatingActionButton(
                  child: Icon(Icons.arrow_back),
                  onPressed: () {
                    controller.data.goBack();
                  });
            }
            return _buildLoading();
          }),
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
}
