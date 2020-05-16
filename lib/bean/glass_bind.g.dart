// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glass_bind.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GlassBindEntity _$GlassBindEntityFromJson(Map<String, dynamic> json) {
  return GlassBindEntity(
    json['id'] as String,
    json['deviceCategory'],
    json['typeId'] as String,
    json['number'] as String,
    json['state'] as String,
    json['userId'] as String,
    json['mac'] as String,
    json['ssid'] as String,
    json['pass'] as String,
    json['status'],
    json['model'],
    json['firmware'],
    json['rtmpres'],
    json['capres'],
    json['battery'],
    json['mode'],
    json['modever'],
    json['onlineStatus'],
  );
}

Map<String, dynamic> _$GlassBindEntityToJson(GlassBindEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deviceCategory': instance.deviceCategory,
      'typeId': instance.typeId,
      'number': instance.number,
      'state': instance.state,
      'userId': instance.userId,
      'mac': instance.mac,
      'ssid': instance.ssid,
      'pass': instance.pass,
      'status': instance.status,
      'model': instance.model,
      'firmware': instance.firmware,
      'rtmpres': instance.rtmpres,
      'capres': instance.capres,
      'battery': instance.battery,
      'mode': instance.mode,
      'modever': instance.modever,
      'onlineStatus': instance.onlineStatus,
    };
