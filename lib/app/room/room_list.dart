import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassapp/app/room/history_room_record.dart';
import 'package:glassapp/app/room/room_create.dart';
import 'package:glassapp/app/room/room_search.dart';
import 'package:glassapp/base.dart';
import 'package:glassapp/design.dart';
import 'package:glassapp/local.dart';
import 'package:glassapp/utils/log.dart';
import 'package:glassapp/viewmodel/room_provider.dart';
import 'package:glassapp/widgets.dart';

class RoomListPage extends PageProviderNode<RoomProvider> {
  @override
  Widget buildContent(BuildContext context) {
    return RoomListContentPage(mProvider);
  }
}

class RoomListContentPage extends StatefulWidget {
  final RoomProvider provider;

  RoomListContentPage(this.provider);

  @override
  _RoomListContentPageState createState() => _RoomListContentPageState();
}

class _RoomListContentPageState extends State<RoomListContentPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  PageController listController;
  ScrollController favController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    listController = PageController();
    favController = ScrollController();
    listController.addListener(() {
      if (listController.position.pixels ==
              listController.position.maxScrollExtent &&
          widget.provider.listCanLoad) {
        widget.provider.nextListPage();
        widget.provider.loadRoomList().listen((event) {});
      }
    });
    favController.addListener(() {
      if (favController.position.pixels ==
              favController.position.maxScrollExtent &&
          widget.provider.favCanLoad) {
        widget.provider.nextFavPage();
        widget.provider.favRoomList().listen((event) {});
      }
    });

    widget.provider.loadRoomList().listen((event) {
      if (widget.provider.roomList.length > 0)
        LocalChannel.audioPlay(widget.provider.roomList[0].descFile);
    });
    widget.provider.favRoomList().listen((event) {});
    _tabController.addListener(() {
      switch (_tabController.index) {
        case 0:
          widget.provider.listPageReset();
          widget.provider.loadRoomList().listen((event) {
            if (widget.provider.roomList.length > 0)
              LocalChannel.audioPlay(widget.provider.roomList[0].descFile);
          });
          break;
        case 1:
          widget.provider.favPageReset();
          widget.provider.favRoomList().listen((event) {});
          break;
        case 2:
          Log.i("pressed me");
          break;
      }
      LocalChannel.stopCurrent();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<bool> onPop() async {
    LocalChannel.stopCurrent();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    initDisplay(context);
    return WillPopScope(
      onWillPop: onPop,
      child: Material(
        child: Stack(
          children: [
            Scaffold(
              appBar: SearchTapAppBar(
                hint: "请输入房间主题或房间号",
                heroId: "1",
                onSearch: () {
                  LocalChannel.stopCurrent();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (c) => SearchRoomContentPage(widget.provider)));
                },
                searchContentColor: Color(0xffeeeeee),
                bottomPadding: EdgeInsets.symmetric(horizontal: dw(50)),
                bottom: TabBar(
                  tabs: [
                    Tab(
                      text: "房间${widget.provider.roomCount}",
                    ),
                    Tab(
                      text: "收藏${widget.provider.favCount}",
                    ),
                    Tab(
                      text: "往期精彩",
                    ),
                  ],
                  labelStyle: TextStyle(fontSize: sp(12)),
                  controller: _tabController,
                  labelColor: Color(0xFF333333),
                  indicatorSize: TabBarIndicatorSize.label,
                ),
              ),
              body: TabBarView(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: [
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: dw(20), right: dw(20), top: dw(16)),
                            child: RefreshIndicator(
                              onRefresh: () {
                                widget.provider.listPageReset();
                                return widget.provider
                                    .loadRoomList()
                                    .listen((event) {
                                  if (widget.provider.roomList.length > 0)
                                    LocalChannel.audioPlay(
                                        widget.provider.roomList[0].descFile);
                                }).asFuture();
                              },
                              child: EmptyWidgetWrapper(
                                child: PageView.builder(
                                  onPageChanged: (pos) {
                                    LocalChannel.audioPlay(
                                        widget.provider.roomList[pos].descFile);
                                  },
                                  controller: listController,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (c, p) => RoomItemWidget(
                                      widget.provider,
                                      p,
                                      widget.provider.roomList[p]),
                                  itemCount: widget.provider.roomList.length,
                                ),
                                data: widget.provider.roomList,
                              ),
                            ),
                          ),
                          fit: FlexFit.tight,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: dw(50), top: dw(28)),
                          child: GestureDetector(
                            onTap: () {
                              LocalChannel.stopCurrent();
                              widget.provider.createRoomPage();
                            },
                            child: Container(
                              width: dw(276),
                              height: dw(51),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color(0xff90c9ee),
                                      Color(0xff1b87cd)
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(dw(4))),
                              child: Center(
                                child: Text(
                                  "创建聊天室",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: sp(18)),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: dw(20), right: dw(20), top: dw(16)),
                    child: RefreshIndicator(
                      onRefresh: () {
                        widget.provider.favPageReset();
                        return widget.provider
                            .favRoomList()
                            .listen((event) {})
                            .asFuture();
                      },
                      child: EmptyWidgetWrapper(
                        child: ListView.builder(
                          controller: favController,
                          itemBuilder: (c, p) => Container(
                            margin: EdgeInsets.only(bottom: dw(16)),
                            height: dw(309),
                            child: RoomItemWidget(
                                widget.provider, p, widget.provider.favList[p]),
                          ),
                          itemCount: widget.provider.favList.length,
                        ),
                        data: widget.provider.favList,
                      ),
                    ),
                  ),
                  HistoryRoomRecord(widget.provider),
                ],
                controller: _tabController,
              ),
            ),
            RoomCreateContentPage(widget.provider),
          ],
        ),
      ),
    );
  }
}
