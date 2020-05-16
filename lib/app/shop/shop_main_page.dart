import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassapp/app/shop/shop_home_page.dart';
import 'package:glassapp/design.dart';
import 'package:glassapp/local.dart';

class ShopMainContentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: dw(16)),
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: dh(80),
              ),
              GestureDetector(
                onTap: () {
                   Navigator.of(context).push(MaterialPageRoute(
                       builder: (b) => ShopHomePage(
                             taobao: false,
                           )));

                },
                child: Image.asset(
                  "images/ic_shop_self.png",
                  width: dw(342),
                  height: dh(230),
                  fit: BoxFit.fill,
                ),
              ),
              GestureDetector(
                onTap: () {
                   Navigator.of(context).push(MaterialPageRoute(
                       builder: (b) => ShopHomePage(
                         taobao: true,
                       )));
                },
                child: Image.asset(
                  "images/ic_shop_taobao.png",
                  width: dw(342),
                  height: dh(230),
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          Positioned(
            child: BackButton(),
            left: dw(16),
            top: dw(32),
          )
        ]),
      ),
    );
  }
}
