import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassapp/base.dart';
import 'package:glassapp/design.dart';
import 'package:glassapp/viewmodel/scan_wifi_provider.dart';

class ScanWifiPage extends PageProviderNode<ScanWifiProvider> {
  @override
  Widget buildContent(BuildContext context) {
    return ScanWifiContentPage(mProvider);
  }

  ScanWifiPage();
}

class ScanWifiContentPage extends StatefulWidget {
  final ScanWifiProvider provider;

  ScanWifiContentPage(this.provider);

  @override
  _ScanWifiContentPageState createState() => _ScanWifiContentPageState();
}

class _ScanWifiContentPageState extends State<ScanWifiContentPage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation = Tween(begin: 0.0, end: 10.0).animate(_animationController);
    _animationController.repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        child: Stack(
          children: [
            Container(
                width: dw(375),
                height: dw(190),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF90C9EE), Color(0xFF1B87CD)],
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedBuilder(
                      builder: (bc, child) {
                        return Container(
                          width: dw(67 + animation.value),
                          height: dw(67 + animation.value),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: widget.provider
                                  .getAnimColor(0, animation.value ?? 0),
                              width: dw(6),
                            ),
                            borderRadius: BorderRadius.circular(
                                dw(67 + animation.value ?? 0)),
                          ),
                        );
                      },
                      animation: animation,
                    ),
                    AnimatedBuilder(
                      builder: (bc, child) {
                        return Container(
                          width: dw(79 + animation.value),
                          height: dw(79 + animation.value),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: widget.provider
                                  .getAnimColor(1, animation.value ?? 0),
                              width: dw(6),
                            ),
                            borderRadius: BorderRadius.circular(
                                dw(79 + animation.value ?? 0)),
                          ),
                        );
                      },
                      animation: animation,
                    ),
                    AnimatedBuilder(
                      builder: (bc, child) {
                        return Container(
                          width: dw(91 + animation.value),
                          height: dw(91 + animation.value),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: widget.provider
                                  .getAnimColor(2, animation.value ?? 0),
                              width: dw(6),
                            ),
                            borderRadius: BorderRadius.circular(
                                dw(91 + animation.value ?? 0)),
                          ),
                        );
                      },
                      animation: animation,
                    ),
                    AnimatedBuilder(
                      builder: (bc, child) {
                        return Container(
                          width: dw(103 + animation.value),
                          height: dw(103 + animation.value),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: widget.provider
                                  .getAnimColor(3, animation.value ?? 0),
                              width: dw(6),
                            ),
                            borderRadius: BorderRadius.circular(
                                dw(103 + animation.value ?? 0)),
                          ),
                        );
                      },
                      animation: animation,
                    ),
                    Image.asset(
                      "images/wifidayuanicon.png",
                      height: dw(75),
                      width: dw(75),
                    ),
                  ],
                )),
            Positioned(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: buildMyWifiDevices(),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.only(top: dw(15)),
                      sliver:
                          SliverToBoxAdapter(child: buildOtherWifiDevices()),
                    )
                  ],
                ),
                left: dw(20),
                right: dw(20),
                bottom: dw(20),
                top: dw(148)),
          ],
        ),
      ),
      appBar: CupertinoNavigationBar(
        middle: Text( "WIFI连接" ),
      ),
    );
  }

  double getAnimValue(int i, value) {
    double res = value + (i * 20);
//    if (res > 30) {
//      res = res - 115;
//    }
    return res;
  }


  Widget buildMyWifiDevices() {
    List<Widget> widgets = List();

    widgets.add(Container(
      width: dw(355),
      height: dw(30),
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: EdgeInsets.only(left: dw(20)),
        child: Text("我的网络"),
      ),
    ));

    for (int i = 0; i < widget.provider.devices; i++) {
      widgets.add(Container(
        width: dw(335),
        height: dw(56),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: dw(20), right: dw(9)),
              child: Text(
                "AEWR000002",
                style: TextStyle(fontSize: sp(16), color: Color(0xff333333)),
              ),
            ),
            Spacer(),
            Text(
              "已连接",
              style: TextStyle(fontSize: sp(16), color: Color(0xff333333)),
            ),
            Padding(
              padding: EdgeInsets.only(right: dw(32), left: dw(4)),
              child: Image.asset(
                "images/wifi_01.png",
                width: dw(18),
                height: dw(18),
              ),
            )
          ],
        ),
      ));
    }

    return Container(
      child: Card(
        child: Column(
          children: widgets,
        ),
      ),
    );
  }

  Widget buildOtherWifiDevices() {
    List<Widget> widgets = List();

    widgets.add(Container(
      width: dw(355),
      height: dw(30),
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: EdgeInsets.only(left: dw(20)),
        child: Row(
          children: [
            Text("发现设备"),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(right: dw(32)),
              child: CupertinoActivityIndicator(
                radius: dw(8),
              ),
            )
          ],
        ),
      ),
    ));

    for (int i = 0; i < widget.provider.otherDevices; i++) {
      widgets.add(Container(
        width: dw(335),
        height: dw(56),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: dw(20), right: dw(9)),
              child: Text(
                "AEWR000002",
                style: TextStyle(fontSize: sp(16), color: Color(0xff333333)),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(right: dw(32)),
              child: Image.asset(
                "images/wifi_02.png",
                width: dw(18),
                height: dw(18),
              ),
            )
          ],
        ),
      ));
    }

    return Container(
      child: Card(
        child: Column(
          children: widgets,
        ),
      ),
    );
  }
}
