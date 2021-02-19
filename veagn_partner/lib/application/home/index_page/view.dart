import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:partner/utils/common/common_colors.dart';
import 'package:partner/utils/other/hex_color.dart';

import '../../routers.dart';
import 'state.dart';

Widget buildView(IndexState state, Dispatch dispatch, ViewService viewService) {
  final size = MediaQuery.of(viewService.context).size;
  final double screenWidth = size.width;
  return Scaffold(
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          color: HexColor(CommonColors.white),
          padding: const EdgeInsets.only(left: 1, right: 1),
          alignment: Alignment.center,
          child: TabBar(
            isScrollable: true,
            controller: state.mTabController,
            labelColor: HexColor(CommonColors.defaultColors),
            unselectedLabelColor: HexColor(CommonColors.tabBarTextColor),
            labelStyle: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
            unselectedLabelStyle: const TextStyle(fontSize: 17.0),
            indicatorColor: HexColor(CommonColors.defaultColors),
            indicatorPadding: EdgeInsets.only(left: 15, right: 15),
            indicatorWeight: 3,
            tabs: state.tabTitles.map((Map<String, String> item) {
              return Container(
                width: 40,
                height: 35,
                child: Center(
                  child: Text(item['title'], softWrap: false, overflow: TextOverflow.fade),
                ),

                // Tab(text: item['title']),
              );
            }).toList(),
          ),
        ),
        Container(color: HexColor(CommonColors.bgColor), height: 5),
        Expanded(
          child: Container(
            color: HexColor(CommonColors.bgColor),
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
                return _buildListView(state, dispatch, viewService, map);
              },
            ),
          ),
        )
      ],
    ),
  );
}


Widget _buildListView(IndexState state, Dispatch dispatch, ViewService viewService, Map map) {
  switch (map['type']) {
    case 'attention':
      return Routers.router.buildPage('attention_page', map);
      break;
    case 'recommend':
      return Routers.router.buildPage('recommend_page', map);
      break;
    case 'hot':
      return Routers.router.buildPage('hot_page', map);
      break;
    case 'video':
      return Routers.router.buildPage('video_page', map);
      break;
    case 'welFare':
      return Routers.router.buildPage('wel_fare_page', map);

      // return Container(
      //   color: HexColor(CommonColors.greenTheme),
      // );
      break;
    case 'anti':
      return Container(
        color: HexColor(CommonColors.pinkTheme),
      );
      break;
    case 'wellOff':
      return Container(
        color: HexColor(CommonColors.yellowTheme),
      );
      break;
    default:
      return Container(
        color: HexColor(CommonColors.defaultColors),
      );
      break;
  }
}