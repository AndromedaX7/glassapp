import 'dart:ui';

import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:glassapp/app/room/opened_room.dart';
import 'package:glassapp/bean/json_entity.dart';
import 'package:glassapp/design.dart';
import 'package:glassapp/local.dart';
import 'package:glassapp/utils/log.dart';
import 'package:glassapp/viewmodel/room_provider.dart';
import 'package:glassapp/widgets.dart';


class RoomCreateContentPage extends StatefulWidget {
  final RoomProvider provider;

  RoomCreateContentPage(this.provider);

  @override
  _RoomCreateContentPageState createState() => _RoomCreateContentPageState();
}

class _RoomCreateContentPageState extends State<RoomCreateContentPage> {
  TextEditingController _nickNameController;
  TextEditingController _topicNameController;

  @override
  void initState() {
    super.initState();
    _nickNameController = TextEditingController();
    _topicNameController = TextEditingController();
    widget.provider.myRoom().listen((event) {
      if (widget.provider.myRoomDetails != null) {
        setState(() {
          _nickNameController.text = widget.provider.myRoomDetails.nickname;
          _topicNameController.text = widget.provider.myRoomDetails.topic;
          if (widget.provider.myRoomDetails.birthday != null) {
            birthday = widget.provider.myRoomDetails.birthday.split(" ")[0];
          }
          city = widget.provider.myRoomDetails.city;
        });
      }
    });
  }

  String topic;
  String nickName;
  String city;
  String birthday;
  GlobalKey<FormState> key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    String birthdayHint = "选择您的出生年月";
    String addressHint = "选择您的出生地";
    if (birthday != null) {
      birthdayHint = birthday;
    }
    if (city != null) {
      addressHint = city;
    }

    return Offstage(
      offstage: !widget.provider.openNewRoom,
      child: Container(
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25.0, sigmaY: 25.0),
            child: Opacity(
              opacity: 0.85,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(color: Color(0x99000000)),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Opacity(
                        opacity: 1,
                        child: Container(
                          margin: EdgeInsets.only(
                              top: dw(76), left: dw(16), right: dw(16)),
                          decoration: BoxDecoration(),
                          child: Card2(
                            borderRadius: dw(16),
                            child: Form(
                              key: key,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: dw(20), top: dw(26)),
                                    child: Text(
                                      "创建聊天室",
                                      style: TextStyle(
                                          color: Color(0xff262628),
                                          fontSize: sp(24)),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: dw(8)),
                                    margin: EdgeInsets.only(
                                        top: dw(26),
                                        left: dw(20),
                                        right: dw(20)),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(dw(4)),
                                      color: Color(0xFFF5F5F5),
                                    ),
                                    height: dw(44),
                                    child: TextFormField(
                                      controller: _topicNameController,
                                      onSaved: (v) {
                                        topic = v;
                                      },
                                      onChanged: (v) {
                                        topic = v;
                                      },
                                      validator: (v) {
                                        if (v == null || v == "") {
                                          return "请输入主题";
                                        } else
                                          return null;
                                      },
                                      decoration: InputDecoration(
                                          hintText: "输入主题",
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: dw(16),
                                        left: dw(20),
                                        right: dw(20)),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: dw(8)),
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(dw(4)),
                                      color: Color(0xFFF5F5F5),
                                    ),
                                    height: dw(44),
                                    child: TextFormField(
                                      controller: _nickNameController,
                                      onSaved: (v) {
                                        nickName = v;
                                      },
                                      onChanged: (v) {
                                        nickName = v;
                                      },
                                      validator: (v) {
                                        if (v == null || v == "") {
                                          return "请输入昵称";
                                        } else
                                          return null;
                                      },
                                      decoration: InputDecoration(
                                          hintText: "输入您的昵称",
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: dw(16),
                                        left: dw(20),
                                        right: dw(20)),
                                    child: GestureDetector(
                                      onTap: () async {
                                        var dateTime = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime.now(),
                                            locale: Locale("zh"));
                                        if (dateTime != null)
                                          setState(() {
                                            birthday =
                                                "${dateTime.year}-${dateTime.month < 10 ? "0${dateTime.month}" : dateTime.month}-${dateTime.day}";
                                          });
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: dw(8)),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(dw(4)),
                                          color: Color(0xFFF5F5F5),
                                        ),
                                        height: dw(44),
                                        child: Text(
                                          birthdayHint,
                                        ),
                                      ),
                                    ),
                                  ),

                                  Container(
                                    margin: EdgeInsets.only(
                                        top: dw(16),
                                        left: dw(20),
                                        right: dw(20)),
                                    child: GestureDetector(
                                      onTap: () async {
                                        Result r =
                                            await CityPickers.showCityPicker(
                                                context: context);
                                        if (r != null)
                                          setState(() {
                                            city =
                                                "${r.provinceName}-${r.cityName}-${r.areaName}";
                                          });
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: dw(8)),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(dw(4)),
                                          color: Color(0xFFF5F5F5),
                                        ),
                                        height: dw(44),
                                        child: Text(
                                          addressHint,
                                        ),
                                      ),
                                    ),
                                  ),

