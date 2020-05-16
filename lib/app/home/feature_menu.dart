import 'package:flutter/material.dart';
import 'package:glassapp/app/advert/advert.dart';
import 'package:glassapp/app/room/room_list.dart';
import 'package:glassapp/app/shop/shop_main_page.dart';
import 'package:glassapp/app/user/online_service_page.dart';
import 'package:glassapp/base.dart';
import 'package:glassapp/design.dart';
import 'package:glassapp/local.dart';
import 'package:glassapp/viewmodel/feature_menu_provider.dart';

class FeatureMenuPage extends PageProviderNode<FeatureMenuProvider> {
  FeatureMenuPage() : super(params: []);

  @override
  Widget buildContent(BuildContext context) {
    return FeatureMenuContentPage(mProvider);
  }
}

class FeatureMenuContentPage extends StatefulWidget {
  FeatureMenuContentPage(this.provider);

  final FeatureMenuProvider provider;

  @override
  _FeatureMenuContentPageState createState() => _FeatureMenuContentPageState();
}

class _FeatureMenuContentPageState extends State<FeatureMenuContentPage> {
  List<String> assets = [
    "images/ic_online.png",
    "images/ic_shop.png",
    "images/ic_audio_book.png",
    "images/ic_message.png",
    "images/ic_ads.png"
  ];
  List<String> itemName = ["在线服务", "购物商城", "有声书城", "语音聊天室", "广告精品区"];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView.builder(
          itemBuilder: (c, p) => _buildItem(c, p),
          itemCount: 5,
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int pos) {
    return GestureDetector(
      onTap: () {
        switch (pos) {
          case 0:
            Navigator.of(context).push(
                MaterialPageRoute(builder: (c) => OnLineServiceContentPage()));
            break;
          case 1:
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (c) => ShopMainContentPage()));
            break;
          case 2:
            LocalChannel.launchPlatform("book");
            break;
          case 3:
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (c) => RoomListPage()));
            break;
          case 4:
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (c) => AdvertPage()));
            break;
        }
      },
      child: Container(
        width: double.infinity,
        height: dh(90),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/ic_more_menu_bar.png"),
                fit: BoxFit.fill)),
        padding: EdgeInsets.symmetric(horizontal: 40),
//      color: Colors.black,

        child: Container(
          alignment: Alignment.centerLeft,
          height: dh(55),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: dw(30),
                height: dh(27),
                child: Image.asset(
                  assets[pos],
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(
                height: dh(10),
              ),
              Text("${itemName[pos]}")
            ],
          ),
        ),
      ),
    );
  }
}
