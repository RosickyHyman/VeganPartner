import 'dart:async';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomeState implements Cloneable<HomeState> {
  GlobalKey<ScaffoldState> scaffoldKey;
  CupertinoTabController controller;

  StreamSubscription traceSub;

  /// 未读消息数量
  int unreadMessageCount;

  ///上次点击时间
  DateTime lastPressedAt;

  @override
  HomeState clone() {
    return HomeState()
      ..scaffoldKey = scaffoldKey
      ..controller = controller
      ..traceSub = traceSub
      ..unreadMessageCount = unreadMessageCount
      ..lastPressedAt = lastPressedAt;
  }

}

HomeState initState(Map<String, dynamic> args) {
  final state = HomeState();
  state.scaffoldKey = GlobalKey<ScaffoldState>();
  state.controller = CupertinoTabController(initialIndex: 0);
  state.unreadMessageCount = 0;

  return state;
}
