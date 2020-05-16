
import 'package:glassapp/base.dart';

import 'app_themes.dart';

class SelfInfoProvider extends BaseProvider {
  AppThemes appThemes;

  String _myIcon="http://47.104.232.219//contact/img/c274b6c01e9a49448c89eaef37bd638b";

  String get myIcon => _myIcon;

  String _nickName;

  String get nickName => _nickName;

  set nickName(String nickName) {
    _nickName = nickName;
    notifyListeners();
  }

  set myIcon(String icon) {
    _myIcon = icon;
    notifyListeners();
  }

  SelfInfoProvider(this.appThemes);
}
