import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:partner/utils/common/common_colors.dart';

import 'state.dart';

Widget buildView(IndexState state, Dispatch dispatch, ViewService viewService) {
  final size = MediaQuery.of(viewService.context).size;
  final double screenWidth = size.width;
  return Scaffold(
    appBar: AppBar(
      backgroundColor: CommonColors.defaultColors,
      leading: Container(
        width: 20.0,
        height: 20.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle
        ),
        child: Image(
          image: NetworkImage('https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=4205192766,3222152012&fm=26&gp=0.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          color: Colors.white,
          padding: const EdgeInsets.only(left: 1, right: 1),
          alignment: Alignment.center,
          child: TabBar(
            isScrollable: true,
            controller: state.mTabController,
            labelColor: CommonColors.defaultColors,
            unselectedLabelColor: CommonColors.tabBarTextColor,
            labelStyle: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            unselectedLabelStyle: const TextStyle(fontSize: 17.0),
            indicatorColor: CommonColors.defaultColors,
            tabs: state.tabTitles.map((Map<String, String> item) {
              return Container(
                width: (screenWidth - 1) / 10,
                child: Tab(text: item['title']),
              );
            }).toList(),
          ),
        ),
        Container(color: CommonColors.bgColor, height: 5),
        Expanded(
          child: Container(
            color: CommonColors.bgColor,
            child: PageView.builder(
              itemCount: state.tabTitles.length,
              onPageChanged: (index) {
                if (state.isPageCanChanged) {
                  state.mTabController.animateTo(index);
                }
              },
              controller: state.mPageController,
              itemBuilder: (BuildContext context, int index) {
                state.pageIndex = index;
                final Map map = state.tabTitles[index];
                return _buildListView(index, map, state, dispatch, viewService);
              },
            ),
          ),
        )
      ],
    ),
  );
}

Widget _buildListView(int pageIndex, Map map, IndexState state, Dispatch dispatch, ViewService viewService) {
  switch (map['type']) {
    case 'live':
      return Container(
        color: CommonColors.pinkTheme,
      );
      break;
    case 'recommend':
      return Container(
        color: CommonColors.purpleTheme,
      );
      break;
    case 'hot':
      return Container(
        color: CommonColors.redTheme,
      );
      break;
    case 'chaiBan':
      return Container(
        color: CommonColors.greenTheme,
      );
      break;
    case 'film':
      return Container(
        color: CommonColors.blueTheme,
      );
      break;
    case 'anti':
      return Container(
        color: CommonColors.blackTheme,
      );
      break;
    case 'wellOff':
      return Container(
        color: CommonColors.yellowTheme,
      );
      break;
    default:
      return Container(
        color: CommonColors.defaultColors,
      );
      break;
  }
}
