import 'package:glassapp/base.dart';

class CompanyInfoProvider extends BaseProvider{
  String _resultHtml = "";

  String get resultHtml => _resultHtml;

  set resultHtml(String html) {
    _resultHtml = html;
    notifyListeners();
  }


}