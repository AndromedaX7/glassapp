import 'package:bleflutter/bleflutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glassapp/app/home/bind_bluetooth_page.dart';
import 'package:glassapp/app/scan/scan_bluetooth.dart';
import 'package:glassapp/base.dart';
import 'package:glassapp/design.dart';
import 'package:glassapp/viewmodel/home_provider.dart';
import 'package:marquee_flutter/marquee_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import 'home_layer0.dart';

class HomePage extends PageProviderNode<HomeProvider> {
  static BuildContext appContext;

  @override
  Widget buildContent(BuildContext context) {
    appContext = context;
    bool bind = mProvider.caller.getBool("bind", false) ?? false;
    return HomeContentPage(mProvider, bind);
  }
}

class HomeContentPage extends StatefulWidget {
  final HomeProvider provider;
  final bool bind;

  HomeContentPage(this.provider, this.bind);

  @override
  _HomeContentPageState createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<HomeContentPage>
    with SingleTickerProviderStateMixin {
  PageController _pageController;
  static const platform = const MethodChannel("glass_app");

  Animation<double> animation;
  AnimationController _animationController;
  static const List pagePos = [
    {"name": "读书模式", "ic": "dushu", "hide": "dushu1", "desc": "可以准确为您读出书里的内容"},
    {
      "name": "识钞模式",
      "ic": "shichao",
      "hide": "shichao1",
      "desc": "可以准确为您识别钱币面值"
    },
    {"name": "识人模式", "ic": "shiren", "hide": "shiren1", "desc": "可以准确为您识别出联系人"},
    {"name": "读书模式", "ic": "dushu", "hide": "dushu1", "desc": "可以准确为您读出书里的内容"},
  ];

  @override
  void initState() {
    super.initState();
    widget.provider.bluetoothProvider.bindGlassList().listen((_) {
      widget.provider.bind = widget.provider.caller.getBool("bind", false);
    });
    _pageController = PageController(viewportFraction: 0.41);
    _pageController.addListener(() {});
    _animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = Tween(begin: 0.0, end: 196.0).animate(_animationController);
    _animationController.repeat();
    loadLocation();
    widget.provider.scanBindDevice();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }
  Future<bool> _requestPop() {
    Bleflutter.disConnect(widget.provider.bluetoothProvider.myDevList.mac);
    return new Future.value(true);
  }
  @override
  Widget build(BuildContext context) {
    initDisplay(context);
    return WillPopScope( onWillPop:_requestPop ,
      child: Scaffold(
        body: widget.bind ? buildBind() : buildUnbind(),
      ),
    );
  }

  Widget buildUnbind() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: dw(55), bottom: dw(34)),
            child: Container(
              width: dw(198),
              height: dw(198),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: dw(40),
                    height: dw(40),
                    decoration: BoxDecoration(
                        color: Color(0xffc8c8c8),
                        borderRadius: BorderRadius.circular(dw(40))),
                  ),
                  AnimatedBuilder(
                    builder: (bc, child) {
                      return Container(
                        width: animation.value,
                        height: animation.value,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: widget.provider
                                .getAnimColor(animation.value ?? 0),
                            width: dw(30),
                          ),
                          borderRadius:
                              BorderRadius.circular(dw(animation.value ?? 0)),
                        ),
                      );
                    },
                    animation: animation,
                  ),
                  AnimatedBuilder(
                    builder: (bc, child) {
                      return Container(
                        width: getAnimValue(1, animation.value),
                        height: getAnimValue(1, animation.value),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: widget.provider.getAnimColor(
                                getAnimValue(1, animation.value) ?? 0),
                            width: dw(30),
                          ),
                          borderRadius: BorderRadius.circular(
                              dw(getAnimValue(1, animation.value) ?? 0)),
                        ),
                      );
                    },
                    animation: animation,
                  ),
                  AnimatedBuilder(
                    builder: (bc, child) {
                      return Container(
                        width: getAnimValue(2, animation.value),
                        height: getAnimValue(2, animation.value),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: widget.provider.getAnimColor(
                                getAnimValue(2, animation.value) ?? 0),
                            width: dw(30),
                          ),
                          borderRadius: BorderRadius.circular(
                              dw(getAnimValue(2, animation.value) ?? 0)),
                        ),
                      );
                    },
                    animation: animation,
                  ),
                  AnimatedBuilder(
                    builder: (bc, child) {
                      return Container(
                        width: getAnimValue(3, animation.value),
                        height: getAnimValue(3, animation.value),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: widget.provider.getAnimColor(
                                getAnimValue(3, animation.value) ?? 0),
                            width: dw(30),
                          ),
                          borderRadius: BorderRadius.circular(
                              dw(getAnimValue(3, animation.value) ?? 0)),
                        ),
                      );
                    },
                    animation: animation,
                  ),
                  Image.asset(
                    "images/yangjing.png",
                    width: dw(192),
                    height: dw(192),
                  ),
                ],
              ),
            ),
          ),
          Text(
            "您尚未绑定智能眼镜",
            style: TextStyle(fontSize: sp(18)),
          ),
          Padding(
            padding: EdgeInsets.only(top: dw(11)),
            child: Text(
              """ 绑定后，可使用
            【识人模式】、【场景模式】、【读书模式】、
            【异地视野同步】,【识钞模式】等功能""",
              textAlign: TextAlign.center,
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              _animationController.stop();
              Bleflutter.isBlueEnable().then((value) {
                if (value) {
//                  widget.provider.bind = true;

                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (c) => ScanBluetoothPage()));
                } else {
                  Navigator.of(context)
                      .push(MaterialPageRoute(
                          builder: (c) => BindBlueToothPage()))
                      .then((value) {
                    if (value != null && value) {
                      widget.provider.bind = true;
                    } else {
                      _animationController.repeat();
                    }
                  });
                }
              });
            },
            child: Container(
              width: dw(245),
              height: dw(38),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff90C9EE), Color(0xff1B87CD)],
                ),
              ),
              child: Center(
                child: Text(
                  "绑定智能眼镜",
                  style: TextStyle(fontSize: sp(18), color: Colors.white),
                ),
              ),
            ),
          ),
          SizedBox(
            height: dw(30),
          ),
          GestureDetector(
            child: Container(
              width: dw(136),
              height: dw(32),
              decoration: BoxDecoration(
                  border: Border.all(color: Color(0xff208ACF)),
                  borderRadius: BorderRadius.all(Radius.circular(dw(8)))),
              child: Center(
                child: Text(
                  "使用帮助",
                  style: TextStyle(color: Color(0xff208ACF)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: dw(61),
          ),
        ],
      ),
    );
  }

  Widget buildBind() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [HomeLayer0(widget.provider), buildBindLayer1()],
      ),
    );
  }

  Widget buildBindLayer1() {
    return Container(
      width: dw(375),
      height: dw(312),
      child: Column(children: [
        Padding(
          padding: EdgeInsets.only(top: dw(40), left: dw(20), right: dw(20)),
          child: Row(
            children: [
              Image.asset(
                "images/icon_loation.png",
                width: dw(16),
                height: dw(18),
              ),
              Container(
                margin: EdgeInsets.only(left: dw(8)),
                width: dw(180),
                height: dw(24),
                child: MarqueeWidget(
                  text: "${widget.provider.location}",
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: sp(16),
                  ),
                  scrollAxis: Axis.horizontal,
                ),
              ),
              Spacer(),
              Text(
                "${widget.provider.city}  ${widget.provider.text} ${widget.provider.temperature}°c",
                style: TextStyle(color: Colors.white, fontSize: sp(14)),
              )
            ],
          ),
        ),
        Container(
          height: dw(124),
          margin: EdgeInsets.only(top: dw(34), left: dw(20), right: dw(20)),
          child: PageView.custom(
            childrenDelegate: SliverChildListDelegate([
              _buildPageItem(0),
              _buildPageItem(1),
              _buildPageItem(2),
              _buildPageItem(3)
            ]),
            controller: _pageController,
            onPageChanged: (pos) {
              widget.provider.page = pos;
            },
          ),
        ),
        Text(
          //
          pagePos[widget.provider.page]['desc'],
          style: TextStyle(fontSize: sp(14), color: Color(0xFFCCCCCC)),
        )
      ]),
    );
  }

  Widget _buildPageItem(int pos) {
    return Container(
      width: dw(110),
      height: dw(124),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: dw(pos == widget.provider.page ? 0 : 45 / 2)),
            width: dw(pos == widget.provider.page ? 90 : 45),
            height: dw(pos == widget.provider.page ? 90 : 45),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(dw(45)),
              gradient: LinearGradient(
                colors: pos == widget.provider.page
                    ? [Color(0xFF90C9EE), Color(0xFF1B87CD)]
                    : [Color(0x8890C9EE), Color(0x881B87CD)],
              ),
            ),
            child: Center(
              child: Opacity(
                opacity: pos == widget.provider.page ? 1 : 0.5,
                child: Image.asset(pos == widget.provider.page
                    ? "images/${pagePos[pos]['ic']}.png"
                    : "images/${pagePos[pos]['hide']}.png"),
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: dw(pos == widget.provider.page ? 10 : 6)),
            child: Text(
              "${pagePos[pos]['name']}",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: sp(dw(pos == widget.provider.page ? 18 : 13))),
            ),
          )
        ],
      ),
    );
  }

  void loadLocation() async {
    if (await Permission.location.request().isGranted) {
      Map<dynamic, dynamic> map = await platform.invokeMethod("location");
      widget.provider.location = map['location'];
      widget.provider.city = map['city'];
    }
  }

  double getAnimValue(int i, value) {
    double res = value + (i * 49);
    if (res > 196) {
      res = res - 196;
    }
    return res;
  }
}
