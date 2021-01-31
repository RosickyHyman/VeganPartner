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
      leading: Container(child: Icon(Icons.account_balance_wallet_outlined, color: CommonColors.whiteTheme)),
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
            tabs: state.tabTitles.map((item) {
              return Container(
                width: (screenWidth - 1) / 10,
                child: Tab(text: item),
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
                final List list = [];
                return _buildListView(index, list, state, dispatch, viewService);
              },
            ),
          ),
        )
      ],
    ),
  );
}

Widget _buildListView(int pageIndex, List list, IndexState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    color: CommonColors.defaultColors,
  );
}
