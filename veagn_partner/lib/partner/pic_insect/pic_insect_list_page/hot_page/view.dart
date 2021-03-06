import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:partner/widget/list/common/data/tu_chong_source.dart';
import 'package:partner/widget/list/item/item_builder.dart';

import 'state.dart';

import 'dart:math';

Widget buildView(HotState state, Dispatch dispatch, ViewService viewService) {
  return _buildHotListView(state, dispatch, viewService);
}

Widget _buildHotListView(HotState state, Dispatch dispatch, ViewService viewService) {
  return LoadingMoreList<TuChongItem>(
    ListConfig<TuChongItem>(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemBuilder: buildGridItem,
      sourceList: state.listSourceRepository,
      padding: const EdgeInsets.all(5.0),
      lastChildLayoutType: LastChildLayoutType.foot,
    ),
  );
}
