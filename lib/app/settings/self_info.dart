import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassapp/base.dart';
import 'package:glassapp/design.dart';
import 'package:glassapp/viewmodel/self_info_provider.dart';
class SelfInfoPage extends PageProviderNode<SelfInfoProvider> {
  @override
  Widget buildContent(BuildContext context) {
    return SelfInfoContentPage(mProvider);
  }
}

class SelfInfoContentPage extends StatefulWidget {
  SelfInfoContentPage(this.provider);

  final SelfInfoProvider provider;

  @override
  _SelfInfoContentPageState createState() => _SelfInfoContentPageState();
}

class _SelfInfoContentPageState extends State<SelfInfoContentPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: widget.provider.appThemes.appbar,
            title: Text(
              "个人资料",
              style:
                  TextStyle(color: widget.provider.appThemes.appbarTextColor),
            ),
            centerTitle: true,
            actions: <Widget>[
              FlatButton(
                  onPressed: null,
                  child: Text(
                    "完成",
                    style: TextStyle(color: Colors.redAccent),
                  )),
            ]),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: dw(16)),
                width: dw(375),
                height: dh(75),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("头像"),
                    Flexible(
                      child: Container(),
                      fit: FlexFit.tight,
                    ),
                    Container(
                      height: dh(55),
                      width: dh(55),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(widget.provider.myIcon),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: dw(375),
                height: dh(1),
                color: widget.provider.appThemes.divider,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: dw(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("昵称"),
                    Flexible(
                      child: Container(),
                      fit: FlexFit.tight,
                    ),
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      fit: FlexFit.tight,
                    ),
                  ],
                ),
                width: dw(375),
                height: dh(50),
              ),
              Container(
                width: dw(375),
                height: dh(1),
                color: widget.provider.appThemes.divider,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
