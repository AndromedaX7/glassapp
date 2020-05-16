import 'package:glassapp/utils/network_model.dart';
import 'package:glassapp/bean/json_entity.dart';
import 'package:glassapp/utils/shared_preferences.dart';
import 'package:glassapp/utils/log.dart';
import 'package:glassapp/base.dart';
import 'package:glassapp/utils/utils.dart';
import 'package:rxdart/rxdart.dart';

class GoodsCategoryProvider extends BaseProvider {
  List<GoodsCategoryEntity> _categories = List();

  List<GoodsCategoryEntity> get categories => _categories;

  set categories(List<GoodsCategoryEntity> data) {
    _categories = data;
    notifyListeners();
  }

  int appBarColor = 0xFFFAD0CA;
  int indicatorColor = 0xFFF29290;
  int bodyColor = 0xffffe4ec;

  List<GoodsEntity> _categoriesList = List();

  List<GoodsEntity> get categoriesList => _categoriesList;

  set categoriesList(List<GoodsEntity> data) {
    _categoriesList.addAll(data);
    notifyListeners();
  }

  static const List<double> aspectRatio = [345 / 128, 118 / 202, 118 / 178];
  static const List<int> crossCount = [1, 3, 3];
  static const List<int> mode = [0, 1, 2];

  int _index = 0;

  int get index => _index;

  set index(int data) {
    _index = data;
    notifyListeners();
  }

  GoodsCategoryProvider(this.caller);

  SpCaller caller;

  Observable getCategory(String id, bool taobao) =>
      serverCategoryList(caller.getString("token"), isTaobao(taobao),
              parentId: id)
          .doOnListen(() {})
          .doOnDone(() {})
          .doOnData((event) {
        Log.v(event);
        var entity = BaseEntity.fromJson(event);
        if (entity.success) {
          categories = GoodsCategoryListEntity.fromJson(entity.body).data;
        }
      }).doOnError((e) {
        Log.e(e);
      });

  Observable categoryGoods(String cid, String currentId, bool taobao) {
    String source;
    if (taobao) {
      source = "1";
    }
    return serverCategoryGoods(caller.getString("token"), cid, currentId, page,
            source: source)
        .doOnError((e) {})
        .doOnData((event) {
          Log.v(event);

          var entity = BaseEntity.fromJson(event);
          if (entity.success) {
            var goodsListEntity =
                GoodsListEntity.fromJson(entity.toBody().data);

            categoriesList = goodsListEntity.list;
            canLoad = goodsListEntity.pageNo * goodsListEntity.pageSize <
                goodsListEntity.count;
          } else {
            canLoad = false;
          }
        })
        .doOnDone(() {})
        .doOnListen(() {});
  }

  void dataClear() {
    categoriesList.clear();
  }

  GoodsCategoryProvider nextPage() {
    page++;
    return this;
  }

  GoodsCategoryProvider cleanPage() {
    dataClear();
    page = 1;
    return this;
  }

  int page = 1;
  bool canLoad = false;
}
