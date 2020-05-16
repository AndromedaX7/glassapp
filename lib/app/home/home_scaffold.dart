import 'package:flutter/material.dart';
import 'package:glassapp/app/home/contact_page.dart';
import 'package:glassapp/app/home/feature_menu.dart';
import 'package:glassapp/app/home/home_page.dart';
import 'package:glassapp/base.dart';
import 'package:glassapp/local.dart';
import 'package:glassapp/viewmodel/home_provider.dart';

class HomeScaffold extends PageProviderNode<HomeProvider> {
  static BuildContext appContext;

  @override
  Widget buildContent(BuildContext context) {
    appContext = context;
    return HomeScaffoldContent(mProvider);
  }
}


class HomeScaffoldContent extends StatefulWidget {
  HomeScaffoldContent(this.provider);

  final HomeProvider provider;

  @override
  _HomeScaffoldContentState createState() => _HomeScaffoldContentState();
}

class _HomeScaffoldContentState extends State<HomeScaffoldContent> {
  int last;

  Future<bool> onWillPop()async {
    LocalChannel.finishSelf();
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        body: <Widget>[
          buildHomeMain(),
          buildMenuItem(),
          buildContact(),
        ][widget.provider.currentPosition],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: widget.provider.currentPosition,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset(widget.provider.currentPosition == 0
                  ? "images/teb_icon1.1.png"
                  : "images/teb_icon1.png"),
              //teb_icon2.2.png  teb_icon2.png teb_icon3.3.png teb_icon3.png
              title: Text("首页"),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(widget.provider.currentPosition == 1
                  ? "images/teb_icon2.2.png"
                  : "images/teb_icon2.png"),
              title: Text("更多"),
            ),
            BottomNavigationBarItem(
              icon: Image.asset(widget.provider.currentPosition == 2
                  ? "images/teb_icon3.3.png"
                  : "images/teb_icon3.png"),
              title: Text("联系人"),
            ),
          ],
          onTap: (pos) {
            widget.provider.currentPosition = pos;
          },
        ),
      ),
    );
  }

  Widget buildHomeMain() {
//    return HomeMainPage(widget.provider);
    return HomePage();
  }

  Widget buildMenuItem() {
    return FeatureMenuPage();
  }

  Widget buildContact() {
    return ContactPage();
  }

  void showOverlay(String toast) {
//    var overlayState = Overlay.of(context);
//    OverlayEntry entry =OverlayEntry(builder: (c)=>);

    LocalChannel.toast(toast);
  }
}
