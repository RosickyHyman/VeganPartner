import 'package:fish_redux/fish_redux.dart';
import 'package:partner/utils/config/apis.dart';
import 'package:partner/utils/network/http_util.dart';

import 'action.dart';
import 'state.dart';

Effect<IndexListState> buildEffect() {
  return combineEffects(<Object, Effect<IndexListState>>{
    Lifecycle.initState: _init,
  });
}

void _init(Action action, Context<IndexListState> ctx) {
  _getData(action, ctx);
}


void _getData(Action action, Context<IndexListState> ctx) {
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
      ctx.dispatch(IndexListActionCreator.onAction());
    },
    failure: (error) {
      print('=============_getData==========error:==${error.toString()}');
    },
  );
}