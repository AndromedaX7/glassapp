import 'package:glassapp/base.dart';
import 'package:glassapp/utils/network_model.dart';
import 'package:glassapp/bean/json_entity.dart';
import 'package:glassapp/utils/shared_preferences.dart';
import 'package:glassapp/utils/log.dart';
import 'package:rxdart/rxdart.dart';


class ContactProvider extends BaseProvider {
  final SpCaller caller;

  List<ContactEntity> _contacts = List();

  List<ContactEntity> get contacts => _contacts;

  set contacts(List<ContactEntity> data) {
    _contacts = data;
    notifyListeners();
  }

  ContactProvider(this.caller);

  Observable list() => serverContacts(caller.getString("token"))
      .doOnData((event) {
        Log.v(event);
        var entity = BaseEntity.fromJson(event);
        if (entity.success) {
          contacts = ContactsListEntity.fromJson(entity.body).data;
        }
      })
      .doOnError((e) {
        Log.v(e.toString());
      })
      .doOnDone(() {})
      .doOnListen(() {});
}
