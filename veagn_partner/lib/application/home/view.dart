import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partner/application/home/widget/navigation_keep_alive.dart';
import 'package:partner/utils/common/common_colors.dart';

import 'state.dart';

Widget buildView(HomeState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    key: state.scaffoldKey,
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
                    backgroundImage: NetworkImage(
                        'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=4205192766,3222152012&fm=26&gp=0.jpg'),
                  ), //用户头像
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1826865982,2286352878&fm=26&gp=0.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          _buildDrawContent(Icon(Icons.home), 'Home', state, dispatch, viewService),
          Divider(), // 增加一条线
          _buildDrawContent(Icon(Icons.favorite), 'Collect', state, dispatch, viewService),
          Divider(),
          _buildDrawContent(Icon(Icons.history), 'History', state, dispatch, viewService),
          Divider(),
          _buildDrawContent(Icon(Icons.settings), 'Setting', state, dispatch, viewService),
          Divider(),
          _buildDrawContent(Icon(Icons.close), 'Cancel', state, dispatch, viewService),// 增加一条线
        ],
      ),
    ),
    body: NavigationKeepAlive(),
  );
}

Widget _buildDrawContent(Icon icon, String title, HomeState state, Dispatch dispatch, ViewService viewService){
  return ListTile(   //第四个功能项
      leading: CircleAvatar(
        child: icon,
        backgroundColor: CommonColors.defaultColors,
        foregroundColor: CommonColors.bgColor,
      ),
      title: new Text(title),
      onTap: () {
        Navigator.of(viewService.context).pop();
      }
  );
}