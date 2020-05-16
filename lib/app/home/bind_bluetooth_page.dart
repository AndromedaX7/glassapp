import 'package:bleflutter/bleflutter.dart';
import 'package:flutter/material.dart';
import 'package:glassapp/app/scan/scan_bluetooth.dart';
import 'package:glassapp/base.dart';
import 'package:glassapp/design.dart';
import 'package:glassapp/viewmodel/scan_bluetooth_provider.dart';

class BindBlueToothPage extends PageProviderNode<ScanBluetoothProvider> {
  @override
  Widget buildContent(BuildContext context) {
    return BindBlueToothContentPage(mProvider);
  }
}

class BindBlueToothContentPage extends StatefulWidget {
  BindBlueToothContentPage(this.provider);

  final ScanBluetoothProvider provider;

  @override
  _BindBlueToothContentPageState createState() =>
      _BindBlueToothContentPageState();
}

class _BindBlueToothContentPageState extends State<BindBlueToothContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: dw(375),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: dw(85), bottom: dw(54)),
              child: Image.asset(
                "images/smartphone-111.png",
                width: dw(140),
                height: dw(140),
              ),
            ),
            Text(
              "您的蓝牙尚未开启",
              style: TextStyle(fontSize: sp(18)),
            ),
            Text(
              "开启权限，享受科技之旅",
              style: TextStyle(fontSize: sp(13)),
            ),
            Padding(
              padding: EdgeInsets.only(top: dw(164)),
              child: GestureDetector(
                onTap: () {
                  Bleflutter.isBlueEnable().then((value) {
                    if (!value) {
                      Bleflutter.enableBluetooth();
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                              builder: (c) => ScanBluetoothPage()))
                          .then((value) {});
                    }
                  });
                },
                child: Container(
                  width: dw(245),
                  height: dw(38),
                  child: Center(
                    child: Text(
                      "现在开启",
                      style: TextStyle(color: Colors.white, fontSize: sp(18)),
                    ),
                  ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Color(0xFF90C9EE), Color(0xFF1B87CD)])),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
