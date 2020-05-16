import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassapp/design.dart';
import 'package:glassapp/utils/log.dart';
class OnLineServiceContentPage extends StatefulWidget {
  @override
  _OnLineServiceContentPageState createState() =>
      _OnLineServiceContentPageState();
}

class _OnLineServiceContentPageState extends State<OnLineServiceContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("在线服务"),
        ),
        child: Container(
          width: dw(375),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: dh(70),
              ),
              Container(
                margin: EdgeInsets.only(top: dh(10)),
                width: dh(135),
                height: dh(135),
                child: CircleAvatar(
                    backgroundColor: Color(0xff565dff),
                    child: Center(
                      child: Text(
                        "在线服务",
                        style: TextStyle(color: Colors.white, fontSize: sp(16)),
                      ),
                    )),
              ),
              SizedBox(
                height: dh(40),
              ),
              Container(
                height: dh(160),
                margin: EdgeInsets.symmetric(horizontal: dw(16)),
                child: Card(
                  child: GestureDetector(
                    onTap: (){},
                    onLongPress: (){
                      Log.v("onLong press");
                    },
                    child: Image.asset("images/ic_audio.png"),
                  ),
                ),
              ),
              SizedBox(
                height: dh(25),
              ),
              RaisedButton(
                onPressed: null,
                color: Color(0xff575dfe),
                child: Container(
                  width: dw(310),
                  height: dh(50),
                  child: Center(
                    child: Text(
                      "按住语音留言",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: dh(25),
              ),
              RaisedButton(
                onPressed: () {},
                color: Color(0xff575dfe),
                child: Container(
                  width: dw(310),
                  height: dh(50),
                  child: Center(
                    child: Text(
                      "提交",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
