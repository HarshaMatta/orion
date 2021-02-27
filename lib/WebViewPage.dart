import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  WebViewPage({this.url});

  @override
  WebViewPageState createState() => WebViewPageState(url: url);
}

class WebViewPageState extends State<WebViewPage> {
  final String url;
  WebViewPageState({this.url});
  Completer<WebViewController> _controller = Completer<WebViewController>();

  Future<bool> webViewGoBack(BuildContext context) async {
    WebViewController controller = await _controller.future;
    if (await controller.canGoBack()) {
      controller.goBack();
      return true;
    } else {
      Navigator.pop(context);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(url),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.white,
              ),
              onPressed: null,
          ),
        ],
      ),

      body: WebView(
        initialUrl : url,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController){
          _controller.complete(webViewController);
        },
      ),
      floatingActionButton: FutureBuilder<WebViewController>(

        future: _controller.future,
          builder: (BuildContext context,
              AsyncSnapshot<WebViewController> controller) {
            if (controller.hasData) {
              return FloatingActionButton(
                  child: Icon(Icons.arrow_back),
                  onPressed: () => webViewGoBack(context)
                  );
              }
            return Container();
          }


      ),
    );
  }

}