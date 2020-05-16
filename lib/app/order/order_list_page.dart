import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassapp/design.dart';
import 'package:glassapp/utils/network_model.dart';
import 'package:glassapp/bean/json_entity.dart';
import 'package:glassapp/utils/log.dart';
import 'package:glassapp/base.dart';
import 'package:glassapp/viewmodel/order_list_provider.dart';
import 'package:glassapp/widgets.dart';

class OrderListPage extends PageProviderNode<OrderListProvider> {
  final int initPosition;

  OrderListPage({this.initPosition = 0});

  @override
  Widget buildContent(BuildContext context) {
    return OrderListContentPage(initPosition, mProvider);
  }
}

class OrderListContentPage extends StatefulWidget {
  final int initPosition;
  final OrderListProvider provider;

  OrderListContentPage(this.initPosition, this.provider);

  @override
  _OrderListContentPageState createState() => _OrderListContentPageState();
}

class _OrderListContentPageState extends State<OrderListContentPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;
  int pos = 0;

  @override
  void initState() {
    super.initState();
    pos = widget.initPosition;
    _tabController = new TabController(
        length: 5, vsync: this, initialIndex: widget.initPosition);
    refresh(widget.initPosition);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent &&
          widget.provider.canLoad) {
        loadMore(pos);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的订单"),
        bottom: TabBar(
            onTap: (p) {
              pos = p;
              refresh(p);
              if (_scrollController.hasClients) _scrollController.jumpTo(0.1);
            },
            controller: _tabController,
            labelStyle: TextStyle(fontSize: sp(13)),
            indicatorSize: TabBarIndicatorSize.label,
            tabs: <Tab>[
              Tab(
                text: "全部",
              ),
              Tab(
                text: "待付款",
              ),
              Tab(
                text: "待发货",
              ),
              Tab(
                text: "待收货",
              ),
              Tab(
                text: "评价",
              ),
            ]),
      ),
      body: listContent(),
    );
  }

  Future<dynamic> loadMore(int pos) {
    return widget.provider.nextPage().orderList(pos);
  }

  Future<dynamic> refresh(int pos) {
    return widget.provider.cleanPage().orderList(pos);
  }

  Widget listContent() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: RefreshIndicator(
          child: EmptyWidgetWrapper(
             child: ListView.builder(
                controller: _scrollController,
                itemBuilder: (c, p) => buildItemWrapper(p),
                itemCount: widget.provider.list.length,
              ),
           data:   widget.provider.list),
          onRefresh: () => refresh(pos)),
    );
  }

  Widget buildItemWrapper(int p) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: dh(4), vertical: dh(2)),
      child: Card(
        child: Container(
          padding: EdgeInsets.all(dh(2)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: buildShopWrapper(widget.provider.list[p]),
          ),
        ),
      ),
      color: Color(0xffeeeeee),
    );
  }

  List<Widget> buildShopWrapper(OrderEntity item) {
    List<Widget> widgets = List();
    widgets.add(Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          item.shop.name,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        SizedBox(
          width: dw(4),
        ),
        Icon(
          Icons.navigate_next,
          color: Color(0xffdddddd),
        ),
        Flexible(
          child: SizedBox(),
          fit: FlexFit.tight,
        ),
        Text(
          "${widget.provider.stateName(item.state)}",
          style: TextStyle(fontSize: sp(12), color: Color(0xfffd602f)),
        ),
        SizedBox(
          width: dh(2),
        )
      ],
    ));
    widgets.add(Container(
      width: double.infinity,
      height: 1,
      color: Color(0xffdddddd),
    ));
    var details = item.details;
    for (int i = 0; i < details.length; i++) {
      var current = details[i];
      widgets.add(
        Container(
          padding: EdgeInsets.all(dh(4)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(
                "${urlWrapper(current.goodsInfo.picUrl)}",
                width: dh(80),
                height: dh(80),
              ),
              SizedBox(
                width: dh(4),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      current.goodsInfo.name,
                      style: TextStyle(
                        fontSize: sp(12),
                      ),
                      maxLines: 2,
                    ),
                    Text(
                      "${current.goodsPropertyName ?? ""}",
                      style: TextStyle(fontSize: sp(10)),
                    ),
                  ],
                ),
                fit: FlexFit.tight,
              ),
              SizedBox(
                width: dh(4),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "￥${current.goodsInfo.price}",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "x${current.amount}",
                    style: TextStyle(fontSize: sp(12)),
                  )
                ],
              ),
            ],
          ),
        ),
      );
    }
    widgets.add(
      Container(
        padding: EdgeInsets.all(dh(4)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              "共${details.length}件商品  合计:￥",
              style: TextStyle(fontSize: sp(10)),
            ),
            Text(
              "${item.totalFee}",
              style: TextStyle(fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
    widgets.add(Container(
      width: double.infinity,
      height: 1,
      color: Color(0xffdddddd),
    ));
    widgets.add(buildBottomBar(item));
    return widgets;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget buildBottomBar(OrderEntity item) {
    switch (item.state) {
      case -1:
        return Container(
          margin: EdgeInsets.all(dh(4)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              BarItemButton(
                "加入购物车",
                color: Color(0xfffd602f),
              ),
            ],
          ),
        );
        break;
      case 0:
        return Container(
          margin: EdgeInsets.all(dh(4)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              BarItemButton(
                "取消订单",
              ),
              SizedBox(
                width: dh(8),
              ),
              BarItemButton(
                "立即支付",
                color: Color(0xfffd602f),
              ),
            ],
          ),
        );
        break;
      case 1:
        return Container(
          margin: EdgeInsets.all(dh(4)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              BarItemButton(
                "提醒发货",
              ),
            ],
          ),
        );
        break;
      case 2:
        return Container(
          margin: EdgeInsets.all(dh(4)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                width: dh(8),
              ),
              BarItemButton(
                "查看物流",
              ),
              SizedBox(
                width: dh(8),
              ),
              BarItemButton(
                "确认收货",
                color: Color(0xfffd602f),
              ),
            ],
          ),
        );
        break;
      case 3:
        return Container();
        break;
      case 4:
        return Container();
        break;
      case 5:
        return Container(
          margin: EdgeInsets.all(dh(4)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                width: dh(8),
              ),
              BarItemButton(
                "加入购物车",
              ),
              SizedBox(
                width: dh(8),
              ),
              BarItemButton(
                "再次购买",
                color: Color(0xfffd602f),
              ),
            ],
          ),
        );
        break;
    }

    return Container();
  }
}

class BarItemButton extends StatelessWidget {
  final Function onTap;

  final String text;
  final Color color;

  BarItemButton(this.text, {this.color = Colors.grey, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ??
              () {
            Log.v(text);
          },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: dh(4), horizontal: dh(8)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(dh(12))),
            border: Border.all(color: color)),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: sp(12), color: color),
          ),
        ),
      ),
    );
  }
}
