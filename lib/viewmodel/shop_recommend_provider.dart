import 'package:glassapp/utils/network_model.dart';
import 'package:glassapp/bean/json_entity.dart';
import 'package:glassapp/utils/shared_preferences.dart';
import 'package:glassapp/utils/log.dart';
import 'package:glassapp/base.dart';
import 'package:glassapp/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

class ShopRecommendProvider extends BaseProvider {
  int _page = 1;

  bool canload = false;

  ShopRecommendProvider(this.caller);

  final SpCaller caller;

  List<GoodsEntity> _list = List();

  List<GoodsEntity> get list => _list;

  List<CategoryEntity> _categories = List();

  List<CategoryEntity> get categories => _categories;

  set categories(List<CategoryEntity> data) {
    _categories = data;
    notifyListeners();
  }

  set list(List<GoodsEntity> list) {
    _list.addAll(list);
    notifyListeners();
  }

  void nextPage() => _page++;

  void cleanPage() {
    _page = 1;
    list.clear();
  }

  Observable recommendList(bool taobao) =>
      serverRecommendList(caller.getString("token"), _page, isTaobao(taobao))
          .doOnData(
            (event) {
              Log.v(event);

              var entity = BaseEntity.fromJson(event);

              if (entity.success) {
                var listObject = GoodsListEntity.fromJson(entity.toBody().data);
                canload =
                    listObject.pageNo * listObject.pageSize < listObject.count;
                list = listObject.list;
              } else {
                canload = false;
              }
            },
          )
          .doOnDone(() {})
          .doOnError((e) {})
          .doOnListen(() {});

  Observable categoryList(bool taobao) =>
      serverCategoryList(caller.getString("token"), isTaobao(taobao))
          .doOnData((event) {
            Log.v(event);
            var entity = BaseEntity.fromJson(event);
            if (entity.success) {
              categories = CategoryListEntity.fromJson(entity.body).data;
            }
          })
          .doOnDone(() {})
          .doOnError((E) {})
          .doOnListen(() {});
}
