import 'package:flutter/material.dart';
import 'package:glassapp/app/settings/agreement.dart';
import 'package:glassapp/app/settings/company_info_page.dart';
import 'package:glassapp/app/settings/self_info.dart';
import 'package:glassapp/base.dart';
import 'package:glassapp/design.dart';
import 'package:glassapp/utils/http.dart';
import 'package:glassapp/viewmodel/settings_provider.dart';
import 'package:glassapp/widgets.dart';

class SettingsPage extends PageProviderNode<SettingsProvider> {
  SettingsPage(String title, {this.needAppBar = true}) : super(params: [title]);
  final bool needAppBar;

  @override
  Widget buildContent(BuildContext context) {
    return SettingsContentPage(mProvider, needAppBar);
  }
}

class SettingsContentPage extends StatefulWidget {
  SettingsContentPage(this.provider, this.needAppBar);

  final SettingsProvider provider;
  final bool needAppBar;

  @override
  _SettingsContentPageState createState() => _SettingsContentPageState();
}

class _SettingsContentPageState extends State<SettingsContentPage> {
  void initState() {
    super.initState();
    mProvider = widget.provider;
    mProvider.settings().listen((_) {});
  }

  SettingsProvider mProvider;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: widget.needAppBar
            ? AppBar(
                title: Text(
                  mProvider.title,
                  style: TextStyle(color: mProvider.appThemes.appbarTextColor),
                ),
                backgroundColor: mProvider.appThemes.appbar,
                centerTitle: true,
              )
            : null,
        body: Container(
          color: mProvider.appThemes.divider,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              DoubleTextBar(
                "个人资料",
                Icon(
                  Icons.navigate_next,
                  color: Colors.black87,
                ),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (c)=>SelfInfoPage()))
              ),
              Container(
                height: dh(1),
              ),
              DoubleTextBar(
                  "修改密码",
                  Icon(
                    Icons.navigate_next,
                    color: Colors.black87,
                  )),
              Container(
                height: dh(10),
              ),
              DoubleTextBar(
                  "帮助中心",
                  Icon(
                    Icons.navigate_next,
                    color: Colors.black87,
                  )),
              Container(
                height: dh(1),
              ),
              DoubleTextBar(
                  "服务及隐私条款",
                  Icon(
                    Icons.navigate_next,
                    color: Colors.black87,
                  ),
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (c) => AgreementPage()))),
              Container(
                height: dh(10),
              ),
              DoubleTextBar("客服", Text("0431-80564418")),
              Container(
                height: dh(1),
              ),
              DoubleTextBar(
                  "意见反馈",
                  Icon(
                    Icons.navigate_next,
                    color: Colors.black87,
                  )),
              Container(
                height: dh(1),
              ),
              DoubleTextBar(
                "公司简介",
                Icon(
                  Icons.navigate_next,
                  color: Colors.black87,
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (c) => CompanyInfoContentPage(
                          htmlTransform(widget.provider.data.aboutUs))));
                },
              ),
              Container(
                height: dh(1),
              ),
              DoubleTextBar("当前版本", Text("1.0.0")),
              Container(
                height: dh(10),
              ),
              TextBar(
                "退出登录",
                onTap: () {
                  if (Navigator.canPop(context)) {
                    widget.provider.logout();
                    Navigator.pop(context);
                  }
                },
              ),
              Container(
                height: dh(10),
              ),
              TextBar("注销账户"),
              Flexible(
                child: Container(
                  width: double.infinity,
                ),
                flex: 1,
                fit: FlexFit.tight,
              ),
              Container(
                child: Center(
                  child: Text(
                    "Copyright@2018-2020",
                    style: TextStyle(color: Colors.black87, fontSize: 10),
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                    "长春云海科技有限公司版权所有",
                    style: TextStyle(color: Colors.black87, fontSize: 12),
                  ),
                ),
              ),
              SizedBox(height: dh(20))
            ],
          ),
        ),
      ),
    );
  }
}
