import 'package:flutter/material.dart';
import 'package:glassapp/app/room/opened_room.dart';
import 'package:glassapp/design.dart';
import 'package:glassapp/bean/room_json.dart';
import 'package:glassapp/utils/log.dart';
import 'package:glassapp/viewmodel/room_provider.dart';

import 'local.dart';

class _ToolbarContainerLayout extends SingleChildLayoutDelegate {
  const _ToolbarContainerLayout();

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return constraints.tighten(height: kToolbarHeight);
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(constraints.maxWidth, kToolbarHeight);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(0.0, size.height - childSize.height);
  }

  @override
  bool shouldRelayout(_ToolbarContainerLayout oldDelegate) => false;
}

class _CustomToolbarContainerLayout extends _ToolbarContainerLayout {
  const _CustomToolbarContainerLayout({this.height = kToolbarHeight});

  final double height;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return constraints.tighten(height: height);
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(constraints.maxWidth, height);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return Offset(0.0, size.height - childSize.height);
  }

  @override
  bool shouldRelayout(_ToolbarContainerLayout oldDelegate) => false;
}

class SearchTapAppBar extends StatefulWidget implements PreferredSizeWidget {
  SearchTapAppBar(
      {Key key,
      this.searchContentColor = Colors.white,
      this.hint = "",
      this.heroId,
      this.leading,
      this.automaticallyImplyLeading = true,
      this.onSearch,
      this.bottom,
      this.bottomPadding = const EdgeInsets.all(0),
      this.actionsColor = Colors.white})
      : preferredSize = Size.fromHeight(
            kToolbarHeight + (bottom?.preferredSize?.height ?? 0)),
        super(key: key);
  final Color actionsColor;
  final Widget leading;
  final bool automaticallyImplyLeading;
  final Function() onSearch;
  final PreferredSizeWidget bottom;
  final EdgeInsets bottomPadding;
  final Color searchContentColor;
  final String hint;
  final String heroId;

  @override
  _SearchTapAppBar createState() => _SearchTapAppBar();

  @override
  final Size preferredSize;
}

class _SearchTapAppBar extends State<SearchTapAppBar> {
  void _handleDrawerButton() {
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final ScaffoldState scaffold = Scaffold.of(context);
    final ModalRoute<dynamic> parentRoute = ModalRoute.of(context);

    final hasDrawer = scaffold?.hasDrawer ?? false;
    final canPop = parentRoute?.canPop ?? false;
    final useCloseButton =
        parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;
    Widget leading = widget.leading;
    if (leading == null && widget.automaticallyImplyLeading) {
      if (hasDrawer) {
        leading = IconButton(
          icon: Icon(
            Icons.menu,
            color: widget.actionsColor,
          ),
          onPressed: _handleDrawerButton,
        );
      } else {
        if (canPop) {
          leading = useCloseButton ? const CloseButton() : BackButton();
        }
      }
    }

    if (leading != null) {
      leading = ConstrainedBox(
        constraints: BoxConstraints.tightFor(width: dw(26)),
        child: leading,
      );
    }

    Widget content = Container(
        decoration: BoxDecoration(
            color: widget.searchContentColor,
            borderRadius: BorderRadius.circular(dw(8))),
        height: dw(36),
        padding: EdgeInsets.only(left: dw(16)),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: Container(
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    widget.hint,
                    style: TextStyle(fontSize: sp(14)),
                  ),
                ),
              ),
              left: 20,
            ),
            Positioned(
              child: Icon(
                Icons.search,
                size: 20,
              ),
              left: 0,
            ),
          ],
        ));

    content = GestureDetector(
      onTap: () {
        widget.onSearch?.call();
      },
      child: content,
    );
    if (widget.heroId != null && widget.heroId.isNotEmpty) {
      content = Hero(tag: widget.heroId, child: content);
    }

    final Widget toolbar = NavigationToolbar(
      leading: leading,
      middle: content,
      centerMiddle: false,
      middleSpacing: NavigationToolbar.kMiddleSpacing,
      trailing: null,
    );

    Widget appBar = ClipRect(
      child: CustomSingleChildLayout(
          delegate: const _ToolbarContainerLayout(), child: toolbar),
    );

    if (widget.bottom != null) {
      appBar = Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: kToolbarHeight),
                child: appBar,
              ),
            ),
            Padding(
              padding: widget.bottomPadding,
              child: widget.bottom,
            )
          ]);
    }

    appBar = SafeArea(
      child: appBar,
      bottom: false,
      top: true,
    );

    return appBar;
  }
}

