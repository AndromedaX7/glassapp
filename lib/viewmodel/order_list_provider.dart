import 'package:glassapp/utils/network_model.dart';
import 'package:glassapp/bean/json_entity.dart';
import 'package:glassapp/utils/shared_preferences.dart';
import 'package:glassapp/utils/log.dart';
import 'package:glassapp/base.dart';
import 'package:glassapp/viewmodel/refresh_viewmodel_mixin.dart';
import 'package:rxdart/rxdart.dart';

class OrderListProvider extends BaseProvider with RefreshViewModelMixin {
  final SpCaller caller;

  OrderListProvider(this.caller);

  List<OrderEntity> _list = List();

  List<OrderEntity> get list => _list;

  set list(List<OrderEntity> list) {
    _list.addAll(list);
    notifyListeners();
  }

  Observable _orderList({String state = ""}) =>
      serverOrderList(caller.getString("token"), page, state: state)
          .doOnError((e) {
        Log.v(e);
      }).doOnData((event) {
        Log.v(event);
        var entity = BaseEntity.fromJson(event);
        if (entity.success) {
          var listEntity = OrderListEntity.fromJson(entity.toBody().data);

          list = listEntity.list;
          canLoad = listEntity.pageNo * listEntity.pageSize < listEntity.count;
        } else {
          canLoad = false;
        }
      });

  @override
  dataClear() {
    list.clear();
  }

  Future<dynamic> orderList(int pos) {
    String state = "";
    switch (pos) {
      case 1:
        state = "0";
        break;
      case 2:
        state = "1";
        break;
      case 3:
        state = "2";
        break;
      case 4:
        state = "3";
        break;
      default:
        state = "";
    }
    return _orderList(state: state).listen((event) {}).asFuture();
  }

  String stateName(int state) {
    String name = "";
    switch (state) {
      case -1:
        name = "交易关闭";
        break;
      case 0:
        name = "等待买家付款";
        break;
      case 1:
        name = "等待卖家发货";
        break;
      case 2:
        name = "卖家已发货";
        break;
      case 3:
        name = "卖家退款中";
        break;
      case 4:
        name = "卖家已退款";
        break;
      case 5:
        name = "交易成功";
        break;
    }
    return name;
  }
}
