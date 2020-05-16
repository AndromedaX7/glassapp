import 'package:glassapp/base.dart';
import 'package:glassapp/utils/network_model.dart';
import 'package:glassapp/bean/json_entity.dart';
import 'package:glassapp/utils/log.dart';
import 'package:glassapp/viewmodel/app_themes.dart';
import 'package:glassapp/viewmodel/home_provider.dart';
import 'package:rxdart/rxdart.dart';


class SettingsProvider extends BaseProvider {
  String title;

  AppThemes appThemes;
  SettingsEntity _data;


  set data(SettingsEntity data) {
    _data = data;
    notifyListeners();
  }

  SettingsEntity  get data => _data;
  final HomeProvider _home;
  SettingsProvider(this.title, this.appThemes,this._home);

  Observable settings() => serverSettings()
      .doOnDone(() {})
      .doOnData(
        (event) {

          Log.i(event);

          BaseEntity settings =BaseEntity.fromJson(event);
          if (settings.success) {
            data = SettingsEntity.fromJson(settings.toBody().data);
          }
        },
      )
      .doOnError((e) {})
      .doOnListen(() {});

  void logout(){
    _home.userState=0;
  }
}
