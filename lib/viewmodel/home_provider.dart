import 'package:bleflutter/bleflutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassapp/base.dart';
import 'package:glassapp/local.dart';
import 'package:glassapp/utils/network_model.dart';
import 'package:glassapp/bean/json_entity.dart';
import 'package:glassapp/utils/shared_preferences.dart';
import 'package:glassapp/utils/log.dart';
import 'package:glassapp/viewmodel/scan_bluetooth_provider.dart';
import 'package:rxdart/rxdart.dart';

class HomeProvider extends BaseProvider implements BleCallback {
  final SpCaller caller;

  String _temperature = "--";

  String _text = "--";

  int _userState = 0;
  String _phone = "";
  UserEntity userInfo;
  set userPhone(String phone) {
    _phone = phone;
    notifyListeners();
  }

  get password => _password;

  String _password = "";
  set password(String password) {
    _password = password;
    notifyListeners();
  }

  get currentAuth => _currentAuth;

  String _currentAuth = "";
  set currentAuth(String pos) {
    _currentAuth = pos;
    notifyListeners();
  }

  get userPhone => _phone;

  get userState => _userState;

  set userState(int pos) {
    _userState = pos;
    notifyListeners();
  }

  set userName(String userName) {
    _userName = userName;
    notifyListeners();
  }

  String _userName = "";

  String validateUserName() {
    if (_userName != null && _userName != '')
      return null;
    else {
      return "请输入昵称";
    }
  }

  final ScanBluetoothProvider _bluetoothProvider;

  int _currentPosition = 0;

  int get currentPosition => _currentPosition;

  set currentPosition(int value) {
    _currentPosition = value;
    notifyListeners();
  }

  ScanBluetoothProvider get bluetoothProvider => _bluetoothProvider;

  String get text => _text;

  set text(String value) {
    _text = value;
    notifyListeners();
  }

  String get temperature => _temperature;

  set temperature(String value) {
    _temperature = value;
    notifyListeners();
  }

  String _city = "定位中";

  String get city => _city;

  set city(String value) {
    _city = value;
    getWeather().listen((_) {});
  }

  String _location = "";

  String get location => _location;

  set location(String value) {
    _location = value;
    notifyListeners();
  }

  int _page = 0;

  int get page => _page;

  set page(int p) {
    _page = p;
    notifyListeners();
  }

  String validatePhone() {
    if (_phone == null || _phone == '')
      return "请输入手机号码";
    else if (_phone.length != 11)
      return "手机号长度不正确";
    else {
      return null;
    }
  }

  String validatePassword() {
    if (_password == null || _password == '')
      return "请输入密码";
    else {
      return null;
    }
  }

  bool _userMode = true;

  get userMode => _userMode;

  set userMode(bool mode) {
    _userMode = mode;
    notifyListeners();
  }

  List<GuardianEntity> get mGuardianList => _guardianList;

  set mGuardianList(List<GuardianEntity> list) {
    _guardianList = list;
    notifyListeners();
  }

  List<GuardianEntity> _guardianList = List();

  HomeProvider(this.caller, this._bluetoothProvider) {
    bindInit();
    Bleflutter.isBlueEnable().then((v) {
      bluetoothState = v ? 0 : -1;
    });
  }
  bool _checkAgreement = true;
  get checkAgreement => _checkAgreement;

  set checkAgreement(bool check) {
    _checkAgreement = check;
    notifyListeners();
  }

  // -1 close 0 open 1 connect
  int _bluetoothState = -1;
  bool _wlanState = false;
  bool _bind = false;
  int _battery = 10;

  bool get bind => _bind;

  int get bluetoothState => _bluetoothState;

  bool get wlanState => _wlanState;

  int get battery => _battery;

  set battery(int v) {
    _battery = v;
    notifyListeners();
  }

  set bluetoothState(int state) {
    _bluetoothState = state;
    notifyListeners();
  }

  set wlanState(bool b) {
    _wlanState = b;
    notifyListeners();
  }

  set bind(bool bind) {
    _bind = bind;
    notifyListeners();
  }

  Observable getWeather() => serverWeather(city).doOnData((e) {
        var entity = WeatherEntity.fromJson(e);
        if (entity.results.isNotEmpty) {
          temperature = entity.results[0].getTemperature();
          text = entity.results[0].getText();
        }
      });

  Color getAnimColor(double value) {
    if (value <= 68) {
      return Color(0xffc8c8c8);
    } else if (value > 68 && value <= 104) {
      return Color(0xffd0d0d0);
    } else if (value > 104 && value <= 146) {
      return Color(0xffe4e4e4);
    } else if (value > 146) {
      return Color(0xffefefef);
    } else {
      return Colors.transparent;
    }
  }

  void saveToken(value) {
    caller.putString("token", value);
  }

  void initConnect() {
    if (_bluetoothProvider.myDevList == null) {
      Bleflutter.processCallback(this);
      Bleflutter.scan();
    } else {
      Bleflutter.enableBluetooth();
    }
  }

  @override
  void clearScanResult() {}

  @override
  void connectState(String mac, String name, int state) {
    Log.i("mac $mac state $state");
    if (mac == caller.getString("device-mac")) {
      _bluetoothProvider.myDevList = BleDevice(name, mac, state: state);
      bluetoothState = 1;
    }
  }

  @override
  void putScanResult(String mac, String name) {}

  void bindInit() {
    _bind = caller.getBool("bindDevice", false) ?? false;
  }

  bool _continueScan = true;

  @override
  void putScanList(List<BleDevice> devices) {
    devices.forEach((e) {
      if (e.mac == caller.getString("device-mac")) {
        _continueScan = false;
        Bleflutter.connect(e.mac);
      }
    });
    if (_continueScan) {
      Bleflutter.scan();
    }
  }

  void scanBindDevice() {
    if (bluetoothState == 0) {
      Bleflutter.scan();
    }
  }

  Observable login() => serverLogin(_phone, _password, userMode ? 1 : 2)
      .doOnData((r) {
        var entity = BaseEntity.fromJson(r);
        Log.v(r);
        if (entity.success) {
          var body = LoginBody.fromJson(entity.body);
          userInfo = body.user;
          userState = userInfo.userType == 1 ? 2 : 3;
          currentPosition = 0;
          caller.putString("token", body.token);
          caller.putString("account", _phone);
          caller.putString("password", _password);
          if (userInfo.userType == 2) {
            guardianList().listen((event) {});
          }
        } else {
          LocalChannel.toast(entity.msg);
        }
      })
      .doOnError((e, stacktrace) {})
      .doOnListen(() {})
      .doOnDone(() {});

  Observable guardianList() =>
      serverGuardianshipList(caller.getString("token"), 1)
          .doOnListen(() {})
          .doOnData((event) {
        Log.i(event);

        var entity = BaseEntity.fromJson(event);
        if (entity.success) {
          var listEntity = GuardianListEntity.fromJson(entity.toBody().data);
          mGuardianList = listEntity.list;
        }
      }).doOnError((onError) {});
}
