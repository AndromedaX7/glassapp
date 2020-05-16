import 'package:flutter/services.dart';
import 'package:glassapp/app/room/opened_room.dart';
import 'package:glassapp/utils/log.dart';


/// 调用云信原生api
class YunxinChannel {
  static const _yunxin = const MethodChannel("yunxin");

  /// 设置房间状态回调
  static void initChannel(OpenedRoomContentPageState state) {
    _yunxin.setMethodCallHandler((call) {
      switch (call.method) {
        case "roomState":
          state.changeUserMode(call.arguments);
      }
      return Future(null);
    });
  }

  /// 创建云信房间
  static Future<int> createRoom(String roomName) async {
    Log.e(roomName);
    return await _yunxin.invokeMethod("create", {"roomName": roomName});
  }

  /// 设置扬声器外放开关
  static speaker(bool speaker) async {
    await _yunxin.invokeMethod("speaker", {"speaker": speaker});
  }

  /// 设置麦克风静音开关
  static muteMic(bool mute) async {
    await _yunxin.invokeMethod("mic", {"mute": mute});
  }

  /// 离开房间
  static Future<bool> leaveRoom(String roomNum) async {
    return await _yunxin.invokeMethod("leave", {"roomNum": roomNum});
  }

  /// 加入房间
  static Future<String> joinInRoom(String joinInRoomId, bool roomMode) async {
    return await _yunxin.invokeMethod(
        "joinIn", {"joinInRoomId": joinInRoomId, "roomMode": roomMode});
  }

  /// 麦克风是否静音
  static Future<bool> micState() async {
    return await _yunxin.invokeMethod("micState");
  }

  /// 扬声器外放状态
  static Future<bool> speakerState() async {
    return await _yunxin.invokeMethod("speakerState");
  }

  /// 改变房间模式
  /// userMode : true 主播模式
  ///            false 自由模式
  static void changeMode(bool userMode, int chatId) async {
    return await _yunxin.invokeMethod(
        "changeModeToOther", {"mode": userMode, "chatId": chatId.toString()});
  }

  static void sendQuestion(String roomId,String question)async{
    await _yunxin.invokeMethod("send",{"roomId":roomId,"message":question});
  }
}
