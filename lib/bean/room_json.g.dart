// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_json.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomListEntity _$RoomListEntityFromJson(Map<String, dynamic> json) {
  return RoomListEntity(
    json['pageNo'] as int,
    json['pageSize'] as int,
    json['count'] as int,
    (json['list'] as List)
        ?.map((e) => e == null
            ? null
            : RoomListItemEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$RoomListEntityToJson(RoomListEntity instance) =>
    <String, dynamic>{
      'pageNo': instance.pageNo,
      'pageSize': instance.pageSize,
      'count': instance.count,
      'list': instance.list,
    };

RoomListItemEntity _$RoomListItemEntityFromJson(Map<String, dynamic> json) {
  return RoomListItemEntity(
    json['id'] as String,
    json['number'] as String,
    json['topic'] as String,
    json['nickname'] as String,
    json['city'] as String,
    json['birthday'] as String,
    json['descFile'] as String,
    json['cid'] as String,
    json['state'] as int,
    json['total'] as int,
    json['userId'] as String,
    json['chatroomState'] as int,
    json['age'] as int,
    json['subscribed'] as int,
    json['mode'] as int,
  );
}

Map<String, dynamic> _$RoomListItemEntityToJson(RoomListItemEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'topic': instance.topic,
      'nickname': instance.nickname,
      'city': instance.city,
      'birthday': instance.birthday,
      'descFile': instance.descFile,
      'cid': instance.cid,
      'state': instance.state,
      'total': instance.total,
      'userId': instance.userId,
      'chatroomState': instance.chatroomState,
      'age': instance.age,
      'subscribed': instance.subscribed,
      'mode': instance.mode,
    };

HistoryListEntity _$HistoryListEntityFromJson(Map<String, dynamic> json) {
  return HistoryListEntity(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : HistoryListItemEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$HistoryListEntityToJson(HistoryListEntity instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

HistoryListItemEntity _$HistoryListItemEntityFromJson(
    Map<String, dynamic> json) {
  return HistoryListItemEntity(
    json['id'] as String,
    json['channelid'] as int,
    json['filename'] as String,
    json['url'] as String,
    json['userInfo'] == null
        ? null
        : UserInfo.fromJson(json['userInfo'] as Map<String, dynamic>),
    json['history'] == null
        ? null
        : HistoryRecord.fromJson(json['history'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$HistoryListItemEntityToJson(
        HistoryListItemEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'channelid': instance.channelid,
      'filename': instance.filename,
      'url': instance.url,
      'userInfo': instance.userInfo,
      'history': instance.history,
    };

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo(
    json['nickname'] as String,
  );
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'nickname': instance.nickname,
    };

HistoryRecord _$HistoryRecordFromJson(Map<String, dynamic> json) {
  return HistoryRecord(
    json['title'] as String,
  );
}

Map<String, dynamic> _$HistoryRecordToJson(HistoryRecord instance) =>
    <String, dynamic>{
      'title': instance.title,
    };

MyRoomDetails _$MyRoomDetailsFromJson(Map<String, dynamic> json) {
  return MyRoomDetails(
    json['id'] as String,
    json['number'] as String,
    json['topic'] as String,
    json['nickname'] as String,
    json['city'] as String,
    json['birthday'] as String,
    json['descFile'] as String,
    json['cid'] as String,
    json['state'] as int,
    json['total'] as int,
    json['userId'] as String,
    json['mode'] as int,
    json['chatroomState'] as int,
    json['subscribed'] as int,
    json['age'] as int,
  );
}

Map<String, dynamic> _$MyRoomDetailsToJson(MyRoomDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'topic': instance.topic,
      'nickname': instance.nickname,
      'city': instance.city,
      'birthday': instance.birthday,
      'descFile': instance.descFile,
      'cid': instance.cid,
      'state': instance.state,
      'total': instance.total,
      'userId': instance.userId,
      'mode': instance.mode,
      'chatroomState': instance.chatroomState,
      'subscribed': instance.subscribed,
      'age': instance.age,
    };
