import 'package:bleflutter/bleflutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassapp/base.dart';
import 'package:glassapp/utils/network_model.dart';
import 'package:glassapp/bean/glass_bind.dart';
import 'package:glassapp/bean/json_entity.dart';
import 'package:glassapp/utils/shared_preferences.dart';
import 'package:glassapp/utils/log.dart';
import 'package:rxdart/rxdart.dart';

class ScanBluetoothProvider extends BaseProvider implements BleCallback {
  SpCaller caller;

  ScanBluetoothProvider(this.caller);

  GlassBindEntity _bindEntity;

  GlassBindEntity get bindEntity => _bindEntity;

  set bindEntity(GlassBindEntity value) {
    _bindEntity = value;
    notifyListeners();
  }

  List<BleDevice> _devList = List();

  List<BleDevice> get devList => _devList;

  set devList(List<BleDevice> d) {
    _devList = d;
    notifyListeners();
  }

  BleDevice _myDevList;

  BleDevice get myDevList => _myDevList;

  set myDevList(BleDevice value) {
    _myDevList = value;
    notifyListeners();
  }

  Color getAnimColor(int pos, double d) {
    switch (pos) {
      case 0:
        return Color.fromRGBO(247, 247, 247, 0.4);
      case 1:
        return Color.fromRGBO(247, 247, 247, 0.3);
      case 2:
        return Color.fromRGBO(247, 247, 247, 0.2);
      case 3:
        return Color.fromRGBO(247, 247, 247, 0.1);
      default:
        return Colors.transparent;
    }
  }

  Observable bindGlassList() =>
      serverBindGlassList(caller.getString("token")).doOnData((event) {
        Log.i(event);
        var entity = BaseEntity.fromJson(event);
        if (entity.success) {
          if(entity.toBody().data==null){
            caller.putBool("bind", false);
            caller.putString("device-mac", "");
          }else{
            bindEntity = GlassBindEntity.formJson(entity.toBody().data);
            Bleflutter.connect(bindEntity.mac);
            caller.putBool("bind", true);
            caller.putString("device-mac", bindEntity.mac);
          }
        }
      });

  Observable bindGlass(BleDevice device) =>
      serverBindGlass(caller.getString("token"), device.mac).doOnData((event) {
        Log.e(event);

        var entity = BaseEntity.fromJson(event);
        if (entity.success) {
          myDevList = device;
          devList.remove(device);
          caller.putString("device-mac", device.mac);
          caller.putBool("bind", true);
          notifyListeners();
        } else {
          Bleflutter.disConnect(device.mac);
          device.state = -1;
          notifyListeners();
        }
      });

  Observable unbindGlass() =>
      serverUnbindGlass(caller.getString("token")).doOnData((event) {
        Log.e(event);
        var entity = BaseEntity.fromJson(event);
        if (entity.success) {
          if (myDevList != null) Bleflutter.disConnect(myDevList.mac);
          myDevList = null;
          caller.putString("device-mac", null);
          caller.putBool("bind", true);
          notifyListeners();
        }
      });

  @override
  void clearScanResult() {
    List<BleDevice> last = List();
    devList.forEach((element) {
      if (element.state == 1 || element.state == 0) {
        last.add(element);
      }
    });
    devList.clear();
    devList.addAll(last);
    notifyListeners();
  }

  @override
  void connectState(String mac, String name, int state) {
    devList.forEach((element) {
      if (element.mac == mac) {
        element.name = name;
        element.state = state;
      }
    });
    if (myDevList.mac == mac) {
      myDevList.name = name;
      myDevList.state = state;
    }
    if (state == 1) {
      myDevList = BleDevice(name, mac, state: state);
      notifyListeners();
    }
    notifyListeners();
  }

  @override
  void putScanResult(String mac, String name) {
    if (name.startsWith("AE-")) {
      devList.add(BleDevice(name, mac));
      notifyListeners();
    }
  }

  @override
  void putScanList(List<BleDevice> devices) {}
}
