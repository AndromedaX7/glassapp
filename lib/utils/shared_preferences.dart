import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';


abstract class SpCaller {
  Future _init({String path});

  bool beforeCheck();

  bool hasKey(String key);

  Set<String> getKeys();

  get(String key);

  Future<bool> putBool(String key, bool value);

  Future<bool> putString(String key, String value);

  Future<bool> putStringList(String key, List<String> value);

  Future<bool> putInt(String key, int value);

  Future<bool> putDouble(String key, double value);

  String getString(String key);

  double getDouble(String key);

  int getInt(String key);

  bool getBool(String key, bool def);

  List<String> getStringList(String key);

  static Future<SpCaller> getInstance() async {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        return await Mobile.getInstance();
      } else if (Platform.isWindows || Platform.isLinux) {
        return await Desktop.getInstance(path: ".");
      } else if (Platform.isMacOS) {
        return await Desktop.getInstance(path: ".");
      } else {
        return null;
      }
    } catch (e) {
      return Web.getInstance();
    }
  }
}

class Mobile extends SpCaller {
  Mobile._();

  static SpCaller _instance;

  static Future<SpCaller> get instance async {
    return await getInstance();
  }

  Future _init({String path}) async {
    _spf = await SharedPreferences.getInstance();
  }

  static SharedPreferences _spf;

  static Future<SpCaller> getInstance() async {
    if (_instance == null) {
      _instance = new Mobile._();
      await _instance._init();
    }
    return _instance;
  }

  bool hasKey(String key) {
    Set keys = getKeys();
    return keys.contains(key);
  }

  Set<String> getKeys() {
    if (beforeCheck()) return null;
    return _spf.getKeys();
  }

  get(String key) {
    if (beforeCheck()) return null;
    return _spf.get(key);
  }

  Future<bool> putBool(String key, bool value) {
    if (beforeCheck()) return null;
    return _spf.setBool(key, value);
  }

  Future<bool> putString(String key, String value) {
    if (beforeCheck()) return null;
    return _spf.setString(key, value);
  }

  Future<bool> putStringList(String key, List<String> value) {
    if (beforeCheck()) return null;
    return _spf.setStringList(key, value);
  }

  Future<bool> putInt(String key, int value) {
    if (beforeCheck()) return null;
    return _spf.setInt(key, value);
  }

  Future<bool> putDouble(String key, double value) {
    if (beforeCheck()) return null;
    return _spf.setDouble(key, value);
  }

  String getString(String key) {
    if (beforeCheck()) return null;
    return _spf.getString(key);
  }

  double getDouble(String key) {
    if (beforeCheck()) return 0;
    return _spf.getDouble(key);
  }

  int getInt(String key) {
    if (beforeCheck()) return 0;
    return _spf.getInt(key);
  }

  bool getBool(String key, bool def) {
    if (beforeCheck()) return def;
    return _spf.getBool(key);
  }

  List<String> getStringList(String key) {
    if (beforeCheck()) return null;
    return _spf.getStringList(key);
  }

  @override
  bool beforeCheck() {
    return (_spf == null);
  }
}

class Desktop extends SpCaller {
  String filePath() {
    return ".";
  }

  static Map<String, dynamic> _spf;

  static File _spFile;

  Desktop._();

  Future _init({String path}) async {
    _spf = Map();
    File file = File(path);
    String dirPath = dirname(file.absolute.path);
    _spFile = File(dirPath + "/.flutter");
    print(dirPath);
    return await _spFile.create();
  }

  static SpCaller _instance;

  static Future<SpCaller> get instance async {
    return await getInstance();
  }

  static Future<SpCaller> getInstance({String path = "."}) async {
    if (_instance == null) {
      _instance = new Desktop._();
      await _instance._init(path: path);
      await readFile();
    }
    return _instance;
  }

  @override
  bool beforeCheck() {
    return !_spFile.existsSync() || _spf == null;
  }

  @override
  get(String key) {
    if (!beforeCheck()) {
      return _spf.containsKey(key) ? _spf[key] : null;
    }
  }

  @override
  bool getBool(String key, bool def) {
    if (!beforeCheck()) {
      var r = get(key);
      if (r == null)
        return def;
      else
        return r;
    } else
      return def;
  }

  @override
  double getDouble(String key) {
    if (!beforeCheck()) {
      var r = get(key);
      if (r == null)
        return 0;
      else
        return r;
    } else
      return 0;
  }

  @override
  int getInt(String key) {
    if (!beforeCheck()) {
      var r = get(key);
      if (r == null)
        return 0;
      else
        return r;
    } else
      return 0;
  }

  @override
  Set<String> getKeys() {
    if (!beforeCheck()) {
      return _spf.keys;
    } else
      return Set();
  }

