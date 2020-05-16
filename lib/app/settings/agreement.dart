import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassapp/base.dart';
import 'package:glassapp/viewmodel/agreement_provider.dart';
import 'package:webviewopen/webview_platform.dart';


class AgreementPage extends PageProviderNode<AgreementProvider> {
  @override
  Widget buildContent(BuildContext context) {
    return AgreementContentPage(mProvider);
  }
}

class AgreementContentPage extends StatefulWidget {
  AgreementContentPage(this.provider);

  final AgreementProvider provider;

  @override
  _AgreementContentPageState createState() => _AgreementContentPageState();
}

class _AgreementContentPageState extends State<AgreementContentPage> {
  @override
  void initState() {
    super.initState();
    widget.provider.loadContent().listen((r) {
      webView = WebViewWrapper(widget.provider.resultHtml);
    });
  }

  Widget webView=Center(
    child: CircularProgressIndicator(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("用户协议和隐私条款"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: webView,
      ),
    );
  }
}
