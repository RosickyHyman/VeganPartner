import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partner/utils/common/common_colors.dart';
import 'package:partner/utils/other/hex_color.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(HomeState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    key: state.scaffoldKey,
    appBar: state.currentIndex == 0
        ? PreferredSize(
            preferredSize: Size.fromHeight(50.0),
            child: AppBar(
              backgroundColor: HexColor(CommonColors.defaultColors),
              leading: InkWell(
                onTap: () {
                  state.scaffoldKey.currentState.openDrawer();
                  // dispatch(HomeActionCreator.onSetCurrentIndexAction(2));
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 0.0, top: 5.0, bottom: 5.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage('https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=4205192766,3222152012&fm=26&gp=0.jpg'),
                  ),
                ),
              ),
            ),
          )
        : PreferredSize(
            preferredSize: Size.fromHeight(0),
            child: AppBar(backgroundColor: HexColor(CommonColors.defaultColors)),
          ),
    drawer: Drawer(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: UserAccountsDrawerHeader(
                  accountName: Text('琴心剑魄'),
                  accountEmail: Text('rosicky_hyman@126.com'),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage('https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=4205192766,3222152012&fm=26&gp=0.jpg'),
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1826865982,2286352878&fm=26&gp=0.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          _buildDrawContent(Icon(Icons.home), 'Home', state, dispatch, viewService),
          Divider(),
          _buildDrawContent(Icon(Icons.favorite), 'Collect', state, dispatch, viewService),
          Divider(),
          _buildDrawContent(Icon(Icons.history), 'History', state, dispatch, viewService),
          Divider(),
          _buildDrawContent(Icon(Icons.settings), 'Setting', state, dispatch, viewService),
          Divider(),
          _buildDrawContent(Icon(Icons.close), 'Cancel', state, dispatch, viewService),
        ],
      ),
    ),
    body: WillPopScope(
      onWillPop: () async {
        if (state.lastPressedAt == null || DateTime.now().difference(state.lastPressedAt) > const Duration(seconds: 1)) {
          state.lastPressedAt = DateTime.now();
          state.scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text('再次点击,退出程序'),
            backgroundColor: HexColor(CommonColors.snackBgColor),
            // Color(0x4d333333),
            behavior: SnackBarBehavior.fixed,
          ));
          return false;
        }
        return true;
      },
      child: _buildNavigationKeepAlive(state, dispatch, viewService),
    ),
  );
}

Widget _buildDrawContent(Icon icon, String title, HomeState state, Dispatch dispatch, ViewService viewService) {
  return ListTile(
      leading: CircleAvatar(
        child: icon,
        backgroundColor: HexColor(CommonColors.defaultColors),
        foregroundColor: HexColor(CommonColors.bgColor),
      ),
      title: new Text(title),
      onTap: () {
        Navigator.of(viewService.context).pop();
      });
}

Widget _buildNavigationKeepAlive(HomeState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    body: PageView(
      controller: state.pageController,
      children: <Widget>[state.pages[state.currentIndex]],
      physics: NeverScrollableScrollPhysics(),
    ),
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: state.currentIndex,
      onTap: (index) {
        dispatch(HomeActionCreator.onSetCurrentIndexAction(index));
      },
      type: BottomNavigationBarType.fixed,
      items: [
        _buildBottomNavigationBarItem(state, dispatch, viewService, 0),
        _buildBottomNavigationBarItem(state, dispatch, viewService, 1),
        _buildBottomNavigationBarItem(state, dispatch, viewService, 2),
      ],
    ),
  );
}

BottomNavigationBarItem _buildBottomNavigationBarItem(HomeState state, Dispatch dispatch, ViewService viewService, int index) {
  return BottomNavigationBarItem(
    icon: _buildNavigationBarIcon(state, dispatch, index, isSelected: false),
    activeIcon: _buildNavigationBarIcon(state, dispatch, index, isSelected: true),
    // ignore: deprecated_member_use
    title: Text(
      state.tabBarInfo[index]['title'],
      style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500, color: HexColor(index == state.currentIndex ? CommonColors.defaultColors : CommonColors.tabBarTextColor)),
    ),
  );
}

Widget _buildNavigationBarIcon(
  HomeState state,
  Dispatch dispatch,
  int index, {
  bool isSelected = false,
}) {
  final image = Image.asset("images/tab_bar/${state.tabBarInfo[index][isSelected ? "selected" : "normal"]}.png");
  return image;
}
