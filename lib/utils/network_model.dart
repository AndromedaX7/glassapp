import 'dart:io';

import 'package:dio/dio.dart';
import 'package:glassapp/di/app_module.dart';
import 'package:rxdart/rxdart.dart';

import 'http.dart';
String _baseUrl = "http://47.104.232.219";
//String _baseUrl = "http://localhost:8080";

get serverUrl => _baseUrl;

set serverUrl(String url) {
  _baseUrl = url;
}

Observable serverLogin(String mobile, String password, int userType) =>
    post("$_baseUrl/login", params: {
      "mobile": "$mobile",
      "password": "$password",
      "userType": userType
    });

Observable serverAgreement() => get("$_baseUrl/sys/privateProtocol");

Observable serverContacts(String token) =>
    get('$_baseUrl/api/contact/list', headers: {"token": token});

Observable serverSettings() => get('$_baseUrl/sys/get');

Observable serverRecommendList(String token, int page, int source) =>
    get('$_baseUrl/api/shop/goods/recommendList',
        headers: {"token": token},
        params: {"pageNo": page, "pageSize": 10, "source": source});

Observable serverGoodsDetails(String id, String token) =>
    get("$_baseUrl/api/shop/goods/get",
        headers: {"token": token}, params: {"id": id});

Observable serverCertList(String token) =>
    get("$_baseUrl/api/shop/cart/page", headers: {"token": token});

Observable serverCategoryList(String token, int source,
        {String parentId = ""}) =>
    get("$_baseUrl/api/shop/category/list",
        headers: {"token": token},
        params: {"source": source, "parentId": parentId});

Observable serverCategoryGoods(
        String token, String categoryId, String subCategoryId, int pageNo,
        {String name, String source}) =>
    get("$_baseUrl/api/shop/goods/page", headers: {
      "token": token
    }, params: {
      "categoryId": categoryId,
      "subCategoryId": subCategoryId,
      "pageNo": pageNo,
      "name": name,
      "pageSize": 20,
      "source": source
    });

Observable serverOrderCount(String token) =>
    get("$_baseUrl/api/shop/order/count", headers: {"token": token});

Observable serverOrderList(String token, int page, {String state = ""}) =>
    get("$_baseUrl/api/shop/order/page",
        params: {"state": state, "pageNo": page, "pageSize": 10},
        headers: {"token": token});

Observable serverGuardianshipList(String token, int page) =>
    get("$_baseUrl/api/guardianship/list",
        headers: {"token": token}, params: {"pageNo": page, "pageSize": 10});

Observable serverGuardianshipAdd(
        String token, String mobile, String password) =>
    post("$_baseUrl/api/guardianship/add",
        headers: {"token": token},
        params: {"mobile": mobile, "password": password});

Observable serverGuardianshipDelete(String token, String id) =>
    post("$_baseUrl/api/guardianship/delete",
        headers: {"token": token}, params: {"id": id});

Observable serverGoodsCart(String token, int page) =>
    get("$_baseUrl/api/shop/cart/page",
        params: {"pageNo": page, "pageSize": 10}, headers: {"token": token});

Observable serverAddToCart(String token, String goodsId, int amount,
        {String propertyId}) =>
    post("$_baseUrl/api/shop/cart/update", params: {
      "goodsId": goodsId,
      "amount": amount,
      "propertyId": propertyId
    }, headers: {
      "token": token
    });

Observable serverBookList(String token, {String name = ""}) =>
    get("$_baseUrl/api/audio/list",
        params: {"name": name}, headers: {"token": token});

Observable serverWeather(String city) =>
    get("https://api.seniverse.com/v3/weather/now.json",
        params: {"key": "o6uxoqv2f5pwk0eh", "location": city});
//=====================================================================//
Observable serverRoomList(String token, int page, {String name = ""}) =>
    get("$_baseUrl/api/chatroom/page",
        headers: {"token": token},
        params: {"pageNo": page, "pageSize": 10, "keyword": name});

Observable serverFavRoomList(String token, int page, {String name = ""}) =>
    get("$_baseUrl/api/chatroom/favorite/page",
        headers: {"token": token}, params: {"pageNo": page, "pageSize": 10});

Observable serverAddFavi(String token, String chatroomId) =>
    post("$_baseUrl/api/chatroom/favorite/add", headers: {
      "token": token
    }, params: {
      "chatroomId": chatroomId,
    });

Observable serverRoomDetails(String token, String roomId) =>
    get("$_baseUrl/api/chatroom/get",
        headers: {"token": token}, params: {"id": roomId});

Observable serverMyRoomDetails(String token) =>
    get("$_baseUrl/api/chatroom/my", headers: {"token": token});

Observable serverDeleteFavi(String token, String chatroomId) =>
    post("$_baseUrl/api/chatroom/favorite/delete", headers: {
      "token": token
    }, params: {
      "chatroomId": chatroomId,
    });

Observable serverOpenRoom(String token, String cid) =>
    post("$_baseUrl/api/chatroom/start",
        params: {"cid": cid}, headers: {"token": token});

Observable serverCreateRoom(String token, String topic, String nickName,
    String city, String birthday, String filePath) {
  FormData data;
  if (filePath == null) {
    data = FormData.fromMap({
      "topic": topic,
      "nickname": nickName,
      "city": city,
      "birthday": birthday,
    });
  } else {
    File file = File(filePath);
    data = FormData.fromMap({
      "topic": topic,
      "nickname": nickName,
      "city": city,
      "birthday": birthday,
      "file": MultipartFile.fromFileSync(filePath, filename: file.path)
    });
  }
  return formData("$_baseUrl/api/chatroom/add", data,
      headers: {"token": token});
}

Observable serverUpdateRoom(String token, String topic, String nickName,
    String city, String birthday, String filePath) {
  FormData data;

  if (filePath == null) {
    data = FormData.fromMap({
      "topic": topic,
      "nickname": nickName,
      "city": city,
      "birthday": birthday,
    });
  } else {
    File file = File(filePath);
    data = FormData.fromMap({
      "topic": topic,
      "nickname": nickName,
      "city": city,
      "birthday": birthday,
      "file": MultipartFile.fromFileSync(filePath, filename: file.path)
    });
  }

  return formData("$_baseUrl/api/chatroom/update", data,
      headers: {"token": token});
}

Observable serverCloseRoom(String token) =>
    post("$_baseUrl/api/chatroom/close", headers: {"token": token});

Observable serverChangeRoomMode(String token, bool mode) =>
    post("$_baseUrl/api/chatroom/change_mode",
        headers: {"token": token}, params: {"mode": mode ? 1 : 2});

Observable serverHistoryRoom(String token) =>
    get("$_baseUrl/api/chatroom/history/list", headers: {
      "token": token,
    });

//==========================================================
Observable serverBindGlassList(String token) =>
    post("$_baseUrl/api/device/info", headers: {"token": token});

Observable serverBindGlass(String token,String mac) => post("$_baseUrl/api/device/bind",
    headers: {"token": token}, params: {"mac": mac});
Observable serverUnbindGlass(String token ) => post("$_baseUrl/api/device/unbind",
    headers: {"token": token} );

String urlWrapper(String url) {
  url = url.replaceAll("http://localhost:8080", _baseUrl);
  return url.startsWith("/") ? "$_baseUrl$url" : url;
}
Observable serverAdvertList( )=>get("$_baseUrl/api/adver/list",headers: {"token":caller.getString("token")});