import 'dart:async';
import 'dart:io';
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
  bool isLoading = true;

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
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  void onPageStarted(value) {
    setState(() {
      isLoading = true;
    });
  }

  void onPageFinished(value) {
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            WebView(
              initialUrl: url,
              javascriptMode: JavascriptMode.unrestricted,
              onPageStarted: onPageStarted,
              onPageFinished: onPageFinished,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
            ),
            isLoading ? Center(child: CircularProgressIndicator(),)
                : Stack(),
          ],
        ),
        bottom: false,
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