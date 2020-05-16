import 'package:json_annotation/json_annotation.dart';

part 'glass_bind.g.dart';

@JsonSerializable()
class GlassBindEntity {
  String id;
  dynamic deviceCategory;
  String typeId;
  String number;
  String state;
  String userId;
  String mac;
  String ssid;
  String pass;
  dynamic status;
  dynamic model;

  dynamic firmware;
  dynamic rtmpres;
  dynamic capres;

  GlassBindEntity(
      this.id,
      this.deviceCategory,
      this.typeId,
      this.number,
      this.state,
      this.userId,
      this.mac,
      this.ssid,
      this.pass,
      this.status,
      this.model,
      this.firmware,
      this.rtmpres,
      this.capres,
      this.battery,
      this.mode,
      this.modever,
      this.onlineStatus);

  dynamic battery;
  dynamic mode;
  dynamic modever;
  dynamic onlineStatus;

  factory GlassBindEntity.formJson(Map<String, dynamic> json) =>
      _$GlassBindEntityFromJson(json);
}
