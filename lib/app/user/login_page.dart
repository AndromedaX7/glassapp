import 'package:flutter/material.dart';
import 'package:glassapp/app/settings/agreement.dart';
import 'package:glassapp/design.dart';
import 'package:glassapp/utils/log.dart';
import 'package:glassapp/utils/validate.dart';
import 'package:glassapp/viewmodel/home_provider.dart';

class LoginPage extends StatefulWidget {
  final HomeProvider provider;

  LoginPage(this.provider);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _phone;
  TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _phone = new TextEditingController(text: widget.provider.userPhone);
    _password = new TextEditingController(text: widget.provider.password);
  }

  @override
  void dispose() {
    _phone.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: dw(42)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 0,
                  height: dh(60),
                ),
                Text(
                  "登录",
                  style: TextStyle(color: Colors.black, fontSize: sp(16)),
                ),
                SizedBox(
                  height: dh(30),
                ),
                TextField(
                  controller: _phone,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: "请输入手机号码",
                    hintText: "请输入手机号码",
                    errorText: widget.provider.validatePhone(),
                  ),
                  onChanged: (str) => widget.provider.userPhone = str,
                ),
                TextField(
                  controller: _password,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock_open),
                    labelText: "请输入密码",
                    hintText: "请输入密码",
                    errorText:
                        validateNotNull(widget.provider.password, "请输入密码"),
                  ),
                  onChanged: (str) => widget.provider.password = str,
                ),
                SizedBox(
                  height: dh(20),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {},
                    child: Text(
                      "忘记密码？",
                      style: TextStyle(color: Color(0xff555dfe)),
                    ),
                  ),
                ),
                SizedBox(
                  height: dh(40),
                ),
                Row(
                  children: <Widget>[
                    Checkbox(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        value: widget.provider.userMode,
                        onChanged: (b) {
                          widget.provider.userMode = b;
                        }),
                    Text("当前正在使用${widget.provider.userMode ? "一般" : "监护"}账号登录")
                  ],
                ),
                RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () => widget.provider
                      .login()
                      .doOnDone(() => Navigator.pop(context))
                      .doOnListen(() {
                    showDialog(
                      context: context,
                      child: SimpleDialog(
                        title: Text("正在登录..."),
                        children: <Widget>[
                          Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).listen((_) {}, onError: (e) {
                    Log.v(e);
                  }),
                  child: Container(
                    width: double.infinity,
                    height: dh(50),
                    child: Center(
                      child: Text(
                        "立即登录",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: dh(30),
                ),
                Container(
                  child: Center(
                    child: FlatButton(
                      onPressed: () => widget.provider.userState = 1,
                      child: RichText(
                        text: TextSpan(
                            text: "没有账号？",
                            style: TextStyle(color: Color(0xffa5a7bc)),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "立即注册",
                                  style: TextStyle(color: Color(0xff555dfe)))
                            ]),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: dh(40),
                ),
                Container(
                  height: dh(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Checkbox(
                          value: widget.provider.checkAgreement,
                          onChanged: (val) =>
                              widget.provider.checkAgreement = val),
                      Text(
                        "我已阅读并同意",
                        style: TextStyle(fontSize: sp(11)),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (c) => AgreementPage()));
                        },
                        child: Text("《用户协议和隐私条款》",
                            style: TextStyle(
                                fontSize: sp(11), color: Color(0xff555dfe))),
                      )
                    ],
                  ),
                )
              ],
            ),
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
