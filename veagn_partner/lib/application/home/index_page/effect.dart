import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;

import 'state.dart';

Effect<IndexState> buildEffect() {
  return combineEffects(<Object, Effect<IndexState>>{
    Lifecycle.initState: _init,
  });
}

void _init(Action action, Context<IndexState> ctx) {
  final TickerProvider tickerProvider = ctx.stfState as TickerProvider;
  ctx.state.mTabController = TabController(
    length: ctx.state.tabTitles.length,
    vsync: tickerProvider,
  );
  ctx.state.mTabController.addListener(() {
    if (ctx.state.mTabController.indexIsChanging) {
      _onPageChange(ctx, ctx.state.mTabController.index);
    }
  });
}

Future _onPageChange(Context<IndexState> ctx, int index) async {
  ctx.state.isPageCanChanged = false;
  await ctx.state.mPageController.animateToPage(
    index,
    duration: const Duration(milliseconds: 500),
    curve: Curves.ease,
  );
  ctx.state.isPageCanChanged = true;
  print('_onPageChange${ctx.state.pageIndex}');
}