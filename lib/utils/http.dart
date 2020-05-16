import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:glassapp/app/app.dart';
import 'package:glassapp/app/home/home_scaffold.dart';
import 'package:glassapp/di/app_module.dart';
import 'package:glassapp/local.dart';
import 'package:glassapp/bean/json_entity.dart';
import 'package:rxdart/rxdart.dart';

Future _get(String url,
        {Map<String, dynamic> params, Map<String, dynamic> headers}) =>
    _interceptorGet(url, params: params, headers: headers);

Future _post(String url,
        {Map<String, dynamic> params, Map<String, dynamic> headers}) =>
    _interceptorPost(url, params: params, headers: headers);

Observable post(String url,
        {Map<String, dynamic> params, Map<String, dynamic> headers}) =>
    Observable.fromFuture(_post(url, params: params, headers: headers))
        .asBroadcastStream();

Observable get(String url,
        {Map<String, dynamic> params, Map<String, dynamic> headers}) =>
    Observable.fromFuture(_get(url, params: params, headers: headers))
        .asBroadcastStream();

Future _interceptorGet(String url,
    {Map<String, dynamic> params, Map<String, dynamic> headers}) async {
  var response = await dio.get(url,
      queryParameters: params, options: Options(headers: headers));
  if (BaseEntity.fromJson(response.data).errorCode == "401") {
//    homeProvider.currentPosition = 0;
//    homeProvider.userState = 0;
//
//    showDialog(
//        context: HomePage.appContext,
//        barrierDismissible: false,
//        child: SimpleDialog(
//          title: Text("您的账号在其他设备上登录"),
//          children: <Widget>[
//            SimpleDialogOption(
//              child: Text("即将自动返回登录界面"),
//            )
//          ],
//        ));
//    await Future.delayed(Duration(seconds: 3));
//    while (App.navigatorKey.currentState.canPop()) {
//      App.navigatorKey.currentState.pop();
//    }
    _callPop();
    return response.data;
  } else
    return response.data;
}

_callPop() async {
  homeProvider.currentPosition = 0;
//  homeProvider.userState = 0;

  showDialog(
      context: HomeScaffold.appContext,
      barrierDismissible: false,
      child: SimpleDialog(
        title: Text("您的账号在其他设备上登录"),
        children: <Widget>[
          SimpleDialogOption(
            child: Text("即将自动返回登录界面"),
          )
        ],
      ));
  await Future.delayed(Duration(seconds: 3));
  while (App.navigatorKey.currentState.canPop()) {
    App.navigatorKey.currentState.pop();
  }

  LocalChannel.launchPlatform("login");
}

Future _interceptorPost(String url,
    {Map<String, dynamic> params, Map<String, dynamic> headers}) async {
  var response = await dio.post(url,
      queryParameters: params, options: Options(headers: headers));
  if (BaseEntity.fromJson(response.data).errorCode == "401") {
    _callPop();
    return response.data;
  } else
    return response.data;
}

Future _formData(String url, FormData data,
    {Map<String, dynamic> headers}) async {
  var response =
      await dio.post(url, data: data, options: Options(headers: headers));
  return response.data;
}

Observable formData(String url, FormData data,
        {Map<String, dynamic> headers}) =>
    Observable.fromFuture(_formData(url, data, headers: headers))
        .asBroadcastStream();
//String htmlWrapper(String content) {
//  String result = "<html>\n" +
//      "    <head>\n" +
//      "        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n" +
//      "    </head>\n" +
//      "    <body>\n" +
//      content +
//      "    </body>\n" +
//      "</html>";
//  return result;
//}

String htmlTransform(String content) {
  return content
      .replaceAll("&lt;", "<")
      .replaceAll("&gt;", ">")
      .replaceAll("&amp;", "&")
      .replaceAll("&quot;", "\"");
}
