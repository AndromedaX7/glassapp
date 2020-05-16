import 'package:flutter/material.dart';
import 'package:glassapp/app/home/add_contacts.dart';
import 'package:glassapp/app/settings/settings.dart';
import 'package:glassapp/base.dart';
import 'package:glassapp/design.dart';
import 'package:glassapp/local.dart';
import 'package:glassapp/utils/network_model.dart';
import 'package:glassapp/viewmodel/contact_provider.dart';
import 'package:glassapp/widgets.dart';

class ContactPage extends PageProviderNode<ContactProvider> {
  ContactPage() : super(params: []);

  @override
  Widget buildContent(BuildContext context) {
    return ContactContentPage(mProvider);
  }
}

class ContactContentPage extends StatefulWidget {
  ContactContentPage(this.provider);

  final ContactProvider provider;

  @override
  _ContactContentPageState createState() => _ContactContentPageState();
}

class _ContactContentPageState extends State<ContactContentPage> {
  @override
  void initState() {
    super.initState();
    widget.provider.list().listen((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffdddddd),
        title: Text(
          "联系人",
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (c) => SettingsPage(
                        "设置",
                        needAppBar: true,
                      )));
            },
            icon: Icon(
              Icons.settings,
              color: Colors.black87,
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        child: EmptyWidgetWrapper(
            child: RefreshIndicator(
              onRefresh: () => widget.provider.list().listen((_) {}).asFuture(),
              child: ListView.builder(
                  itemBuilder: (c, p) => _buildItem(p),
                  itemCount: widget.provider.contacts.length),
            ),
            data: widget.provider.contacts),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
//          LocalChannel.launchPlatform("add_contact");
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (c) => AddContactContentPage()));
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildItem(int pos) {
    var data = widget.provider.contacts[pos];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: dw(15)),
      height: dh(60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: dh(34),
            height: dh(34),
            child: CircleAvatar(
              backgroundImage: NetworkImage("$serverUrl${data.imageSrc}"),
            ),
          ),
//          Image.network(
//            ,
//            width: dw(34),
//            height: dh(34),
//          ),
          SizedBox(
            width: dw(20),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(data.name),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: dh(1),
                    color: Color(0xffdddddd),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