  @override
  String getString(String key) {
    if (!beforeCheck()) {
      var r = get(key);
      if (r == null)
        return "";
      else
        return r;
    } else
      return "";
  }

  @override
  List<String> getStringList(String key) {
    if (!beforeCheck()) {
      var r = get(key);
      if (r == null)
        return List();
      else
        return r;
    } else
      return List();
  }

  @override
  bool hasKey(String key) {
    if (!beforeCheck()) {
      return _spf.containsKey(key);
    } else
      return false;
  }

  @override
  Future<bool> putBool(String key, bool value) {
    if (!beforeCheck()) {
      _spf[key] = value;
      try {
        _writeFile();
        return Future.value(true);
      } catch (e) {
        return Future.value(false);
      }
    } else {
      return Future.value(false);
    }
  }

  @override
  Future<bool> putDouble(String key, double value) {
    if (!beforeCheck()) {
      _spf[key] = value;
      try {
        _writeFile();
        return Future.value(true);
      } catch (e) {
        return Future.value(false);
      }
    } else {
      return Future.value(false);
    }
  }

  @override
  Future<bool> putInt(String key, int value) {
    if (!beforeCheck()) {
      _spf[key] = value;
      try {
        _writeFile();
        return Future.value(true);
      } catch (e) {
        return Future.value(false);
      }
    } else {
      return Future.value(false);
    }
  }

  @override
  Future<bool> putString(String key, String value) {
    if (!beforeCheck()) {
      _spf[key] = value;
      try {
        _writeFile();
        return Future.value(true);
      } catch (e) {
        return Future.value(false);
      }
    } else {
      return Future.value(false);
    }
  }

  @override
  Future<bool> putStringList(String key, List<String> value) {
    if (!beforeCheck()) {
      _spf[key] = value;
      try {
        _writeFile();
        return Future.value(true);
      } catch (e) {
        return Future.value(false);
      }
    } else {
      return Future.value(false);
    }
  }

  static void _writeFile() {
    _spFile.writeAsString(json.encode(_spf), mode: FileMode.write, flush: true);
  }

  static Future readFile() {
    return _spFile.readAsString().then((value) {
      print(">>" + value);
      if (value != null && value != "") _spf = json.decode(value);
      print(_spf.keys.toString());
      _spf.forEach((key, value) {
        print(key + "::" + value);
      });
    });
  }
}

class Web extends SpCaller {
  static SpCaller _instance;
//  static html.Storage _spf;
  static Map<String,dynamic> _spf;
  static Future<SpCaller> get instance async {
    return await getInstance();
  }

  static Future<SpCaller> getInstance({String path = ""}) async {
    if (_instance == null) {
      _instance = new Web._();
      await _instance._init(path: path);
    }
    return _instance;
  }

  Web._() : super();

  @override
  Future _init({String path}) {
//    dio.httpClientAdapter = BrowserHttpClientAdapter()..withCredentials = true;
//    dio.options=BaseOptions(connectTimeout:60000,sendTimeout: 60000,receiveTimeout: 60000);
//    return Future.value(_spf = html.window.localStorage);
    return Future.value(_spf =Map());
  }

  @override
  bool beforeCheck() {
    return (_spf == null);
  }

  @override
  get(String key) {
    if (beforeCheck()) return null;
    return _spf[key];
  }

  @override
  bool getBool(String key, bool def) {
    var v = get(key);
    return v == null ? def : v;
  }

  @override
  double getDouble(String key) {
    var v = get(key);
    return v == null ? 0 : v;
  }

  @override
  int getInt(String key) {
    var v = get(key);
    return v == null ? 0 : v;
  }

  @override
  Set<String> getKeys() {
    if (beforeCheck()) return Set();
    return _spf.keys;
  }

  @override
  String getString(String key) {
    var v = get(key);
    return v == null ? "" : v;
  }

  @override
  List<String> getStringList(String key) {
    var v = get(key);
    return v == null ? List() : v;
  }

  @override
  bool hasKey(String key) {
    if (beforeCheck()) return false;
    return _spf.containsKey(key);
  }

  bool put(String key, value) {
    if (beforeCheck()) return false;
    _spf[key] = value;
    return true;
  }

  @override
  Future<bool> putBool(String key, bool value) {
    return Future.value(put(key, value));
  }

  @override
  Future<bool> putDouble(String key, double value) {
    return Future.value(put(key, value));
  }

  @override
  Future<bool> putInt(String key, int value) {
    return Future.value(put(key, value));
  }

  @override
  Future<bool> putString(String key, String value) {
    return Future.value(put(key, value));
  }

  @override
  Future<bool> putStringList(String key, List<String> value) {
    return Future.value(put(key, value));
  }
}
