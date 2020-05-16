import 'package:flutter/material.dart';
import 'package:glassapp/design.dart';
import 'package:glassapp/bean/room_json.dart';
import 'package:glassapp/viewmodel/room_provider.dart';

class HistoryRoomRecord extends StatefulWidget {
  final RoomProvider provider;

  HistoryRoomRecord(this.provider);

  @override
  _HistoryRoomRecordState createState() => _HistoryRoomRecordState();
}

class _HistoryRoomRecordState extends State<HistoryRoomRecord> {
  @override
  void initState() {
    super.initState();
    widget.provider.history().listen((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        onRefresh:()=> widget.provider.history().listen((event) { }).asFuture(),
        child: ListView.builder(
          itemBuilder: (c, p) =>
              _buildHistory(c, p, widget.provider.historyList[p]),
          itemCount: widget.provider.historyList.length,
        ),
      ),
    );
  }

  Widget _buildHistory(BuildContext c, int p, HistoryListItemEntity item) {
    return Container(
      height: dw(80),
      padding: EdgeInsets.symmetric(
        horizontal: dw(16),
      ),
      child: Column(
        children: <Widget>[
          Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(dw(20)),
                child: Image.asset(
                  "images/微信图片_20200414171111.png",
                  width: dw(40),
                  height: dw(40),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: dw(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${item.history?.title ?? "这条记录没有标题"}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Color(0xFF232428), fontSize: sp(17)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: dw(2)),
                        child: Text(
                          "${item.userInfo?.nickname ?? "佚名"}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: sp(13), color: Color(0xff666666)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: dw(8)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(dw(8)),
                    border: Border.all(color: Color(0xff333333))),
                padding:
                EdgeInsets.symmetric(horizontal: dw(13), vertical: dw(4)),
                child: Center(
                  child: Text(
                    "回放",
                    style:
                    TextStyle(fontSize: sp(12), color: Color(0xff333333)),
                  ),
                ),
              )
            ],
          ),
          Spacer(),
          Container(
            height: dw(1),
            color: Color(0xFFF3F3F3),
          )
        ],
      ),
    );
  }
}
