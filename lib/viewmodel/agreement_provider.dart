import 'package:glassapp/base.dart';
import 'package:glassapp/utils/network_model.dart';
import 'package:glassapp/bean/json_entity.dart';
import 'package:glassapp/utils/http.dart';
import 'package:glassapp/utils/log.dart';
import 'package:rxdart/rxdart.dart';


class AgreementProvider extends BaseProvider {
  String _resultHtml = "";
  String get resultHtml => _resultHtml;
  set resultHtml(String html) {
    _resultHtml = html;
    notifyListeners();
  }

  Observable loadContent() => serverAgreement()
      .doOnData((r) {
        Log.v(r);
       var a= BaseEntity.fromJson(r);
        if (a.success) {
          resultHtml = htmlTransform(a.body['data']);
        }
      })
      .doOnError((e) {})
      .doOnListen(() {})
      .doOnDone(() {});
}
