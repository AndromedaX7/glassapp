// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advert_json.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdvertListEntity _$AdvertListEntityFromJson(Map<String, dynamic> json) {
  return AdvertListEntity(
    json['id'] as String,
    json['picUrl'] as String,
    json['fileUrl'] as String,
  );
}

Map<String, dynamic> _$AdvertListEntityToJson(AdvertListEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'picUrl': instance.picUrl,
      'fileUrl': instance.fileUrl,
    };

AdvertListWrapper _$AdvertListWrapperFromJson(Map<String, dynamic> json) {
  return AdvertListWrapper(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : AdvertListEntity.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AdvertListWrapperToJson(AdvertListWrapper instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