//                                  Container(
//                                    margin: EdgeInsets.only(
//                                        top: dw(16),
//                                        left: dw(20),
//                                        right: dw(20)),
//                                    padding:
//                                        EdgeInsets.symmetric(horizontal: dw(8)),
//                                    decoration: BoxDecoration(
//                                      borderRadius:
//                                          BorderRadius.circular(dw(4)),
//                                      color: Color(0xFFF5F5F5),
//                                    ),
//                                    height: dw(44),
//                                    child: TextFormField(
//                                      onSaved: (v) {
//                                        city = v;
//                                      },
//                                      onChanged: (v) {
//                                        city = v;
//                                      },
//                                      decoration: InputDecoration(
//                                          hintText: "选择您的出生地",
//                                          border: InputBorder.none),
//                                    ),
//                                  ),
                                  GestureDetector(
                                    onLongPressStart: (s) {
                                      LocalChannel.recordStart();
                                    },
                                    onLongPressEnd: (l) {
                                      LocalChannel.recordEnd().then((value) =>
                                          widget.provider.descfilePath = value);
                                    },
                                    onTap: () {
                                      Log.w("on tap to play");
                                    },
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      width: double.infinity,
                                      margin: EdgeInsets.only(
                                          top: dw(16),
                                          left: dw(20),
                                          right: dw(20)),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: dw(8)),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(dw(4)),
                                        color: Color(0xFFFFF1F1),
                                      ),
                                      height: dw(44),
                                      child: Row(
                                        children: <Widget>[
                                          Text("长按重新录制语音描述"),
                                          Spacer(),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(right: dw(8)),
                                            child: GestureDetector(
                                              child: Image.asset(
                                                  "images/分组 2.png"),
                                              onTap: () {},
                                              onLongPress: () {},
                                              onVerticalDragDown: (d) {
                                                Log.d(d.globalPosition);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (key.currentState.validate()) {
                                        key.currentState.save();
                                        widget.provider
                                          ..createOrUpdateRoom(topic, nickName,
                                                  city, birthday)
                                              .listen((event) {
                                            if (BaseEntity.fromJson(event)
                                                .success) {
                                              if (!widget.provider.haveRoom) {
                                                widget.provider
                                                    .myRoom()
                                                    .listen((event) {
                                                  widget.provider
                                                      .roomDetails(widget
                                                          .provider
                                                          .myRoomDetails
                                                          .id)
                                                      .listen((event) {
                                                    widget.provider
                                                        .createRoom();
                                                    widget.provider.startRoom(widget.provider.createRoomId.toString()).listen((event) {
                                                      widget.provider
                                                          .openNewRoom = false;
                                                      Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                          builder: (c) =>
                                                              OpenedRoomContentPage(
                                                                widget.provider,
                                                                widget.provider
                                                                    .myRoomDetails.id,
                                                                iCreate: true,
                                                                userMode: true,
                                                              ),
                                                        ),
                                                      );
                                                    });

                                                  });
                                                });
                                              } else {
                                                widget.provider
                                                    .roomDetails(widget.provider
                                                        .myRoomDetails.id)
                                                    .listen((event) {
                                                  widget.provider.createRoom();

                                                  widget.provider.startRoom(widget.provider.createRoomId.toString()).listen((event) {
                                                    widget.provider
                                                        .openNewRoom =
                                                    false;
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (c) =>
                                                            OpenedRoomContentPage(
                                                              widget.provider,
                                                              widget.provider
                                                                  .myRoomDetails
                                                                  .id,
                                                              iCreate: true,
                                                              userMode: true,
                                                            ),
                                                      ),
                                                    );
                                                  });
                                                });
                                              }
                                            }
                                          });
                                      }
                                    },
                                    child: Container(
                                      child: Center(
                                        child: Text(
                                          "进入聊天室",
                                          style: TextStyle(
                                              fontSize: sp(18),
                                              color: Colors.white),
                                        ),
                                      ),
                                      margin: EdgeInsets.only(
                                          top: dw(28),
                                          left: dw(32),
                                          right: dw(32)),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(dw(4)),
                                          gradient: LinearGradient(
                                              colors: <Color>[
                                                Color(0xFF90C9EE),
                                                Color(0xFF1B87CD)
                                              ])),
                                      height: dw(50),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          height: dw(482),
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.only(top: dw(28)),
                      sliver: SliverToBoxAdapter(
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              widget.provider.openNewRoom = false;
                            },
                            child: Container(
                              width: dw(34),
                              height: dw(34),
                              child: Icon(
                                Icons.clear,
                                color: Colors.white,
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                  borderRadius: BorderRadius.circular(dw(17))),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
