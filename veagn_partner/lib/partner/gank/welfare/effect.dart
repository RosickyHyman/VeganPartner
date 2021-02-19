import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_svprogresshud/svprogresshud.dart';
import 'package:partner/utils/config/apis.dart';
import 'package:partner/utils/network/http_util.dart';

import 'action.dart';
import 'state.dart';

Effect<WelFareState> buildEffect() {
  return combineEffects(<Object, Effect<WelFareState>>{
    Lifecycle.initState: _init,
    WelFareAction.onRefresh: _onRefreshAction,
  });
}

void _init(Action action, Context<WelFareState> ctx) {
  ctx.state.scrollController.addListener(() {
    if (ctx.state.isShowFoot == false) {
      if (ctx.state.scrollController.position.pixels == ctx.state.scrollController.position.maxScrollExtent) {
        ctx.state.isShownMore = true;
        ctx.dispatch(WelFareActionCreator.onAction());
        Future.delayed(const Duration(seconds: 1), () {
          ctx.state.currentPage++;
          _loadMoreData(ctx);
        });
      }
    }
  });
  _getWelFareData(action, ctx);
}

void _onRefreshAction(Action action, Context<WelFareState> ctx) {
  ctx.state.currentPage = 0;
  _getWelFareData(action, ctx);
}

void _getWelFareData(Action action, Context<WelFareState> ctx) {
  SVProgressHUD.show('加载中...');
  HttpUtil.sendRequest(
    HttpMethod.GET,
    '${GanApis.getWelfareList}/${ctx.state.pageSize}/${ctx.state.currentPage}',
    queryParameters: {},
    isShowError: false,
    success: (result) {
      SVProgressHUD.dismiss();
      List list = result['results'];
      ctx.state.dataList = list;
      ctx.state.isShowFoot = false;
      ctx.state.total = ctx.state.dataList.length;
      ctx.dispatch(WelFareActionCreator.onAction());
    },
    failure: (error) {
      SVProgressHUD.dismissWithDelay(1000);
    },
  );

}

void _loadMoreData(Context<WelFareState> ctx) {
  // SVProgressHUD.show('加载中...');
  HttpUtil.sendRequest(
    HttpMethod.GET,
    '${GanApis.getWelfareList}/${ctx.state.pageSize}/${ctx.state.currentPage}',
    queryParameters: {},
    isShowError: false,
    success: (result) {
      // SVProgressHUD.dismiss();
      List list = result['results'];
      ctx.state.dataList.addAll(list);
      ctx.state.isShowFoot = false;
      ctx.state.total = ctx.state.dataList.length;
      ctx.dispatch(WelFareActionCreator.onAction());
    },
    failure: (error) {
      SVProgressHUD.dismissWithDelay(1000);
    },
  );

}
