import 'package:glassapp/utils/network_model.dart';
import 'package:glassapp/utils/shared_preferences.dart';
import 'package:glassapp/base.dart';
import 'package:rxdart/rxdart.dart';

class BindPersonProvider extends BaseProvider{
  final SpCaller caller;

  BindPersonProvider(this.caller);

  Observable addNew(String mobile,String password) =>serverGuardianshipAdd(caller.getString("token"),mobile,password)
      .doOnData((event) { })
      .doOnDone(() { });

  Observable deleteOne(){ }
}