class Card2 extends StatelessWidget {
  /// Creates a material design card.
  ///
  /// The [elevation] must be null or non-negative. The [borderOnForeground]
  /// must not be null.
  Card2({
    Key key,
    this.color,
    this.shadowColor,
    this.elevation,
    this.shape,
    this.borderOnForeground = true,
    this.margin,
    this.clipBehavior,
    this.borderRadius = 4,
    this.child,
    this.semanticContainer = true,
  })  : assert(elevation == null || elevation >= 0.0),
        assert(borderOnForeground != null),
        super(key: key);

  /// The card's background color.
  ///
  /// Defines the card's [Material.color].
  ///
  /// If this property is null then [ThemeData.cardTheme.color] is used,
  /// if that's null then [ThemeData.cardColor] is used.
  final Color color;

  /// The color to paint the shadow below the card.
  ///
  /// If null then the ambient [CardTheme]'s shadowColor is used.
  /// If that's null too, then the default is fully opaque black.
  final Color shadowColor;

  /// The z-coordinate at which to place this card. This controls the size of
  /// the shadow below the card.
  ///
  /// Defines the card's [Material.elevation].
  ///
  /// If this property is null then [ThemeData.cardTheme.elevation] is used,
  /// if that's null, the default value is 1.0.
  final double elevation;

  /// The shape of the card's [Material].
  ///
  /// Defines the card's [Material.shape].
  ///
  /// If this property is null then [ThemeData.cardTheme.shape] is used.
  /// If that's null then the shape will be a [RoundedRectangleBorder] with a
  /// circular corner radius of 4.0.
  final ShapeBorder shape;

  /// Whether to paint the [shape] border in front of the [child].
  ///
  /// The default value is true.
  /// If false, the border will be painted behind the [child].
  final bool borderOnForeground;

  /// {@macro flutter.widgets.Clip}
  ///
  /// If this property is null then [ThemeData.cardTheme.clipBehavior] is used.
  /// If that's null then the behavior will be [Clip.none].
  final Clip clipBehavior;

  /// The empty space that surrounds the card.
  ///
  /// Defines the card's outer [Container.margin].
  ///
  /// If this property is null then [ThemeData.cardTheme.margin] is used,
  /// if that's null, the default margin is 4.0 logical pixels on all sides:
  /// `EdgeInsets.all(4.0)`.
  final EdgeInsetsGeometry margin;

  /// Whether this widget represents a single semantic container, or if false
  /// a collection of individual semantic nodes.
  ///
  /// Defaults to true.
  ///
  /// Setting this flag to true will attempt to merge all child semantics into
  /// this node. Setting this flag to false will force all child semantic nodes
  /// to be explicit.
  ///
  /// This flag should be false if the card contains multiple different types
  /// of content.
  final bool semanticContainer;

  final double borderRadius;

  /// The widget below this widget in the tree.
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  static const double _defaultElevation = 1.0;

  @override
  Widget build(BuildContext context) {
    final CardTheme cardTheme = CardTheme.of(context);

    return Semantics(
      container: semanticContainer,
      child: Container(
        margin: margin ?? cardTheme.margin ?? const EdgeInsets.all(4.0),
        child: Material(
          type: MaterialType.card,
          shadowColor:
              shadowColor ?? /*cardTheme.shadowColor ?? */ Colors.black,
          color: color ?? cardTheme.color ?? Theme.of(context).cardColor,
          elevation: elevation ?? cardTheme.elevation ?? _defaultElevation,
          shape: shape ??
              cardTheme.shape ??
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(this.borderRadius),
              ),
          borderOnForeground: borderOnForeground,
          clipBehavior: clipBehavior ?? cardTheme.clipBehavior ?? Clip.none,
          child: Semantics(
            explicitChildNodes: !semanticContainer,
            child: child,
          ),
        ),
      ),
    );
  }
}

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  SearchAppBar(
      {Key key,
      this.searchContentColor = Colors.white,
      this.hint = "",
      this.heroId,
      this.leading,
      this.automaticallyImplyLeading = true,
      this.onSearch,
      this.onCancel,
      this.bottom,
      this.bottomPadding = const EdgeInsets.all(0),
      this.actionsColor = Colors.white})
      : preferredSize = Size.fromHeight(
            kToolbarHeight + (bottom?.preferredSize?.height ?? 0)),
        super(key: key);
  final Color actionsColor;
  final Widget leading;
  final bool automaticallyImplyLeading;
  final Function(String value) onSearch;
  final Function() onCancel;
  final PreferredSizeWidget bottom;
  final EdgeInsets bottomPadding;
  final Color searchContentColor;
  final String hint;
  final String heroId;

  @override
  _SearchAppBar createState() => _SearchAppBar();

  @override
  final Size preferredSize;
}

