import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:partner/utils/common/common_colors.dart';

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
          color: CommonColors.bgColor,
          padding: const EdgeInsets.only(left: 1, right: 1),
          alignment: Alignment.center,
          child: TabBar(
            isScrollable: true,
            controller: state.mTabController,
            labelColor: CommonColors.defaultColors,
            unselectedLabelColor: CommonColors.tabBarTextColor,
            labelStyle: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
            unselectedLabelStyle: const TextStyle(fontSize: 19.0),
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
      return _buildContentListView(state, dispatch, viewService);
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

Widget _buildContentListView(IndexState state, Dispatch dispatch, ViewService viewService) {
  List list = state.list;
  return ListView.separated(
    itemCount: (list == null || list.isEmpty) ? 0 : list.length + 1,
    physics: const AlwaysScrollableScrollPhysics(),
    itemBuilder: (BuildContext context, int index) {
      if (list.isNotEmpty && index == list.length) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Text(
            '共${list.length}个任务',
            style: const TextStyle(color: Color(0xff999999), fontSize: 12),
          ),
        );
      } else {
        final Map map = list[index];
        return _buildItemView(state, viewService, dispatch, map);
      }
    },
    separatorBuilder: (BuildContext context, int index) {
      return Container(height: 0);
    },
  );
}

Widget _buildItemView(
  IndexState state,
  ViewService viewService,
  Dispatch dispatch,
  Map map,
) {
  return GestureDetector(
    child: Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(left: 14, right: 14, top: 8.0),
          constraints: const BoxConstraints(minHeight: 68),
          child: Card(
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
            elevation: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 8, 0, 13),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
                    child: Text(
                      map['title'] ?? '',
                      style: TextStyle(color: CommonColors.tabBarTextColor, fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: Text(
                      map['des'] ?? '',
                      style: TextStyle(color: CommonColors.tabBarTextColor, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
