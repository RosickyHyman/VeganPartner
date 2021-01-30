import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

class IndexState implements Cloneable<IndexState> {

  var tabTitles = ['直播', '推荐', '热门', '追番', '影视', '抗疫', '小康'];
  int pageIndex = 0;
  int lastPageIndex = 0;


  int currentPage = 0;

  TextEditingController controller;

  ScrollController scrollController = ScrollController();
  TabController mTabController;
  PageController mPageController = PageController(initialPage: 0);
  var isPageCanChanged = true;

  String searchText = '';

  Map filterMap = {};

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
      ..searchText = searchText
      ..controller = controller
      ..filterMap = filterMap;
  }
}

IndexState initState(Map<String, dynamic> args) {
  return IndexState()
    ..controller = TextEditingController();
}
