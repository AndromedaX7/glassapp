
import 'package:flutter/material.dart';
import 'package:webviewopen/webview_platform.dart';

class CompanyInfoContentPage extends StatefulWidget {
  final String content;

  CompanyInfoContentPage(this.content);

  @override
  _CompanyInfoContentPageState createState() => _CompanyInfoContentPageState();
}

class _CompanyInfoContentPageState extends State<CompanyInfoContentPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("公司简介"),
      ),
      body: Builder(
        builder: (BuildContext c) {
          return WebViewWrapper(
            widget.content
          );
        },
      ),
    );
  }

}
