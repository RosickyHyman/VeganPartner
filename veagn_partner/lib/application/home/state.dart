import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../routers.dart';

class HomeState implements Cloneable<HomeState> {
  GlobalKey<ScaffoldState> scaffoldKey;
  CupertinoTabController controller;

  StreamSubscription traceSub;

  ///上次点击时间
  DateTime lastPressedAt;

  List tabBarInfo = [
    {'title': '首页', 'normal': 'index_normal', 'selected': 'index_selected'},
    {'title': '消息', 'normal': 'msg_normal', 'selected': 'msg_selected'},
    {'title': '我', 'normal': 'mine_normal', 'selected': 'mine_selected'},
  ];

  List pages = [
    Routers.router.buildPage('index_page', null),
    Routers.router.buildPage('msg_page', null),
    Routers.router.buildPage('mine_page', null),
  ];

  int currentIndex = 0;
  var pageController;

  @override
  HomeState clone() {
    return HomeState()
      ..scaffoldKey = scaffoldKey
      ..controller = controller
      ..traceSub = traceSub
      ..lastPressedAt = lastPressedAt
      ..tabBarInfo = tabBarInfo
      ..pages = pages
      ..currentIndex = currentIndex
      ..pageController = pageController;
  }
}

HomeState initState(Map<String, dynamic> args) {
  final state = HomeState();
  state.scaffoldKey = GlobalKey<ScaffoldState>();
  state.controller = CupertinoTabController(initialIndex: 0);
  state.pageController = PageController(
    initialPage: 0,
  );

  return state;
}
