import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddContactContentPage extends StatefulWidget {
  @override
  _AddContactContentPageState createState() => _AddContactContentPageState();
}

class _AddContactContentPageState extends State<AddContactContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CupertinoPageScaffold(
        child: Container(),
        navigationBar: CupertinoNavigationBar(
          middle: Text("添加联系人"),
          trailing: GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Text("完成",style: TextStyle(color: Color(0xfff95065),),),
          ),
        ),
      ),
    );
  }
}