class _SearchAppBar extends State<SearchAppBar> {
  void _handleDrawerButton() {
    Scaffold.of(context).openDrawer();
  }

  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ScaffoldState scaffold = Scaffold.of(context);
    final ModalRoute<dynamic> parentRoute = ModalRoute.of(context);

    final hasDrawer = scaffold?.hasDrawer ?? false;
    final canPop = parentRoute?.canPop ?? false;
    final useCloseButton =
        parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;
    double searchWidth = dw(328);
    Widget leading = widget.leading;
    if (leading == null && widget.automaticallyImplyLeading) {
      if (hasDrawer) {
        leading = IconButton(
          icon: Icon(
            Icons.menu,
            color: widget.actionsColor,
          ),
          onPressed: _handleDrawerButton,
        );
      } else {
        if (canPop) {
          leading = useCloseButton ? const CloseButton() : BackButton();
        }
      }
    }

    if (leading != null) {
      leading = ConstrainedBox(
        constraints: BoxConstraints.tightFor(width: dw(26)),
        child: leading,
      );
      searchWidth -= dw(26);
    }

    Widget content = Container(
        margin: EdgeInsets.only(right: dw(6)),
        width: double.infinity,
        decoration: BoxDecoration(
            color: widget.searchContentColor,
            borderRadius: BorderRadius.circular(dw(8))),
        height: dw(36),
        padding: EdgeInsets.only(left: dw(16)),
        child: Row(children: [
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  child: Container(
                    width: searchWidth - 20,
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        border: InputBorder.none,
                        hintText: widget.hint,
                        hintStyle: TextStyle(fontSize: sp(14)),
                      ),
                      onChanged: widget.onSearch,
                    ),
                  ),
                  left: 20,
                ),
                Positioned(
                  child: Icon(
                    Icons.search,
                    size: 20,
                  ),
                  left: 0,
                ),
              ],
            ),
          ),
          Padding(
            child: GestureDetector(
              child: Icon(Icons.clear),
              onTap: () {
                _controller.clear();
                widget.onSearch("");
              },
            ),
            padding: EdgeInsets.only(right: dw(6)),
          ),
        ]));

    if (widget.heroId != null && widget.heroId.isNotEmpty) {
      content = Material(
        child: content,
      );

      content = Hero(tag: widget.heroId, child: content);
    }

    Widget actions = Container(
      child: GestureDetector(onTap: widget.onCancel, child: Text("取消")),
    );

    content = Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: content,
        ),
        actions,
      ],
    );

    final Widget toolbar = NavigationToolbar(
      leading: leading,
      middle: content,
      centerMiddle: false,
      middleSpacing: NavigationToolbar.kMiddleSpacing,
      trailing: null,
    );

    Widget appBar = ClipRect(
      child: CustomSingleChildLayout(
          delegate: const _ToolbarContainerLayout(), child: toolbar),
    );

    if (widget.bottom != null) {
      appBar = Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: kToolbarHeight),
                child: appBar,
              ),
            ),
            Padding(
              padding: widget.bottomPadding,
              child: widget.bottom,
            )
          ]);
    }

    appBar = SafeArea(
      child: appBar,
      bottom: false,
      top: true,
    );

    return appBar;
  }
}

class RoomTitleBar extends StatefulWidget implements PreferredSizeWidget {
  RoomTitleBar(
      {Key key,
      this.userMode = true, //userMode true 主播模式，false 自由模式
      this.bottom,
      this.leading,
      this.automaticallyImplyLeading = true,
      this.actionsColor})
      : preferredSize = Size.fromHeight(
            kToolbarHeight + (bottom?.preferredSize?.height ?? 0)),
        super(key: key);

  @override
  _RoomTitleBarState createState() => _RoomTitleBarState();

  @override
  final Size preferredSize;

  final PreferredSizeWidget bottom;

  final Widget leading;

  final bool automaticallyImplyLeading;
  final Color actionsColor;
  final bool userMode;
}

