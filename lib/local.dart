import 'package:flutter/services.dart';
import 'package:glassapp/design.dart';

/// 应用本地Api channel
class LocalChannel {
  static const _local = const MethodChannel("glass_app");
  static const _host_root = const MethodChannel("host-root");

  /// 调用本地toast
  static void toast(String text) {
    _local
        .invokeMethod("toast", {"offset": dw(128) / dw(667), "text": "$text"});
  }

  /// 开始录音
  static void recordStart() async {
    await _local.invokeMethod("startRecord");
  }

  /// 录音结束
  /// @return :录音文件位置
  static Future<String> recordEnd() async {
    return await _local.invokeMethod("stopRecord");
  }

  /// 启动Activity
  /// action: Intent#action
  static void launchPlatform(String action) async {
    await _local.invokeMethod("startActivity", action);
  }

  static void sendQuestion(Map map) async {
    await _local.invokeMethod("question", map);
  }

  ///启动activity
  static void startActivityWithArgs(
      String action, Map<String, String> map) async {
    map['action'] = action;
    await _local.invokeMethod("startActivityWithArgs", map);
  }

  /// 关闭当前flutter page Activity
  static void finishSelf() async {
    await _host_root.invokeMethod("finish");
  }

  static void audioPlay(String path) {
    _local.invokeMethod("audioPlay", {"url": path});
  }

  static void pauseCurrent() {
    _local.invokeMethod("pauseCurrent");
  }

  static void resumeCurrent() {
    _local.invokeMethod("resumeCurrent");
  }

  static void stopCurrent() {
    _local.invokeMethod("stopCurrent");
  }

  static Future<bool> isPlaying()async {
   return await _local.invokeMethod("isPlaying");
  }
}
