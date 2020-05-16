import 'package:flutter/cupertino.dart';
import 'package:glassapp/base.dart';
import 'package:glassapp/local.dart';
import 'package:glassapp/utils/network_model.dart';
import 'package:glassapp/utils/utils.dart';
import 'package:glassapp/bean/json_entity.dart';
import 'package:glassapp/bean/room_json.dart';
import 'package:glassapp/utils/shared_preferences.dart';
import 'package:glassapp/utils/log.dart';
import 'package:glassapp/yunxin.dart';
import 'package:rxdart/rxdart.dart';

part 'part_room_field.dart';

class RoomProvider extends BaseProvider {
  /// 当前已经创建的房间云信id
  int createRoomId = 0;

  /// SharedPreferences
  final SpCaller caller;

  bool iCreate;

  bool listCanLoad = false;

  bool favCanLoad = false;

  bool searchListCanLoad = false;

  /// getter and setter ////////////////////////////
  /// see [_descfilePath]
  String get descfilePath => _descfilePath;

  set descfilePath(String value) {
    _descfilePath = value;
    Log.w(value);
  }

  /// see [_userMode]
  bool get userMode => _userMode;

  set userMode(bool value) {
    _userMode = value;
    notifyListeners();
  }

  void initUserMode(bool mode) {
    _userMode = mode;
  }

  /// see [_currentRoomDetails]
  RoomListItemEntity get currentRoomDetails => _currentRoomDetails;

  set currentRoomDetails(RoomListItemEntity value) {
    _currentRoomDetails = value;
    notifyListeners();
  }

  /// see [_myRoomDetails]
  MyRoomDetails get myRoomDetails => _myRoomDetails;

  set myRoomDetails(MyRoomDetails value) {
    _myRoomDetails = value;
    notifyListeners();
  }

  /// see [_haveRoom]
  bool get haveRoom => _haveRoom;

  set haveRoom(bool value) {
    _haveRoom = value;
    notifyListeners();
  }

  /// see [_barInfo]
  List get barInfo => _barInfo;

  /// see [_historyList]
  List<HistoryListItemEntity> get historyList => _historyList;

  set historyList(List<HistoryListItemEntity> value) {
    _historyList = value;
    notifyListeners();
  }

  /// see [_roomList]
  List<RoomListItemEntity> get roomList => _roomList;

  set roomList(List<RoomListItemEntity> value) {
    if (value != null)
      _roomList.addAll(value);
    else {
      _roomList = new List();
    }
    notifyListeners();
  }

  /// see [_roomSearchList]
  List<RoomListItemEntity> get roomSearchList => _roomSearchList;

  set roomSearchList(List<RoomListItemEntity> value) {
    if (value != null)
      _roomSearchList.addAll(value);
    else {
      _roomSearchList = new List();
    }
    notifyListeners();
  }

  /// see [_favList]
  List<RoomListItemEntity> get favList => _favList;

  set favList(List<RoomListItemEntity> value) {
    if (value != null)
      _favList.addAll(value);
    else {
      _favList = new List();
    }
    notifyListeners();
  }

  /// see [_states]
  get states => _states;

  set states(List<bool> v) {
    _states = v;
    notifyListeners();
  }

  /// see [_roomCount]
  String get roomCount => _roomCount;

  set roomCount(String value) {
    int count = int.tryParse(value) ?? 0;
    if (count > 0) {
      _roomCount = "($count)";
    } else {
      _roomCount = "";
    }
    notifyListeners();
  }

  /// see [_openNewRoom]
  bool get openNewRoom => _openNewRoom;

  set openNewRoom(bool v) {
    _openNewRoom = v;
    notifyListeners();
  }

  /// see [_openQuestion]
  bool get openQuestion => _openQuestion;

  set openQuestion(bool value) {
    _openQuestion = value;
    notifyListeners();
  }

  /// see [_openQuestionSend]
  bool get openQuestionSend => _openQuestionSend;

  set openQuestionSend(bool value) {
    _openQuestionSend = value;
    notifyListeners();
  }

  /// see [_favCount]
  String get favCount => _favCount;

  set favCount(String value) {
    int count = int.tryParse(value) ?? 0;
    if (count > 0) {
      _favCount = "($count)";
    } else {
      _favCount = "";
    }
    notifyListeners();
  }

/////////////////// getter setter end

  RoomProvider(this.caller);

  void joinRoom(String roomNum, bool mode) async {
    await YunxinChannel.joinInRoom(roomNum, mode);
  }

  void createRoomPage() {
    openNewRoom = true;
  }

  void barPress(int i) {
    _states[i] = !_states[i];

    switch (i) {
      case 1:
        //TODO  leave
        break;
      case 3:
        if (iCreate)
          openQuestion = !openQuestion;
        else {
          LocalChannel.sendQuestion({"roomId": currentRoomDetails.id});
        }
        break;
    }
  }

