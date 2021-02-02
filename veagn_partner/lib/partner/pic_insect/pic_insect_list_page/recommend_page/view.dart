import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:partner/widget/list/common/data/tu_chong_source.dart';
import 'package:partner/widget/list/item/item_builder.dart';

import 'state.dart';

Widget buildView(RecommendState state, Dispatch dispatch, ViewService viewService) {
  return _buildRecommendListView(state, dispatch, viewService);
}

Widget _buildRecommendListView(RecommendState state, Dispatch dispatch, ViewService viewService) {
  return LoadingMoreList<TuChongItem>(
    ListConfig<TuChongItem>(
      extendedListDelegate: const SliverWaterfallFlowDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
      ),
      itemBuilder: buildWaterfallFlowItem,
      sourceList: state.waterfallsSource,
      padding: const EdgeInsets.all(5.0),
      lastChildLayoutType: LastChildLayoutType.foot,
    ),
  );
}