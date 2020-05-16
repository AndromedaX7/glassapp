import 'package:flutter/material.dart';
import 'package:glassapp/bean/json_entity.dart';
import 'package:glassapp/base.dart';
import 'package:glassapp/design.dart';
import 'package:glassapp/viewmodel/bind_person_provider.dart';


class AddBindPerson extends PageProviderNode<BindPersonProvider> {
  @override
  Widget buildContent(BuildContext context) {
    return AddBindPersonContentPage(mProvider);
  }
}

class AddBindPersonContentPage extends StatefulWidget {
  AddBindPersonContentPage(this.provider);

  final BindPersonProvider provider;

  @override
  _AddBindPersonContentPageState createState() =>
      _AddBindPersonContentPageState();
}

class _AddBindPersonContentPageState extends State<AddBindPersonContentPage> {
  var form = GlobalKey<FormState>();

  String account;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              child: Form(
                key: form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          top: dh(56), left: dh(16), bottom: dh(80)),
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Color(0xff666666),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: dh(16)),
                            child: Text(
                              "添加关联人",
                              style: TextStyle(
                                  fontSize: sp(21), color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: dh(42)),
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon:Icon(Icons.person) ,
                          hintText: "请输入关联人账号"
                        ),

                        validator: (v){
                          if(v==null||v ==''){
                            return "请输入关联人账号";
                          }else{
                            return null;
                          }
                        },
                        onSaved: (s){
                          account=s;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: dh(42), vertical: dh(38)),
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon:Icon(Icons.lock) ,
                          hintText: "请输入关联人密码"
                        ),
                        obscureText: true,
                        validator:(v){
                          if(v==null||v ==''){
                            return "请输入关联人密码";
                          }else{
                            return null;
                          }
                        },

                        onSaved: (s){
                          password=s;
                        },
                      ),
                    ),
                    Center(
                      child: Text(
                        "*添加关联人后，即可使用实时异地视野和SOS功能。",
                        style: TextStyle(
                            fontSize: sp(12), color: Color(0xfff95065)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: dh(55)),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {

                           if( form.currentState.validate()){
                             form.currentState.save();
                             widget.provider.addNew(account,password).listen((event) {
                               var entity = BaseEntity.fromJson(event);
                               if (entity.success) {
                                 Navigator.of(context).pop(true);
                               }
                             });
                           }


                          },
                          child: Container(
                            width: dh(310),
                            height: dh(50),
                            child: Center(
                              child: Text(
                                "确定",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Color(0xff575DFF),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(dh(4)))),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