class _RoomTitleBarState extends State<RoomTitleBar> {
  void _handleDrawerButton() {
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    final ScaffoldState scaffold = Scaffold.of(context);
    final ModalRoute<dynamic> parentRoute = ModalRoute.of(context);

    final hasDrawer = scaffold?.hasDrawer ?? false;
    final canPop = parentRoute?.canPop ?? false;
    final useCloseButton =
        parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;

    Widget leading = widget.leading;
    if (leading == null && widget.automaticallyImplyLeading) {
      if (hasDrawer) {
        leading = IconButton(
          icon: Icon(
            Icons.menu,
            color: widget.actionsColor,
          ),
          onPressed: _handleDrawerButton,
        );
      } else {
        if (canPop) {
          leading = useCloseButton ? const CloseButton() : BackButton();
        }
      }
    }

    if (leading != null) {
      leading = ConstrainedBox(
        constraints: BoxConstraints.tightFor(width: dw(26)),
        child: leading,
      );
    }

    final Widget toolbar = NavigationToolbar(
      leading: leading,
      middle: null,
      centerMiddle: false,
      middleSpacing: NavigationToolbar.kMiddleSpacing,
      trailing: null,
    );

    Widget appBar = ClipRect(
      child: CustomSingleChildLayout(
          delegate:
              _CustomToolbarContainerLayout(height: kToolbarHeight + dw(60)),
          child: toolbar),
    );

    if (widget.bottom != null) {
      appBar = Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: kToolbarHeight),
                child: appBar,
              ),
            ),
            widget.bottom,
          ]);
    }

    appBar = SafeArea(
      child: appBar,
      bottom: false,
      top: true,
    );

    return appBar;
  }
}

class BottomBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  final bool userMode; //userMode true 主播，false 自由
  final bool iCreate; //userMode true 主播，false 自由
  final Function(bool mode) modeChange;

  BottomBar({
    Key key,
    this.iCreate = true,
    this.title,
    this.userMode = true,
    this.modeChange,
  }) : super(key: key);

  @override
  BottomBarState createState() => BottomBarState();

  @override
  final Size preferredSize = Size.fromHeight(dw(60));
}

class BottomBarState extends State<BottomBar> {
  bool umode;

  bool _init = false;

