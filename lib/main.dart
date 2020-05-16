import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glassapp/app/app.dart';
import 'package:glassapp/di/app_module.dart';
import 'package:glassapp/utils/log.dart';
import 'package:provider/provider.dart';

void main() async {
  // if(kIsWeb){
  //   serverUrl="http://192.168.31.32:8080/";
  // }
  Log.logLevel = Log.log_level_verbose;
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  Provider.debugCheckInvalidValueType = null;
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  runApp(App());
}
