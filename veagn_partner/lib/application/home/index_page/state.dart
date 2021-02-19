import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class IndexState implements Cloneable<IndexState> {
  var tabTitles = [
    {'type': 'attention', 'title': '关注'},
    {'type': 'recommend', 'title': '推荐'},
    {'type': 'hot', 'title': '热门'},
    {'type': 'video', 'title': '视频'},
    {'type': 'welFare', 'title': '福利'},
    {'type': 'anti', 'title': '抗疫'},
    {'type': 'wellOff', 'title': '小康'},
  ];
  int pageIndex = 1;
  int lastPageIndex = 0;

  int currentPage = 0;

  TextEditingController controller;

  ScrollController scrollController = ScrollController();
  TabController mTabController;
  PageController mPageController = PageController(initialPage: 0);
  var isPageCanChanged = true;

  @override
  IndexState clone() {
    return IndexState()
      ..tabTitles = tabTitles
      ..pageIndex = pageIndex
      ..lastPageIndex = lastPageIndex
      ..mTabController = mTabController
      ..mPageController = mPageController
      ..isPageCanChanged = isPageCanChanged
      ..currentPage = currentPage
      ..scrollController = scrollController
      ..controller = controller;
  }
}

IndexState initState(Map<String, dynamic> args) {
  return IndexState()..controller = TextEditingController();
}
