import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:partner/utils/common/common_colors.dart';
import 'package:partner/utils/other/hex_color.dart';

import 'state.dart';

Widget buildView(IndexListState state, Dispatch dispatch, ViewService viewService) {
  return _buildListView(state, dispatch, viewService);
}

Widget _buildListView(IndexListState state, Dispatch dispatch, ViewService viewService) {
  Map map = state.map;
  switch (map['type']) {
    case 'live':
      return _buildContentListView(state, dispatch, viewService);
      break;
    case 'recommend':
      return Container(
        color: HexColor(CommonColors.purpleTheme),
      );
      break;
    case 'hot':
      return Container(
        color: HexColor(CommonColors.redTheme),
      );
      break;
    case 'chaiBan':
      return Container(
        color: HexColor(CommonColors.greenTheme),
      );
      break;
    case 'film':
      return Container(
        color: HexColor(CommonColors.blueTheme),
      );
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

Widget _buildContentListView(IndexListState state, Dispatch dispatch, ViewService viewService) {
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

Widget _buildItemView(IndexListState state, ViewService viewService, Dispatch dispatch, Map map) {
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
                      style: TextStyle(color: HexColor(CommonColors.tabBarTextColor), fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                    child: Text(
                      map['des'] ?? '',
                      style: TextStyle(color: HexColor(CommonColors.tabBarTextColor), fontSize: 14),
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
