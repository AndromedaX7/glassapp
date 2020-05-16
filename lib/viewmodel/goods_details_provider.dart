import 'dart:convert';

import 'package:glassapp/base.dart';
import 'package:glassapp/utils/network_model.dart';
import 'package:glassapp/bean/json_entity.dart';
import 'package:glassapp/utils/shared_preferences.dart';
import 'package:glassapp/utils/log.dart';
import 'package:rxdart/rxdart.dart';


class GoodsDetailsProvider extends BaseProvider {
  GoodsDetailsProvider(this.shared);

  final SpCaller shared;

  GoodsDetailsEntity _data = GoodsDetailsEntity.fromJson({});

  GoodsDetailsEntity get data => _data;

  bool _dismiss = false;

  get dismiss => _dismiss;

  set dismiss(bool dismiss) {
    _dismiss = dismiss;
    notifyListeners();
  }

  set data(GoodsDetailsEntity data) {
    _data = data;
    notifyListeners();
  }

  String _html = "";

  get html => _html;

  set html(String html) {
    _html = html;
    notifyListeners();
  }

  Observable goodsDetails(String id) =>
      serverGoodsDetails(id, shared.getString("token"))
          .doOnData((event) {
            dismiss = true;
            var entity = BaseEntity.fromJson(event);
            Log.v(json.encode(event));

            if (entity.success) {
              data = entity.toBody().toGoodsDetails();
              html = data.content;
            }
          });


  @override
  void dispose() {
    _dismiss = true;
    super.dispose();
  }
}
