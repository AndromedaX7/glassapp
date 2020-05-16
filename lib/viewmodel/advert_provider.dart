import 'package:glassapp/base.dart';
import 'package:glassapp/utils/network_model.dart';
import 'package:glassapp/bean/advert_json.dart';
import 'package:glassapp/bean/json_entity.dart';
import 'package:glassapp/utils/shared_preferences.dart';
import 'package:glassapp/utils/log.dart';
import 'package:rxdart/rxdart.dart';

class AdvertProvider extends BaseProvider {
  final SpCaller caller;

  AdvertProvider(this.caller);

  List<AdvertListEntity> _adList = List();

  List<AdvertListEntity> get adList => _adList;

  set adList(List<AdvertListEntity> data) {
//    if (data == null) {
//      _adList = List();
//    } else {
//      _adList.addAll(data);
//    }
    _adList = data;
    notifyListeners();
  }

  Observable loadAdvertList() => serverAdvertList().doOnData((event) {
        Log.w(event);
        var entity = BaseEntity.fromJson(event);
        if (entity.success) {
          var advertListWrapper =
              AdvertListWrapper .fromJson(entity.body);
          adList = advertListWrapper.data;
        }
      });
}
