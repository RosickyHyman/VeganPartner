import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partner/utils/common/common_colors.dart';
import 'package:partner/utils/other/hex_color.dart';

import '../routers.dart';
import 'state.dart';

final _tabBarInfo = [
  {'title': '工作台', 'normal': 'index_normal', 'selected': 'index_selected'},
  {'title': '消息', 'normal': 'msg_normal', 'selected': 'msg_selected'},
  {'title': '我', 'normal': 'mine_normal', 'selected': 'mine_selected'},
];

final _pages = [
  Routers.router.buildPage('index_page', null),
  Routers.router.buildPage('msg_page', null),
  Routers.router.buildPage('mine_page', null),
];

Widget buildView(HomeState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    key: state.scaffoldKey,
    body: WillPopScope(
      onWillPop: () async {
        if (state.lastPressedAt == null || DateTime.now().difference(state.lastPressedAt) > const Duration(seconds: 1)) {
          //两次点击间隔超过1秒则重新计时
          state.lastPressedAt = DateTime.now();
          state.scaffoldKey.currentState.showSnackBar(const SnackBar(
            content: Text('再次点击,退出程序'),
            backgroundColor: Color(0x4d333333),
            behavior: SnackBarBehavior.fixed,
          ));
          return false;
        }
        return true;
      },
      child: CupertinoTabScaffold(
        controller: state.controller,
        tabBuilder: (context, index) {
          return _pages[index];
        },
        tabBar: _buildCupTabBar(state, dispatch),
      ),
    ),
  );
}

CupertinoTabBar _buildCupTabBar(HomeState state, Dispatch dispatch) {
  return CupertinoTabBar(
    backgroundColor: CommonColors.mainBgColor,
    items: <BottomNavigationBarItem>[
      _buildBottomNavigationBarItem(state, 0),
      _buildBottomNavigationBarItem(state, 1),
      _buildBottomNavigationBarItem(state, 2),
    ],
    inactiveColor: CommonColors.bottomBarTextColor,
    activeColor: CommonColors.pinkTheme,
    currentIndex: state.controller.index,
  );
}

BottomNavigationBarItem _buildBottomNavigationBarItem(HomeState state, int index) {
  return BottomNavigationBarItem(
    icon: _buildNavigationBarIcon(
      index,
      isSelected: false,
    ),
    activeIcon: _buildNavigationBarIcon(
      index,
      isSelected: true,
    ),
    // ignore: deprecated_member_use
    title: Text(
      _tabBarInfo[index]['title'],
      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
    ),
  );
}

Widget _buildNavigationBarIcon(
  int index, {
  bool isSelected = false,
  bool haveBadge = false,
  int badgeValue,
}) {
  final image = Image.asset("images/tab_bar/${_tabBarInfo[index][isSelected ? "selected" : "normal"]}.png");

  return image;
}
