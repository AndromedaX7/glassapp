import 'package:flutter/material.dart';
import 'package:glassapp/app/room/room_question.dart';
import 'package:glassapp/design.dart';
import 'package:glassapp/viewmodel/room_provider.dart';
import 'package:glassapp/widgets.dart';
import 'package:glassapp/yunxin.dart';

class OpenedRoomContentPage extends StatefulWidget {
  final RoomProvider provider;

  final bool iCreate;
  final String roomId;
  final bool userMode;

  OpenedRoomContentPage(this.provider, this.roomId,
      {this.iCreate = false, this.userMode}) {
    provider.initUserMode(userMode);
    provider.iCreate =iCreate;
  }

  @override
  OpenedRoomContentPageState createState() => OpenedRoomContentPageState();
}

class OpenedRoomContentPageState extends State<OpenedRoomContentPage> {
  var key = GlobalKey<BottomBarState>();

  Future<bool> back() async {
    YunxinChannel.leaveRoom(widget.roomId);
    if (widget.iCreate) {
      widget.provider.closeRoom().listen((event) {});
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    YunxinChannel.initChannel(this);
  }

  @override
  Widget build(BuildContext context) {
    double floatingBarItem = dw(60);
    double floatingBarWidth = 0;
    bool barMode;
    if (widget.provider.userMode) {
      floatingBarWidth = 4 * floatingBarItem + 3;
      barMode = true;
    } else {
      floatingBarWidth = 3 * floatingBarItem + 2;
      barMode = false;
    }

    return WillPopScope(
      onWillPop: back,
      child: Scaffold(
          appBar: RoomTitleBar(
            bottom: BottomBar(
              key: key,
              iCreate: widget.iCreate,
              title: "${widget.provider.currentRoomDetails.topic ?? "正在连接"}",
              userMode: widget.provider.userMode,
              modeChange: (mode) {
                widget.provider.changeMode(mode).listen((event) {
                  setState(() {
                    key.currentState.setMode(mode);
                  });
                });
              },
            ),
          ),
          body: Column(
            children: <Widget>[
              Container(
                padding:
                    EdgeInsets.only(top: dw(23), left: dw(20), right: dw(20)),
                height: dw(72),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("在线：${widget.provider.currentRoomDetails.total ?? 0}"),
                    Spacer(),
                    Row(
                      children: [
                        Container(
                          width: dw(28),
                          height: dw(28),
                          color: Color(0xFFCCCCCC),
                          child: Center(
                            child: Text(
                              "11",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(dw(4)),
                          child: Text(
                            ":",
                            style: TextStyle(
                              color: Color(0xFFCCCCCC),
                            ),
                          ),
                        ),
                        Container(
                          width: dw(28),
                          height: dw(28),
                          color: Color(0xFFCCCCCC),
                          child: Center(
                            child: Text(
                              "11",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(dw(4)),
                          child: Text(
                            ":",
                            style: TextStyle(
                              color: Color(0xFFCCCCCC),
                            ),
                          ),
                        ),
                        Container(
                          width: dw(28),
                          height: dw(28),
                          color: Color(0xFFCCCCCC),
                          child: Center(
                            child: Text(
                              "11",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      child: ListView.builder(
                        itemBuilder: (c, p) => _buildItem(p, null),
                        itemCount: widget.provider.currentRoomDetails.total,
                      ),
                    ),
                    Positioned(
                      child: Column(
                        children: <Widget>[
                          RoomQuestionContentPage(widget.provider),
                          Container(
                            margin: EdgeInsets.only(top: dw(34)),
                            decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: Color(0xffaaaaaa),
                                      spreadRadius: dw(4),
                                      blurRadius: dw(24),
                                      offset: Offset(dw(4), dw(4)))
                                ],
                                borderRadius: BorderRadius.circular(dw(6)),
                                gradient: LinearGradient(colors: <Color>[
                                  Color(0xFFFF62A5),
                                  Color(0xFFFF8960),
                                ])),
                            width: dw(floatingBarWidth),
                            height: dw(60),
                            child: barMode
                                ? _buildBarContent(4)
                                : _buildBarContent(3),
                          ),
                        ],
                      ),
                      bottom: dw(32),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget _buildItem(int pos, data) {
    return Container(
      height: dw(56),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: dw(20), right: dw(8)),
            child: Image.asset(
              "images/微信图片_20200414171111.png",
              width: dw(36),
              height: dw(36),
            ),
          ),
          Text("王丽佳"),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(right: dw(20), left: dw(8)),
            child: Icon(
              Icons.mic,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBarContent(int count) {
    List<Widget> items = List();
    for (int i = 0; i < count; i++) {
      Map map = widget.provider.barInfo[i];

      items.add(
        Expanded(
          child: GestureDetector(
            onTap: () async {
              widget.provider.barPress(i);
              if (i == 1) {
                await back();
                Navigator.of(context).pop();
              }
              setState(() {});
            },
            child: SelectedIconWidget(
              assetsNameDefault: map['d'],
              assetsNameSelect: map['s'],
              title: map['title'],
              selectedPosition: widget.provider.states,
              position: i, //selectedPosition: widget.provider.seletedPosition,
            ),
          ),
        ),
      );
      if (count - i != 1) {
        items.add(Container(
          width: 1,
          color: Colors.white,
        ));
      }
    }
    return Row(children: items);
  }

  void changeUserMode(bool arguments) {
    widget.provider.userMode = arguments;
    key.currentState.setMode(arguments);
    setState(() {

    });
  }
}

class SelectedIconWidget extends StatelessWidget {
  final String assetsNameDefault;
  final String assetsNameSelect;

  SelectedIconWidget(
      {this.assetsNameDefault,
      this.assetsNameSelect,
      this.title,
      this.position = 0,
      this.selectedPosition});

  final List<bool> selectedPosition;
  final String title;
  final int position;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
                selectedPosition[position]
                    ? "images/$assetsNameSelect.png"
                    : "images/$assetsNameDefault.png",
                width: dw(25),
                height: dw(25)),
            Padding(
              padding: EdgeInsets.only(top: dw(4)),
              child: Text(
                "${title ?? ""}",
                style: TextStyle(color: Colors.white, fontSize: sp(10)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
