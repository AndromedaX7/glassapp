import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:glassapp/design.dart';
import 'package:glassapp/utils/log.dart';

class AddAddressPage extends StatefulWidget {
  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text("收货地址"),
          actions: <Widget>[
            GestureDetector(
              child: Center(child: Text("保存")),
            ),
            SizedBox(
              width: dw(16),
            )
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: dw(15)),
                height: dh(35),
                alignment: Alignment.centerLeft,
                child: Text(
                  "地址信息",
                  style: TextStyle(color: Colors.black),
                ),
                color: Color(0xffebebeb),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: dw(15)),
                child: TextField(
                  decoration: InputDecoration(hintText: "收货人姓名"),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: dw(15)),
                child: TextField(
                  decoration: InputDecoration(hintText: "手机号码"),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                     horizontal: dw(15)),
                width: double.infinity,
                child: GestureDetector(
                  onTap: () async {
                    Result result = await CityPickers.showCityPicker(
                      context: context,
                    );
                    Log.v(result.areaName+result.cityName+result.provinceName);
                  },
                  child: Container(
                    color: Color(0xfffafafa),
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: dh(10),),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "所在地区",
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: dw(15),
                ),
                height: 1,
                color: Color(0xffaaaaaa),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal:dw(15)),
                child: TextField(
                  decoration: InputDecoration(hintText: "详细地址"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//TextField()
//TextField(),
//Text(""),
//
