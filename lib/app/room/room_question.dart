import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:glassapp/design.dart';
import 'package:glassapp/viewmodel/room_provider.dart';

class RoomQuestionContentPage extends StatefulWidget {
  final RoomProvider provider;

  RoomQuestionContentPage(this.provider);

  @override
  _RoomCreateContentPageState createState() => _RoomCreateContentPageState();
}

class _RoomCreateContentPageState extends State<RoomQuestionContentPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:EdgeInsets.symmetric(horizontal: dw(20)) ,
      child: Offstage(
        offstage: !widget.provider.openQuestion,
        child: Card(
          child: Container(
                  child: Container(
                    height: dw(350),
                    width: dw(335),
                    child: ListView.builder(
                      itemBuilder: (c, p) => _buildQuestionItem(p, null),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildQuestionItem(int pos, data) {
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
          Text("王丽佳提问：123456789"),
//          Spacer(),
//          Padding(
//            padding: EdgeInsets.only(right: dw(20), left: dw(8)),
//            child: Icon(
//              Icons.mic,
//              color: Colors.black,
//            ),
//          )
        ],
      ),
    );
  }
}
