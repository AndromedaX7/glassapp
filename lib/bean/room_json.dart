import 'package:json_annotation/json_annotation.dart';

part 'room_json.g.dart';

@JsonSerializable()
class RoomListEntity {
  int pageNo;
  int pageSize;
  int count;

  RoomListEntity(this.pageNo, this.pageSize, this.count, this.list);

  List<RoomListItemEntity> list;

  factory RoomListEntity.fromJson(Map<String, dynamic> json) =>
      _$RoomListEntityFromJson(json);
}

@JsonSerializable()
class RoomListItemEntity {
  String id;
  String number;
  String topic;
  String nickname;
  String city;
  String birthday;
  String descFile;
  String cid;
  int state;
  int total;
  String userId;
  int chatroomState;
  int age;
  int subscribed;
  int mode;


  RoomListItemEntity.create();

  RoomListItemEntity(
      this.id,
      this.number,
      this.topic,
      this.nickname,
      this.city,
      this.birthday,
      this.descFile,
      this.cid,
      this.state,
      this.total,
      this.userId,
      this.chatroomState,
      this.age,
      this.subscribed,
      this.mode);

  factory RoomListItemEntity.fromJson(Map<String, dynamic> map) =>
      _$RoomListItemEntityFromJson(map);
}

@JsonSerializable()
class HistoryListEntity {
  List<HistoryListItemEntity> data;

  HistoryListEntity(this.data);

  factory HistoryListEntity.fromJson(Map<String, dynamic> map) =>
      _$HistoryListEntityFromJson(map);
}

@JsonSerializable()
class HistoryListItemEntity {
  String id;
  int channelid;
  String filename;

  HistoryListItemEntity(this.id, this.channelid, this.filename, this.url,
      this.userInfo, this.history);

  String url;
  UserInfo userInfo;
  HistoryRecord history;

  factory HistoryListItemEntity.fromJson(Map<String, dynamic> map) =>
      _$HistoryListItemEntityFromJson(map);
}

@JsonSerializable()
class UserInfo {
  String nickname;

  UserInfo(this.nickname);

  factory UserInfo.fromJson(Map<String, dynamic> map) =>
      _$UserInfoFromJson(map);
}

@JsonSerializable()
class HistoryRecord {
  final String title;

  const HistoryRecord(this.title);

  factory HistoryRecord.fromJson(Map<String, dynamic> map) =>
      _$HistoryRecordFromJson(map);
}

@JsonSerializable()
class MyRoomDetails {
  String id;
  String number;
  String topic;
  String nickname;
  String city;
  String birthday;
  String descFile;
  String cid;
  int state;
  int total;

  String userId;
  int mode;
  int chatroomState;
  int subscribed;
  int age;

  MyRoomDetails(this.id, this.number, this.topic, this.nickname, this.city,
      this.birthday, this.descFile, this.cid, this.state, this.total,
      this.userId, this.mode, this.chatroomState, this.subscribed, this.age);


  factory MyRoomDetails.fromJson(Map<String, dynamic> map) =>
      _$MyRoomDetailsFromJson(map);
}
