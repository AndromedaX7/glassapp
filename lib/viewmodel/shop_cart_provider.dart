import 'package:glassapp/utils/network_model.dart';
import 'package:glassapp/bean/json_entity.dart';
import 'package:glassapp/utils/shared_preferences.dart';
import 'package:glassapp/utils/log.dart';
import 'package:glassapp/base.dart';
import 'package:rxdart/rxdart.dart';

class ShopCartProvider extends BaseProvider {
  final SpCaller caller;

  List<CartWrapper> _select = List();

  List<CartWrapper> get select => _select;
  bool _check = false;

  get check => _check;

  set check(bool check) {
    _check = check;
    notifyListeners();
  }

  double _yuan = 0;

  get yuan => _yuan;

  void setShopCheck(int pos, bool check) {
    _yuan = 0;
    _select[pos].check = check;
    for (int i = 0; i < _select[pos].data.length; i++) {
      _select[pos].data[i].check = check;
    }
    int hasCheckAll = 0;
    for (int i = 0; i < select.length; i++) {
      if (select[i].check) {
        hasCheckAll++;
      }
      for (int j = 0; j < select[i].data.length; j++) {
        var item = select[i].data[j];
        if (item.check) {
          _yuan += (item.item.amount * item.item.goodsInfo.price);
        }
      }
    }
    this.check = (hasCheckAll == select.length);
    notifyListeners();
  }

  void changed(int pos, int goods, bool check) {
    var item = _select[pos];
    var goodsItem = item.data[goods];
    goodsItem.check = check;
    int hasChecked = 0;
    for (int i = 0; i < item.data.length; i++) {
      if (item.data[i].check) {
        hasChecked++;
      }
    }
    item.check = hasChecked > 0;

    _yuan = 0;
    int hasCheckAll = 0;
    for (int i = 0; i < select.length; i++) {
      if (select[i].check) {
        hasCheckAll++;
      }

      for (int j = 0; j < select[i].data.length; j++) {
        var item = select[i].data[j];
        if (item.check) {
          _yuan += (item.item.amount * item.item.goodsInfo.price);
        }
      }
    }
    Log.d("$hasCheckAll == ${select.length}");
    this.check = (hasCheckAll == select.length);
    notifyListeners();
  }

  List<GoodsCartEntity> _list = List();

  List<GoodsCartEntity> get list => _list;

  set list(List<GoodsCartEntity> list) {
    _list = list;
    notifyListeners();
  }

  ShopCartProvider(this.caller);

  Observable cartPage() => serverGoodsCart(caller.getString("token"), 1)
          .doOnDone(() {})
          .doOnData((event) {
        Log.v(event);
        var entity = BaseEntity.fromJson(event);
        if (entity.success) {
          var listEntity = GoodsCartListEntity.fromJson(entity.toBody().data);
          list = listEntity.list;
          for (int i = 0; i < list.length; i++) {
            var details = list[i].details;
            List<CartSelect> item = List();
            for (int j = 0; j < details.length; j++) {
              item.add(CartSelect(false, details[j]));
            }
            _select.add(CartWrapper(item, false));
          }
          notifyListeners();
        }
      });

  void checkAll(bool v) {
    _yuan = 0;
    for (int i = 0; i < select.length; i++) {
      for (int j = 0; j < select[i].data.length; j++) {
        var item = select[i].data[j];
        item.check = v;
        if (item.check) {
          _yuan += (item.item.amount * item.item.goodsInfo.price);
        }
      }
      select[i].check = v;
    }
    check = v;
  }
  Observable updateCart(String goodsId,int count,{String propId} )=>serverAddToCart(caller.getString("token"),goodsId,count,propertyId: propId)
      .doOnDone(() { })
      .doOnData((event) {
    Log.d(event);
  });

  Observable buy(){}

  void notifyItem(){

    _yuan = 0;
    for (int i = 0; i < select.length; i++) {
      for (int j = 0; j < select[i].data.length; j++) {
        var item = select[i].data[j];
        if (item.check) {
          _yuan += (item.item.amount * item.item.goodsInfo.price);
        }
      }
    }

    notifyListeners();
  }
}

class CartSelect {
  bool check;
  CartEntity item;

  CartSelect(this.check, this.item);
}

class CartWrapper {
  List<CartSelect> data;
  bool check;

  CartWrapper(this.data, this.check);
}
