import 'package:glassapp/utils/shared_preferences.dart';
import 'package:glassapp/base.dart';

class ShopHomeProvider extends BaseProvider {
  int _shopPage = 0;
  ShopHomeProvider(this.caller);

  final SpCaller caller;

  get shopPos => _shopPage;

  set shopPos(int pos) {
    this._shopPage = pos;
    notifyListeners();
  }
}
