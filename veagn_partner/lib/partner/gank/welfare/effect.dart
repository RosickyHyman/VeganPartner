import 'package:fish_redux/fish_redux.dart';
import 'package:flutter_svprogresshud/svprogresshud.dart';
import 'package:partner/utils/config/apis.dart';
import 'package:partner/utils/config/user_config_manager.dart';
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
  // HttpUtil.updateBaseUrl(UserConfigManager.instance.picInsectUrl);

  ctx.state.scrollController.addListener(() {
    if (ctx.state.isShowFoot == false) {
      if (ctx.state.scrollController.position.pixels == ctx.state.scrollController.position.maxScrollExtent) {
        ctx.state.isShownMore = true;
        ctx.dispatch(WelFareActionCreator.onAction());
        Future.delayed(const Duration(seconds: 1), () {
          ctx.state.currentPage++;
          _getWelFareData(action, ctx, isMore: true);
          // _loadPicData(action, ctx, isMore: true);
        });
      }
    }
  });
  _getWelFareData(action, ctx);
  // _loadPicData(action, ctx);
}

void _onRefreshAction(Action action, Context<WelFareState> ctx) {
  ctx.state.currentPage = 0;
  _getWelFareData(action, ctx);
}

void _getWelFareData(Action action, Context<WelFareState> ctx, {bool isMore = false}) {
  if (isMore == false) SVProgressHUD.show('加载中...');
  HttpUtil.sendRequest(
    HttpMethod.GET,
    '${GanApis.getWelfareList}/${ctx.state.pageSize}/${ctx.state.currentPage}',
    queryParameters: {},
    isShowError: false,
    success: (result) {
      SVProgressHUD.dismiss();
      List list = result['results'];
      if (isMore) {
        ctx.state.dataList.addAll(list);
      } else {
        ctx.state.dataList = list;
      }
      ctx.state.isShowFoot = false;
      ctx.state.total = ctx.state.dataList.length;
      ctx.dispatch(WelFareActionCreator.onAction());
    },
    failure: (error) {
      SVProgressHUD.dismissWithDelay(1000);
    },
  );
}

void _loadPicData(Action action, Context<WelFareState> ctx, {bool isMore = false}) {

  String url = '${PicInsectApis.getAttentionList}';

  if(isMore){
    final length = ctx.state.dataList.length;
    final int lastPostId = ctx.state.dataList[length - 1]['post_id'];
    url = '$url?post_id=$lastPostId&page=${ctx.state.currentPage}&type=loadmore';
  }

  if (isMore == false) SVProgressHUD.show('加载中...');
  HttpUtil.sendRequest(
    HttpMethod.GET,
    url,
    queryParameters: {},
    isShowError: false,
    success: (result) {
      SVProgressHUD.dismiss();

      print('==results==${result.toString()}');

      List list = result['feedList'];
      if (isMore) {
        ctx.state.dataList.addAll(list);
      } else {
        ctx.state.dataList = list;
      }
      ctx.state.isShowFoot = false;
      ctx.state.total = ctx.state.dataList.length;
      ctx.dispatch(WelFareActionCreator.onAction());
    },
    failure: (error) {
      SVProgressHUD.dismissWithDelay(1000);
    },
  );
}
