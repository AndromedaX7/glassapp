import 'dart:collection';
import 'dart:math';

import 'package:glassapp/utils/network_model.dart';
import 'package:glassapp/bean/json_entity.dart';
import 'package:glassapp/utils/shared_preferences.dart';
import 'package:glassapp/utils/log.dart';
import 'package:glassapp/base.dart';
import 'package:rxdart/rxdart.dart';

class GoodsPropertiesBottomSheetProvider extends BaseProvider {
  SpCaller caller;

  int _selectCount = 1;

  get selectCount => _selectCount;

  set selectCount(int selected) {
    _selectCount = selected;
    notifyListeners();
  }

  GoodsPropertiesBottomSheetProvider(this.caller);

  Map<String, HashSet<String>> get properties => _propItem;

  Map<String, String> cacheId = Map();
  Map<String, GoodsPropertyEntity> currentProps = Map();
  Map<String, HashSet<String>> _propItem = Map();
  int _propCount = 0;
  Map<String, String> _selectedProp = Map();
  List<String> _propKey;

  get selectedProp => _selectedProp;
  GoodsPropertyEntity _currentProp;

  set currentProp(GoodsPropertyEntity p) {
    _currentProp = p;
    notifyListeners();
  }

  GoodsPropertyEntity  get currentProp => _currentProp;
//  List _list;

  set propertiesList(List<GoodsPropertyEntity> list) {
 // if (list == _list) {
 //   return;
 // } else {
 //   _list = list;
 //   cacheId = Map();
 //   currentProps = Map();
 //   _propItem = Map();
 //   _propCount = 0;
 //   _selectedProp = Map();
 //   _currentProp = null;
 //   selectCount=1;
 // }
    list.forEach((element) {
      var currentName = element.name
          .replaceAll("{", "")
          .replaceAll("}", "")
          .replaceAll("\"", "");
      List<String> keyValuePair = currentName.split(",");
      currentProps[element.id] = element;
      _propCount = max(_propCount, keyValuePair.length);
      StringBuffer idProp = StringBuffer();
      keyValuePair.forEach((item) {
        var keyValue = item.split(":");
        var key = keyValue[0];
        var value = keyValue[1];
        idProp.write(value);
        var set = _propItem[key];
        if (set == null) {
          set = HashSet();
          _propItem[key] = set;
        }
        set.add(value);
      });
      cacheId[idProp.toString()] = element.id;
    });
    _propKey = List(_propCount);
  }

  String _goodsPropName;

  get goodsPropName => _goodsPropName;

  set goodsPropName(String propName) {
    _goodsPropName = propName;
    notifyListeners();
  }

  double _goodsPrice = 0;

  get goodsPrice => _goodsPrice;

  set goodsPrice(double goodsPrice) {
    _goodsPrice = goodsPrice;
    notifyListeners();
  }

  void selected(int idx, String key, String name) {
    _selectedProp[key] = name;
    _propKey[idx] = name;

    currentProp = currentProps[cacheId[_propKey.join()]];
    if (_currentProp != null) {
      goodsPrice = _currentProp.price;
      goodsPropName = _propKey.join("/");
      if(_selectCount>_currentProp.stock){
        selectCount=currentProp.stock;
      }
    }
    notifyListeners();
  }

  Observable addToCart(String goodsId,int count,{String propId} )=>serverAddToCart(caller.getString("token"),goodsId,count,propertyId: propId)
      .doOnDone(() { })
      .doOnData((event) {
        Log.d(event);
  });
}
