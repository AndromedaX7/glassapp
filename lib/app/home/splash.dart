import 'package:flutter/material.dart';
import 'package:glassapp/app/home/contact_page.dart';
import 'package:glassapp/app/home/feature_menu.dart';
import 'package:glassapp/app/home/home2.dart';
import 'package:glassapp/app/home/home_scaffold.dart';
import 'package:glassapp/app/user/login_page.dart';
import 'package:glassapp/app/user/online_service_page.dart';
import 'package:glassapp/app/user/register_page.dart';
import 'package:glassapp/base.dart';
import 'package:glassapp/design.dart';
import 'package:glassapp/viewmodel/home_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashPage extends PageProviderNode<HomeProvider> {
  SplashPage() : super(params: []);
  static BuildContext appContext;

  @override
  Widget buildContent(BuildContext context) {
    appContext = context;
    return SplashContentPage(mProvider);
  }
}

class SplashContentPage extends StatefulWidget {
  final HomeProvider provider;

  SplashContentPage(this.provider);

  @override
  _SplashContentPageState createState() => _SplashContentPageState();
}

class _SplashContentPageState extends State<SplashContentPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    initDisplay(context);
    return Material(
        child: <Widget>[
      buildLogin(),
      buildRegister(),
      HomeScaffold(),
      buildHome2()
    ][widget.provider.userState]);
  }

  /* Widget buildHome() {
    return Scaffold(
      body: <Widget>[
        buildHomeMain(),
        buildMenuItem(),
        buildContact(),
      ][widget.provider.currentPosition],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.provider.currentPosition,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("首页"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            title: Text("更多"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("联系人"),
          ),
        ],
        onTap: (pos) {
          widget.provider.currentPosition = pos;
        },
      ),
    );
  }*/

  Widget buildLogin() {
    return LoginPage(widget.provider);
  }

  Widget buildRegister() {
    return RegisterPage(widget.provider);
  }

  Widget buildHomeMain() {
    return HomeMainPage(widget.provider);
  }

  Widget buildMenuItem() {
    return FeatureMenuPage();
  }

  Widget buildContact() {
    return ContactPage();
  }

  Widget buildHome2() {
    return HomePage2();
  }
}

class HomeMainPage extends StatefulWidget {
  HomeMainPage(this.provider);

  final HomeProvider provider;

  @override
  _HomeMainPageState createState() => _HomeMainPageState();
}

class _HomeMainPageState extends State<HomeMainPage> {
  @override
  void initState() {
    super.initState();
    requestLocation();
  }

  void requestLocation() async {
    if (await Permission.location.request().isGranted) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: dh(46),
          ),
          Image.asset(
            "images/cw0.png",
            width: dw(86),
            height: dh(70),
          ),
          SizedBox(
            height: dh(8),
          ),
          Text(
            "-27℃大雪",
            style: TextStyle(fontSize: sp(16), color: Color(0xff565dff)),
          ),
          Container(
            padding: EdgeInsets.only(left: dw(20), right: dw(16)),
            width: dw(348),
            height: dh(30),
            child: Row(
              children: <Widget>[
                Image.asset(
                  "images/ic_glass.png",
                  width: dw(40),
                  height: dh(20),
                ),
                Flexible(
                  child: Container(),
                  fit: FlexFit.tight,
                ),
                Container(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (c) => OnLineServiceContentPage()));
                    },
                    child: Image.asset(
                      "images/ic_help.png",
                      width: dw(28),
                      height: dh(28),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: dh(4),
          ),
          Container(
            width: dw(348),
            height: dh(148),
            child: Card(
              color: Color(0xff565dff),
              child: Column(
                children: <Widget>[
                  Container(
                    height: dh(58),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: dw(16),
                        ),
                        Image.asset(
                          "images/ic_service.png",
                          width: dw(36),
                          height: dh(36),
                        ),
                        SizedBox(
                          width: dw(10),
                        ),
                        Text(
                          "在线服务",
                          style:
                              TextStyle(color: Colors.white, fontSize: sp(16)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: dw(305),
                    height: dh(1),
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: dh(18),
                  ),
                  Container(
                    height: dh(20),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: dw(24),
                        ),
                        Image.asset(
                          "images/ic_bettry.png",
                          width: dw(20),
                          height: dh(20),
                        ),
                        SizedBox(
                          width: dw(10),
                        ),
                        Text(
                          "眼镜剩余电量：70%",
                          style:
                              TextStyle(color: Colors.white, fontSize: sp(14)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: dh(12),
                  ),
                  Container(
                    height: dh(20),
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: dw(24),
                        ),
                        Image.asset(
                          "images/ic_location.png",
                          width: dw(20),
                          height: dh(20),
                        ),
                        SizedBox(
                          width: dw(10),
                        ),
                        Text(
                          "位置：长春市朝阳区",
                          style:
                              TextStyle(color: Colors.white, fontSize: sp(14)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: dw(348),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (c, p) => _buildGridItem(),
              itemCount: 6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem() {
    return Container(
      height: dh(123),
      child: Card(
          color: Colors.white,
          shadowColor: Color(0xff565dff),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: dw(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: dw(24),
                  height: dh(24),
                  child: Image.asset("images/ic_ads.png"),
                ),
                SizedBox(
                  height: dh(16),
                ),
                Text("识人模式"),
              ],
            ),
          )),
    );
  }
}
