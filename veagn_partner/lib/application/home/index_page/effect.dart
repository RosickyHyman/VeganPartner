import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:partner/utils/config/apis.dart';
import 'package:partner/utils/network/http_util.dart';

import 'action.dart';
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

  _getData(action, ctx);

}

void _getData(Action action, Context<IndexState> ctx) {
  Map<String, dynamic> params = {
    'q' : '被狗咬',
    'key': DreamApis.dreamKey
  };

  HttpUtil.sendRequest(
    HttpMethod.GET,
    DreamApis.getDreamMean,
    queryParameters: params,
    isShowError: false,
    success: (result) {
      List list = result['result'];
      ctx.state.list = list;
      print('=============_getData==========result:==${result.toString()}');
      ctx.dispatch(IndexActionCreator.onAction());
    },
    failure: (error) {

      print('=============_getData==========error:==${error.toString()}');
    },
  );
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