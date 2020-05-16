import 'package:flutter/material.dart';
import 'package:glassapp/app/settings/agreement.dart';
import 'package:glassapp/design.dart';
import 'package:glassapp/utils/validate.dart';
import 'package:glassapp/viewmodel/home_provider.dart';
class RegisterPage extends StatefulWidget {
  final HomeProvider provider;

  RegisterPage(this.provider);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                  height: dh(50),
                ),
                Text(
                  "注册",
                  style: TextStyle(color: Colors.black, fontSize: sp(16)),
                ),
                SizedBox(
                  height: dh(10),
                ),
                TextField(
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    labelText: "请输入您的昵称",
                    hintText: "请输入您的昵称",
                    errorText: widget.provider.validateUserName(),
                  ),
                  onChanged: (str) => widget.provider.userName = str,
                ),
                TextField(
                  controller: _phone,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    icon: Icon(Icons.phone),
                    labelText: "请输入手机号码",
                    hintText: "请输入手机号码",
                    errorText: widget.provider.validatePhone(),
                  ),
                  onChanged: (str) => widget.provider.userPhone = str,
                ),
                Stack(
                  children: <Widget>[
                    Positioned(
                      child: TextField(
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          icon: Icon(Icons.phone),
                          labelText: "请输入验证码",
                          hintText: "请输入验证码",
                          errorText: validateNotNull(
                              widget.provider.currentAuth, "请输入验证码"),
                        ),
                        onChanged: (str) => widget.provider.currentAuth = str,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: dh(10),
                      child: FlatButton(
                        onPressed: null,
                        child: Text(
                          "获取验证码",
//                        style: TextStyle(color: Color(0xff555dfe)),
                        ),
                      ),
                    ),
                  ],
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
                RaisedButton(color: Theme.of(context).primaryColor,
                  onPressed: (){

                  },
                  child: Container(
                    width: double.infinity,
                    height: dh(50),
                    child: Center(
                      child: Text(
                        "立即注册",
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
                      onPressed: () => widget.provider.userState = 0,
                      child: RichText(
                        text: TextSpan(
                            text: "已有账号？",
                            style: TextStyle(color: Color(0xffa5a7bc)),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "立即登录",
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
                      Checkbox(value: widget.provider.checkAgreement, onChanged: (val)=>widget.provider.checkAgreement=val),
                      Text(
                        "我已阅读并同意",
                        style: TextStyle(fontSize: sp(11)),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (c)=>AgreementPage()));
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
