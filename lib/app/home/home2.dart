import 'package:flutter/material.dart';
import 'package:glassapp/design.dart';
import 'package:glassapp/app/guardianship/add_bind_person.dart';
import 'package:glassapp/app/settings/settings.dart';
import 'package:glassapp/utils/network_model.dart';
import 'package:glassapp/base.dart';
import 'package:glassapp/viewmodel/home_provider.dart';
import 'package:glassapp/widgets.dart';

class HomePage2 extends PageProviderNode<HomeProvider> {
  @override
  Widget buildContent(BuildContext context) {
    return Home2ContentPage(mProvider);
  }
}

class Home2ContentPage extends StatefulWidget {
  Home2ContentPage(this.provider);

  final HomeProvider provider;

  @override
  _Home2ContentPageState createState() => _Home2ContentPageState();
}

class _Home2ContentPageState extends State<Home2ContentPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [buildHome(), buildSettings()][widget.provider.currentPosition],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("首页")),
          BottomNavigationBarItem(icon: Icon(Icons.settings), title: Text("设置"))
        ],
        onTap: (i) {
          widget.provider.currentPosition = i;
        },
        currentIndex: widget.provider.currentPosition,
      ),
    );
  }

  Widget buildHome() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: dh(56), left: dh(16), bottom: dh(35)),
            child: Text(
              "我的关联人",
              style: TextStyle(fontSize: sp(21), color: Colors.black),
            ),
          ),
          Expanded(
            child: EmptyWidgetWrapper(
             child: ListView.builder(
                itemBuilder: (bc, p) => _buildItem(p),
                itemCount: widget.provider.mGuardianList.length,
              ),
              data:widget.provider.mGuardianList,
              placeHolder: buildEmpty(),
            ),
          )
        ],
      ),
    );
  }

  Widget buildEmpty() {
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: dh(20)),
            child: Image.asset(
              "images/ic_header2.png",
              width: dh(135),
              height: dh(135),
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: dh(45), bottom: dh(55)),
            child: Text(
              "*添加关联人后，即可使用实时异地视野和SOS功能。",
              style: TextStyle(fontSize: sp(12), color: Color(0xfff95065)),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (c) => AddBindPerson()))
                  .then((value) {
                if (value) {
                  widget.provider.guardianList().listen((event) {});
                }
              });
            },
            child: Container(
              width: dh(310),
              height: dh(50),
              child: Center(
                child: Text(
                  "添加关联人",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              decoration: BoxDecoration(
                  color: Color(0xff575DFF),
                  borderRadius: BorderRadius.all(Radius.circular(dh(4)))),
            ),
          )
        ],
      ),
    );
  }

  Widget buildSettings() {
    return SettingsPage("设置");
  }

  Widget _buildItem(int pos) {
    var data = widget.provider.mGuardianList[pos];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: dw(15)),
      height: dh(60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: dh(34),
            height: dh(34),
            child: CircleAvatar(
              backgroundImage:
                  NetworkImage("$serverUrl${data.userInfo.avatar}"),
            ),
          ),
//          Image.network(
//            ,
//            width: dw(34),
//            height: dh(34),
//          ),
          SizedBox(
            width: dw(20),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(data.userInfo.realName),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: dh(1),
                    color: Color(0xffdddddd),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
