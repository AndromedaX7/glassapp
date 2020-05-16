import 'package:bleflutter/bleflutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassapp/app/scan/scan_bluetooth.dart';
import 'package:glassapp/app/scan/scan_wifi.dart';
import 'package:glassapp/local.dart';
import 'package:glassapp/viewmodel/home_provider.dart';

import '../../design.dart';

class HomeLayer0 extends StatefulWidget {
  final HomeProvider provider;

  HomeLayer0(this.provider);

  @override
  _HomeLayer0State createState() => _HomeLayer0State();
}

class _HomeLayer0State extends State<HomeLayer0> {
  @override
  void initState() {
    super.initState();
    Bleflutter.isBlueEnable().then((value) {
      if (!value) {
        Bleflutter.enableBluetooth().then((value) {
          Bleflutter.isBlueEnable().then((value) {
            if (value) {
              widget.provider.initConnect();
            } else {
              LocalChannel.toast("请打开蓝牙");
            }
          });
        });
      } else {
        widget.provider.initConnect();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          "images/bg1.png",
          width: dw(375),
          height: dw(291),
          fit: BoxFit.fill,
        ),
        Padding(
          padding: EdgeInsets.only(top: dw(8)),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: dw(16)),
                child: Text(
                  "眼镜状态",
                  style: TextStyle(
                    fontSize: sp(18),
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(right: dw(16)),
                child: GestureDetector(
                  child: Image.asset(
                    "images/Group 2.png",
                    width: dw(24),
                    height: dw(24),
                    fit: BoxFit.fill,
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(dw(16)),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Bleflutter.isBlueEnable().then((value) {
//                    widget.provider.bluetoothState = value?0:-1;
                    if (!value)
                      showDialog(
                          context: context,
                          builder: (c) => CupertinoAlertDialog(
                                content: Text("您的蓝牙未开启，开启绑定？"),
                                actions: [
                                  CupertinoDialogAction(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("取消"),
                                  ),
                                  CupertinoDialogAction(
                                    onPressed: () {
                                      Bleflutter.isBlueEnable().then((value) {
                                        if (value) Bleflutter.enableBluetooth();
                                      });

                                      Navigator.of(context).pop();
                                      Navigator.of(context).push(
                                          CupertinoPageRoute(
                                              builder: (c) =>
                                                  ScanBluetoothPage()));
                                    },
                                    child: Text("去设置"),
                                  ),
                                ],
                              ));
                    else {
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (c) => ScanBluetoothPage()));
                    }
                  });
                },
                child: Container(
                  width: dw(164),
                  height: dw(107),
                  child: Stack(
                    children: [
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: dw(52),
                          height: dw(37),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/lanya_1.png"),
                                fit: BoxFit.fill),
                          ),
                        ),
                      ),
                      Positioned(
                        left: dw(15),
                        top: dw(13),
                        child: Text(
                          "蓝牙状态",
                          style: TextStyle(
                              fontSize: sp(14), color: Color(0xff333333)),
                        ),
                      ),
                      Positioned(
                        left: dw(0),
                        top: dw(45),
                        child: Container(
                          width: dw(80),
                          padding: EdgeInsets.only(
                              left: dw(15), top: dw(4), bottom: dw(3)),
                          decoration: BoxDecoration(
                              color: Color(0x66FFFFFF),
                              borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(dw(1.5)))),
                          child: Row(
                            children: [
                              Text(
                                  "${widget.provider.bluetoothState == 0 ? "已开启" : widget.provider.bluetoothState == -1 ? "未开启" : "已连接"}",
                                  style: TextStyle(color: Color(0xff333333))),
                              Container(
                                width: dw(6),
                                height: dw(6),
                                margin: EdgeInsets.only(left: dw(6)),
                                decoration: BoxDecoration(
                                  color: Color(
                                      widget.provider.bluetoothState == 0
                                          ? Colors.yellow.value
                                          : widget.provider.bluetoothState == -1
                                              ? 0xffc8c8c8
                                              :  0xff71F242),
                                  borderRadius: BorderRadius.circular(dw(3)),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Color(0xffFFE9E6),
                      borderRadius: BorderRadius.all(Radius.circular(dw(8)))),
                ),
              ),
              SizedBox(
                width: dw(15),
              ),
              GestureDetector(
                onTap: () {
                  widget.provider.wlanState = !widget.provider.wlanState;
                  Navigator.of(context)
                      .push(CupertinoPageRoute(builder: (b) => ScanWifiPage()));
                },
                child: Container(
                  width: dw(164),
                  height: dw(107),
                  child: Stack(
                    children: [
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: dw(52),
                          height: dw(37),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/wifi_2.png"),
                                fit: BoxFit.fill),
                          ),
                        ),
                      ),
                      Positioned(
                        left: dw(15),
                        top: dw(13),
                        child: Text(
                          "网络状态",
                          style: TextStyle(
                              fontSize: sp(14), color: Color(0xff333333)),
                        ),
                      ),
                      Positioned(
                        left: dw(0),
                        top: dw(45),
                        child: Container(
                          width: dw(80),
                          padding: EdgeInsets.only(
                              left: dw(15), top: dw(4), bottom: dw(3)),
                          decoration: BoxDecoration(
                              color: Color(0x66FFFFFF),
                              borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(dw(1.5)))),
                          child: Row(
                            children: [
                              Text(
                                "${widget.provider.wlanState ? "已" : "未"}开启",
                                style: TextStyle(color: Color(0xff333333)),
                              ),
                              Container(
                                width: dw(6),
                                height: dw(6),
                                margin: EdgeInsets.only(left: dw(6)),
                                decoration: BoxDecoration(
                                  color: Color(widget.provider.wlanState
                                      ? 0xff71F242
                                      : 0xffC8C8C8),
                                  borderRadius: BorderRadius.circular(dw(3)),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Color(0xffF7EAD4),
                      borderRadius: BorderRadius.all(Radius.circular(dw(8)))),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: dw(16)),
          child: Row(
            children: [
              Container(
                width: dw(164),
                height: dw(107),
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: dw(52),
                        height: dw(37),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("images/dianchi_3.png"),
                              fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    Positioned(
                      left: dw(15),
                      top: dw(13),
                      child: Text(
                        "剩余电量",
                        style: TextStyle(
                            fontSize: sp(14), color: Color(0xff333333)),
                      ),
                    ),
                    Positioned(
                      left: dw(0),
                      top: dw(41),
                      child: Container(
                        width: dw(80),
                        padding: EdgeInsets.only(
                            left: dw(15), top: dw(4), bottom: dw(3)),
                        decoration: BoxDecoration(
                            color: Color(0x66FFFFFF),
                            borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(dw(1.5)))),
                        child: Row(
                          children: [
                            Text("${widget.provider.battery}%",
                                style: TextStyle(
                                    color: widget.provider.battery < 20
                                        ? Color(0xFFE60000)
                                        : Color(0xff333333),
                                    fontSize: sp(12))),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    color: Color(0xffE8F1F9),
                    borderRadius: BorderRadius.all(Radius.circular(dw(8)))),
              ),
              SizedBox(
                width: dw(15),
              ),
              Container(
                width: dw(164),
                height: dw(107),
                child: Stack(
                  children: [
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: dw(52),
                        height: dw(37),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("images/zaixianfuwu_4.png"),
                              fit: BoxFit.fill),
                        ),
                      ),
                    ),
                    Positioned(
                      left: dw(15),
                      top: dw(13),
                      child: Text(
                        "在线服务",
                        style: TextStyle(
                            fontSize: sp(14), color: Color(0xff333333)),
                      ),
                    ),
                    Positioned(
                      left: dw(0),
                      top: dw(41),
                      child: Container(
                        width: dw(80),
                        padding: EdgeInsets.only(
                            left: dw(15), top: dw(4), bottom: dw(3)),
                        decoration: BoxDecoration(
                            color: Color(0x66FFFFFF),
                            borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(dw(1.5)))),
                        child: Row(
                          children: [
                            Text(
                              "进入服务 >",
                              style: TextStyle(
                                  color: Color(0xff333333), fontSize: sp(12)),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    color: Color(0xffe1e1f4),
                    borderRadius: BorderRadius.all(Radius.circular(dw(8)))),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
