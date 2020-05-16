import 'package:bleflutter/bleflutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassapp/base.dart';
import 'package:glassapp/design.dart';
import 'package:glassapp/viewmodel/scan_bluetooth_provider.dart';

class ScanBluetoothPage extends PageProviderNode<ScanBluetoothProvider> {
  @override
  Widget buildContent(BuildContext context) {
    return ScanBluetoothContentPage(mProvider);
  }

  ScanBluetoothPage();
}

class ScanBluetoothContentPage extends StatefulWidget {
  final ScanBluetoothProvider provider;

  ScanBluetoothContentPage(this.provider);

  @override
  _ScanBluetoothContentPageState createState() =>
      _ScanBluetoothContentPageState();
}

class _ScanBluetoothContentPageState extends State<ScanBluetoothContentPage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController _animationController;

  bool _loop = false;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation = Tween(begin: 0.0, end: 10.0).animate(_animationController);
    _animationController.repeat();
    Bleflutter.processCallback(widget.provider);
    _loop = true;
    _scanLoop();

    widget.provider.bindGlassList().listen((_) {});
  }

  void _scanLoop() async {
    await Future.delayed(Duration(seconds: 5)).then((value) {
      Bleflutter.scan();
    });

    while (_loop) {
      await Future.delayed(Duration(minutes: 1)).then((value) {
        Bleflutter.scan();
      });
    }
  }

  @override
  void dispose() {
    _loop = false;
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
                      "images/lanya.png",
                      height: dw(75),
                      width: dw(75),
                    ),
                  ],
                )),
            Positioned(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: buildMyDevices(),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.only(top: dw(15)),
                      sliver: SliverToBoxAdapter(
                        child: buildOtherDevices(),
                      ),
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
        middle: Text("绑定智能眼镜"),
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

  Widget buildMyDevices() {
    List<Widget> widgets = List();

    widgets.add(Container(
      color: Colors.white,
      width: dw(355),
      height: dw(30),
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: EdgeInsets.only(left: dw(20)),
        child: Text("我的设备"),
      ),
    ));

    if (widget.provider.myDevList != null) {
      widgets.add(GestureDetector(
        onTap: () {
          if (widget.provider.myDevList.state == -1) {
            Bleflutter.connect(widget.provider.myDevList.mac).then((value) {});
            widget.provider.myDevList.state = 0;
          } else {
            Bleflutter.disConnect(widget.provider.myDevList.mac);
            widget.provider.myDevList.state = -1;
          }

          setState(() {});
        },
        child: Container(
          width: dw(335),
          height: dw(56),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: dw(20), right: dw(9)),
                child: Image.asset(
                  "images/lianjie.png",
                  width: dw(17),
                  height: dw(9),
                ),
              ),
              Text(
                "${widget.provider.myDevList.name}",
                style: TextStyle(fontSize: sp(16), color: Color(0xff333333)),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(right: dw(32)),
                child: Text(
                    "${widget.provider.myDevList.state == 1 ? "已" : widget.provider.myDevList.state == -1 ? "未" : "正在"}连接"),
              )
            ],
          ),
        ),
      ));
    }

    widgets.add(Container(
      color: Colors.white,
      width: dw(355),
      height: dw(8),
      alignment: Alignment.bottomLeft,
    ));
    return Container(
      child: Card(
        child: Column(
          children: widgets,
        ),
      ),
    );
  }

  Widget buildOtherDevices() {
    List<Widget> widgets = List();

    widgets.add(
      Container(
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
      ),
    );

    for (int i = 0; i < widget.provider.devList.length; i++) {
      widgets.add(GestureDetector(
        onTap: () {
          if (widget.provider.devList[i].state == -1) {
            Bleflutter.connect(widget.provider.devList[i].mac).then((value) {

              if(widget.provider.caller.getString("device-mac")!=null){
                widget.provider.unbindGlass().listen((e){});
              }
              widget.provider
                  .bindGlass(widget.provider.devList[i])
                  .listen((e) {});
            });
            widget.provider.devList[i].state = 0;
          } else {
            Bleflutter.disConnect(widget.provider.devList[i].mac);
            widget.provider.devList[i].state = -1;
          }

          setState(() {});
        },
        child: Container(
          width: dw(335),
          height: dw(56),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: dw(20), right: dw(9)),
                child: Text(
                  "${widget.provider.devList[i].name} ${widget.provider.devList[i].mac}",
                  style: TextStyle(fontSize: sp(16), color: Color(0xff333333)),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(right: dw(32)),
                child: Text(
                    "${widget.provider.devList[i].state == 1 ? "已连接" : widget.provider.devList[i].state == -1 ? "未连接" : "正在连接"} "),
              )
            ],
          ),
        ),
      ));
    }
    widgets.add(Container(
      color: Colors.white,
      width: dw(355),
      height: dw(8),
      alignment: Alignment.bottomLeft,
    ));
    return Container(
      child: Card(
        child: Column(
          children: widgets,
        ),
      ),
    );
  }
}
