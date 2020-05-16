import 'package:flutter/material.dart';
import 'package:glassapp/utils/log.dart';
import 'package:glassapp/viewmodel/room_provider.dart';
import 'package:glassapp/widgets.dart';

import '../../design.dart';

class SearchRoomContentPage extends StatefulWidget {
  final RoomProvider provider;

  SearchRoomContentPage(this.provider);

  @override
  _SearchRoomContentPageState createState() => _SearchRoomContentPageState();
}

class _SearchRoomContentPageState extends State<SearchRoomContentPage> {
  @override
  void initState() {
    super.initState();
    widget.provider.loadRoomList2("").listen((event) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(
        searchContentColor: Color(0xffeeeeee),
        hint: "请输入房间主题或房间号",
        onCancel: () => Navigator.of(context).pop(),
        heroId: "1",
        onSearch: (s) {
          Log.w(s);
          widget.provider.loadRoomList2(s).listen((event) {
            setState(() {});
          });
        },
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: dw(20)),
        child: ListView.builder(
          itemCount: widget.provider.roomSearchList.length,
          itemBuilder: (c, p) => Container(
            margin: EdgeInsets.only(bottom: dw(16)),
            height: dw(309),
            child: RoomItemWidget(widget.provider, p, widget.provider.roomSearchList[p]),
          ),
        ),
      ),
    );
  }


}
