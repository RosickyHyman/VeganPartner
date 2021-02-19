import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';

class WelFareState implements Cloneable<WelFareState> {
  List dataList= [];

  int pageSize = 30;
  int currentPage = 0;
  int total = 0;
  ScrollController scrollController;
  bool isShownMore = false;
  bool isShowFoot = false;

  @override
  WelFareState clone() {
    return WelFareState()
      ..dataList = dataList
      ..pageSize = pageSize
      ..currentPage = currentPage
      ..total = total
      ..scrollController = scrollController
      ..isShownMore = isShownMore
      ..isShowFoot = isShowFoot;
  }
}

WelFareState initState(Map<String, dynamic> args) {
  return WelFareState()..scrollController = ScrollController();
}
