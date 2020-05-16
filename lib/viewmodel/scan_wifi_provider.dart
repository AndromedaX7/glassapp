import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassapp/base.dart';
import 'package:glassapp/utils/shared_preferences.dart';
import 'package:glassapp/viewmodel/scan_bluetooth_provider.dart';

class ScanWifiProvider extends BaseProvider {
  int _devices = 2;
  int _otherDevices = 20;

  int get otherDevices => _otherDevices;

  set otherDevices(int value) {
    _otherDevices = value;
    notifyListeners();
  }

  int get devices => _devices;

  set devices(int value) {
    _devices = value;
    notifyListeners();
  }

  final ScanBluetoothProvider _bluetoothProvider;
  final SpCaller _caller;


  ScanWifiProvider(this._bluetoothProvider, this._caller);

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
}
