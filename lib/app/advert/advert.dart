import 'package:flutter/material.dart';
import 'package:glassapp/base.dart';
import 'package:glassapp/design.dart';
import 'package:glassapp/local.dart';
import 'package:glassapp/viewmodel/advert_provider.dart';
import 'package:glassapp/widgets.dart';

class AdvertPage extends PageProviderNode<AdvertProvider> {
  @override
  Widget buildContent(BuildContext context) {
    return AdvertContentPage(mProvider);
  }
}

class AdvertContentPage extends StatefulWidget {
  AdvertContentPage(this.provider);

  final AdvertProvider provider;

  @override
  _AdvertContentPageState createState() => _AdvertContentPageState();
}

class _AdvertContentPageState extends State<AdvertContentPage> {
  @override
  void initState() {
    super.initState();
    widget.provider.loadAdvertList().listen((event) {
      if (widget.provider.adList.length > 0) {
        LocalChannel.audioPlay(widget.provider.adList[0].fileUrl);
      }
    });
  }

  Future<bool> onPop() async {
    LocalChannel.stopCurrent();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold( 
          body: RefreshIndicator(
              child: EmptyWidgetWrapper(data: widget.provider.adList,
                child: PageView.builder(scrollDirection: Axis.vertical,
                  itemBuilder: (c, p) => Container(
                    child: Stack(
                      children: [
                        Image.network(widget.provider.adList[p].picUrl),
                        Positioned(child: BackButton(color: Colors.white,),left: dw(16),top: dw(32),)
                      ],
                    ),
                  ),
                  itemCount: widget.provider.adList.length,
                  onPageChanged: (pos) {
                    LocalChannel.audioPlay(widget.provider.adList[pos].fileUrl);
                  },
                ),
              ),
              onRefresh: () {
                return widget.provider.loadAdvertList().listen((event) {
                  if (widget.provider.adList.length > 0) {
                    LocalChannel.audioPlay(widget.provider.adList[0].fileUrl);
                  }
                }).asFuture();
              }),
        ),
        onWillPop: onPop);
  }
}