  setMode(bool mode) {
    setState(() {
      umode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!_init) {
      _init = true;
      umode = widget.userMode;
    }

    bool mode = umode;
    if (!widget.iCreate) {
      mode = !mode;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: dw(20)),
      height: widget.preferredSize.height,
      child: Column(
        children: <Widget>[
          Spacer(),
          Row(
            children: [
              Container(
                width: dw(220),
                child: Text(
                  "${widget.title ?? ""}",
                  style: TextStyle(fontSize: sp(20), color: Color(0xff333333),),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                width: dw(8),
              ),
              Spacer(),
              GestureDetector(
                  onTap: () {
                    Log.e("icreate :${widget.iCreate}");
                    if (widget.iCreate) widget.modeChange(!umode);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(dw(17)),
                      gradient: LinearGradient(
                          colors: mode
                              ? <Color>[Color(0xFF90C9EE), Color(0xFF1B87CD)]
                              : <Color>[Color(0xFFFF6868), Color(0xFFFFAC96)]),
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: dw(11), vertical: dw(2)),
                    child: Row(
                      children: <Widget>[
                        if (widget.iCreate) Image.asset("images/qiehuan.png"),
                        Padding(
                          padding: EdgeInsets.only(left: dw(8.0)),
                          child: Text(
                            "${mode ? "自由" : "主播"}模式",
                            style: TextStyle(
                                color: Colors.white, fontSize: sp(13)),
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
          Spacer(),
          Container(
            height: dw(1),
            color: Color(0xFFDBDBDB),
          )
        ],
      ),
    );
  }
}

class OffstageWrapper extends StatefulWidget {
  OffstageWrapper({Key key, this.offstage = true, this.child})
      : super(key: key);

  final bool offstage;
  final Widget child;

  @override
  OffstageWrapperState createState() => OffstageWrapperState();
}

class OffstageWrapperState extends State<OffstageWrapper> {
  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: widget.offstage,
      child: widget.child,
    );
  }

  void changeState() {
    setState(() {});
  }
}

class RoomItemWidget extends StatefulWidget {
  final int pos;
  final RoomListItemEntity entity;
  final RoomProvider provider;

  RoomItemWidget(this.provider, this.pos, this.entity);

  @override
  _RoomItemWidgetState createState() => _RoomItemWidgetState();
}

class _RoomItemWidgetState extends State<RoomItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card2(
        borderRadius: dw(8),
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/tupian.png"),
                          fit: BoxFit.fill),
                      color: Colors.cyan,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(dw(8))),
                    ),
                  ),
                  Positioned(
                    child: IconButton(
                        icon: Icon(
                          widget.entity.subscribed == 1
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          if (widget.entity.subscribed == 0) {
                            widget.provider
                                .addFav(widget.entity.id)
                                .listen((_) {});
                            setState(() {
                              widget.entity.subscribed = 1;
                            });
                          } else {
                            widget.provider
                                .deleteFav(widget.entity.id)
                                .listen((_) {});
                            setState(() {
                              widget.entity.subscribed = 0;
                            });
                          }
                        }),
                    right: dw(35),
                    top: dw(16),
                  ),
                  Positioned(
                    child: GestureDetector(
                      onTap: () {
                        LocalChannel.stopCurrent();
                        widget.provider.joinRoom(
                            widget.entity.userId, widget.entity.mode == 1);
                        showDialog(
                          context: context,
                          child: SimpleDialog(
                            children: [
                              Center(
                                child: CircularProgressIndicator(),
                              )
                            ],
                          ),
                        );

                        widget.provider
                            .roomDetails(widget.entity.id)
                            .listen((event) {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (c) => OpenedRoomContentPage(
                                widget.provider,
                                widget.entity.id,
                                iCreate: false,
                                userMode: widget.provider.userMode,
                              ),
                            ),
                          );
                        });
                      },
                      child: Image.asset(
                        "images/Oval.png",
                        width: dw(40),
                        height: dw(40),
                      ),
                    ),
                    right: dw(26),
                    bottom: dw(18),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(dw(12)))),
                      width: dw(24),
                      height: dw(12),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: dw(75),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: dw(30),
                            top: dw(8),
                          ),
                          child: Text(
                            "${widget.entity.topic}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: sp(18), color: Colors.black),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding:
                              EdgeInsets.only(left: dw(30), bottom: dw(12)),
                          child: Row(
                            children: [
                              Container(
                                child: Text(
                                  "${widget.entity.nickname}",
                                  style: TextStyle(
                                      fontSize: sp(13), color: Colors.white),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: dw(2), horizontal: dw(11)),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: <Color>[
                                      Color(0xffff6868),
                                      Color(0xffffac96)
                                    ]),
                                    borderRadius:
                                        BorderRadius.circular(dw(17))),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: dw(6)),
                                child: Text(
                                  "${widget.entity.age ?? 0}岁",
                                  style: TextStyle(
                                      fontSize: sp(13), color: Colors.white),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: dw(2), horizontal: dw(11)),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: <Color>[
                                      Color(0xff468cdf),
                                      Color(0xff81c8fa)
                                    ]),
                                    borderRadius:
                                        BorderRadius.circular(dw(17))),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(right: dw(30)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "人数：${widget.entity.total ?? 0}",
                            maxLines: 1,
                          ),
                          Container(
                            height: dw(20),
                            child: Text(
                              "${widget.entity.city}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: sp(13)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class EmptyWidgetWrapper extends StatelessWidget {
  EmptyWidgetWrapper({this.child, this.data, this.placeHolder});

  @required
  final Widget child;
  @required
  final List data;
  final Widget placeHolder;

  @override
  Widget build(BuildContext context) {
    if (data == null || data.isEmpty) {
      if (placeHolder == null) {
        return emptyContainer();
      }
      return placeHolder;
    } else
      return child;
  }

  static Widget emptyContainer() {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "images/ic_empty.png",
            width: 100,
          ),
          SizedBox(
            height: 10,
          ),
          Text("什么都没有哦~"),
        ],
      ),
    );
  }
}

class TextBar extends StatelessWidget {
  final String title;

  final Function onTap;
  TextBar(this.title,{this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: dh(42),
          padding: EdgeInsets.symmetric(vertical: dh(12)),
          color: Colors.white,
          child: Center(
            child: Text("$title"),
          )),
    );
  }
}

class DoubleTextBar extends StatelessWidget {
  final String title;
  final Widget desc;

  final GestureTapCallback onTap;

  DoubleTextBar(this.title, this.desc, {this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: dh(44),
          padding: EdgeInsets.only(
              left: dw(16), right: dw(16), top: dh(12), bottom: dh(12)),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Text(
                "$title",
                style: TextStyle(fontSize: 16),
              ),
              Flexible(
                child: Container(),
                fit: FlexFit.tight,
              ),
              desc,
            ],
          )),
    );
  }
}



void showToast(BuildContext context, String message, ToastLength length) async {
  OverlayState overlayState = Overlay.of(context);
  OverlayEntry overlayEntry = OverlayEntry(builder: (context) {
    return Container(
      child: Text(message),
      color: Colors.black12,
    );
  });
  overlayState.insert(overlayEntry);
  var waitSecond = 0;
  if (length == ToastLength.Short) {
    waitSecond = 3;
  } else {
    waitSecond = 5;
  }
  await Future.delayed(Duration(seconds: waitSecond));
  overlayEntry.remove();
}

enum ToastLength { Long, Short }
