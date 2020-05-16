import 'package:json_annotation/json_annotation.dart';

part 'advert_json.g.dart';

@JsonSerializable()
class AdvertListEntity {
  String id;
  String picUrl;
  String fileUrl;

  AdvertListEntity(this.id, this.picUrl, this.fileUrl);

  factory AdvertListEntity.fromJson(Map<String, dynamic> json) =>
      _$AdvertListEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AdvertListEntityToJson(this);
}

@JsonSerializable()
class AdvertListWrapper {
  List<AdvertListEntity> data;

  AdvertListWrapper(this.data);

  factory AdvertListWrapper .fromJson(Map<String,dynamic>json)=>_$AdvertListWrapperFromJson(json);

}
