
import 'package:glassapp/utils/network_model.dart';
import 'package:glassapp/bean/json_entity.dart';
import 'package:glassapp/utils/shared_preferences.dart';
import 'package:glassapp/base.dart';
import 'package:rxdart/rxdart.dart';

class ShopMineProvider extends BaseProvider {
  final SpCaller caller;
  List<int> _count = [
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
    0,
  ];

  get count => _count;

  set count(OrderCountEntity data) {
    _count[3] = data.unpay;
    _count[4] = data.pay;
    _count[5] = data.package;
    _count[6] = data.evaluate;
    _count[7] = data.canRefund;
    _count[8] = (data.unpay + data.pay + data.package + data.evaluate+data.canRefund);
    notifyListeners();
  }

  ShopMineProvider(this.caller);

  Observable getOrderCount() => serverOrderCount(caller.getString("token"))
      .doOnData((event) {
        var resp = BaseEntity.fromJson(event) ;
        
        if (resp.success) {
          count = OrderCountEntity.fromJson(resp.toBody().data);
        }
      })
      .doOnDone(() {})
      .doOnError((e) {})
      .doOnListen(() {});
}
