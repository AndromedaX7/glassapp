import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassapp/design.dart';

import 'add_address_page.dart';

class ReceiveAddressListPage extends StatefulWidget {
  @override
  _ReceiveAddressListPageState createState() => _ReceiveAddressListPageState();
}

class _ReceiveAddressListPageState extends State<ReceiveAddressListPage> {
  int addrCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("收货地址"),
      ),
      body:   addrCount == 0 ? _buildPageContent() : _buildList(),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (c) => AddAddressPage()));
        },
        child: Icon(Icons.add_location),
      ),
    );
  }

  Widget _buildPageContent() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: dh(150),
          ),
          Image.asset(
            "images/img_location.png",
            width: dh(98),
            height: dh(92),
          ),
          SizedBox(
            height: dh(45),
          ),
          Text("你还没有收货地址哦～添加一个吧！"),
          SizedBox(
            height: dh(25),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (c) => AddAddressPage())),
            child: Container(
              width: dw(328),
              height: dh(40),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffff6d73),
                  ),
                  borderRadius: BorderRadius.circular(dh(16))),
              child: Center(
                child: Text(
                  "添加地址",
                  style: TextStyle(
                    color: Color(0xffff6d73),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (bc, p) => Container(
        padding: EdgeInsets.symmetric(
          horizontal: dw(16),
          vertical: dh(8),
        ),
        child: Card(
          child: Container(
            padding: EdgeInsets.all(dh(16)),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("name"),
                    Flexible(
                      child: SizedBox(),
                      fit: FlexFit.tight,
                    ),
                    Text("phone")
                  ],
                ),
                SizedBox(
                  height: dh(18),
                ),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(
                          vertical: dh(2), horizontal: dw(4)),
                      decoration: BoxDecoration(
                        color: Color(0xffe4393c),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            dh(4),
                          ),
                        ),
                      ),
                      child: Text(
                        "默认",
                        style: TextStyle(color: Colors.white, fontSize: sp(6)),
                      ),
                    ),
                    SizedBox(
                      width: dw(8),
                    ),
                    Text("address"),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: dh(20),
                    bottom: dh(10),
                  ),
                  child: Container(
                    height: dh(1),
                    width: double.infinity,
                    color: Color(0xffdddddd),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Checkbox(
                      activeColor: Color(0xffe4393c),
                      value: true,
                      onChanged: (v) {},
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    Text("默认地址"),
                    Flexible(
                      child: SizedBox(),
                      fit: FlexFit.tight,
                    ),
                    Icon(Icons.delete),
                    SizedBox(
                      width: dw(4),
                    ),
                    Text("删除")
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
