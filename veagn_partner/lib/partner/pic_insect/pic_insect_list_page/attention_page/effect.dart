import 'package:fish_redux/fish_redux.dart';
import 'package:partner/utils/config/apis.dart';
import 'package:partner/utils/network/http_util.dart';
import 'package:partner/widget/list/common/data/tu_chong_repository.dart';

import 'action.dart';
import 'state.dart';

Effect<AttentionState> buildEffect() {
  return combineEffects(<Object, Effect<AttentionState>>{
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
  });
}

void _init(Action action, Context<AttentionState> ctx) {

  ctx.state.listSourceRepository = PicInsectRepository();

  ctx.dispatch(AttentionActionCreator.onAction());
}

void _dispose(Action action, Context<AttentionState> ctx) {
  ctx.state.listSourceRepository.dispose();
}

void _getAttentionData(Action action, Context<AttentionState> ctx) {
  HttpUtil.sendRequest(
    HttpMethod.GET,
    PicInsectApis.getAttentionList,
    queryParameters: {},
    isShowError: false,
    success: (result) {
      print('=============_getAttentionData==========result:==${result.toString()}');
    },
    failure: (error) {
      print('=============_getAttentionData==========error:==${error.toString()}');
    },
  );
}