  Observable loadRoomList() => serverRoomList(
        caller.getString("token"),
        _roomListPage,
      ).doOnData((event) {
        Log.v(event);
        var entity = BaseEntity.fromJson(event);
        if (entity.success) {
          var roomListEntity = RoomListEntity.fromJson(entity.toBody().data);
          roomList = roomListEntity.list;
          roomCount = roomList.length.toString();
          listCanLoad = canLoad(roomListEntity.pageNo, roomListEntity.pageSize,
              roomListEntity.count);
        } else {
          listCanLoad = false;
        }
      });

  Observable loadRoomList2(String name) =>
      serverRoomList(caller.getString("token"), _roomSearchListPage, name: name)
          .doOnData((event) {
        Log.w(event);
        var entity = BaseEntity.fromJson(event);
        if (entity.success) {
          var roomListEntity = RoomListEntity.fromJson(entity.toBody().data);
          roomSearchList = roomListEntity.list;
          searchListCanLoad = canLoad(roomListEntity.pageNo,
              roomListEntity.pageSize, roomListEntity.count);
        } else {
          searchListCanLoad = false;
        }
      });

  Observable favRoomList() =>
      serverFavRoomList(caller.getString("token"), _favListPage)
          .doOnData((event) {
        var entity = BaseEntity.fromJson(event);
        if (entity.success) {
          var roomListEntity = RoomListEntity.fromJson(entity.toBody().data);
          favList = roomListEntity.list;
          favCount = favList.length.toString();

          favCanLoad = canLoad(roomListEntity.pageNo, roomListEntity.pageSize,
              roomListEntity.count);
        } else {
          favCanLoad = false;
        }
      });

  Observable addFav(String roomId) =>
      serverAddFavi(caller.getString("token"), roomId).doOnData((event) {
        Log.v(event);
      });

  Observable deleteFav(String roomId) =>
      serverDeleteFavi(caller.getString("token"), roomId).doOnData((event) {
        Log.v(event);
      });

  Observable history() =>
      serverHistoryRoom(caller.getString("token")).doOnData((event) {
        Log.i(event);
        var entity = BaseEntity.fromJson(event);
        if (entity.success) {
          HistoryListEntity listEntity =
              HistoryListEntity.fromJson(entity.body);
          historyList = listEntity.data;
        }
      });

  Observable myRoom() =>
      serverMyRoomDetails(caller.getString("token")).doOnData((event) {
        Log.i(event);
        var entity = BaseEntity.fromJson(event);
        haveRoom = entity.toBody().data != null;
        Log.i("have room ? $haveRoom");
        if (haveRoom && entity.success) {
          myRoomDetails = MyRoomDetails.fromJson(entity.toBody().data);
        }
      });

  Observable createOrUpdateRoom(
      String topic, String nickName, String city, String birthday) {
    Observable result;
    if (haveRoom) {
      result = serverUpdateRoom(caller.getString("token"), topic, nickName,
          city, birthday, descfilePath);
    } else {
      result = serverCreateRoom(caller.getString("token"), topic, nickName,
          city, birthday, descfilePath);
    }
    result.doOnData((event) {
      Log.w(event);
    });
    return result;
  }

  Observable startRoom(String cid) =>
      serverOpenRoom(caller.getString("token"), cid).doOnData((event) {
        Log.v(event);
        var e = BaseEntity.fromJson(event);
        if (e.success) {
          LocalChannel.toast("聊天室已打开");
        } else {
          LocalChannel.toast(e.msg);
        }
      });

  Observable closeRoom() =>
      serverCloseRoom(caller.getString("token")).doOnData((event) {
        Log.e(event);
      });

  void createRoom() async {
    if (haveRoom) {
      createRoomId = await YunxinChannel.createRoom(myRoomDetails.userId);
    }
  }

  Observable roomDetails(String roomId) =>
      serverRoomDetails(caller.getString("token"), roomId).doOnData((event) {
        Log.e(event);

        var entity = BaseEntity.fromJson(event);
        if (entity.success) {
          _currentRoomDetails =
              RoomListItemEntity.fromJson(entity.toBody().data);
          _userMode = currentRoomDetails.mode == 1;
        }
      });

  Observable changeMode(bool mode) =>
      serverChangeRoomMode(caller.getString("token"), mode).doOnData((event) {
        Log.e(event);
        if (BaseEntity.fromJson(event).success) {
          userMode = mode;
          YunxinChannel.changeMode(userMode, createRoomId);
        }
      });

  void nextListPage() {
    _roomListPage++;
  }

  void listPageReset() {
    roomList = null;
    _roomListPage = 1;
  }

  void nextSearchListPage() {
    _roomSearchListPage++;
  }

  void listSearchPageReset() {
    roomSearchList = null;
    _roomSearchListPage = 1;
  }

  void nextFavPage() {
    _favListPage++;
  }

  void favPageReset() {
    favList = null;
    _favListPage = 1;
  }
}
