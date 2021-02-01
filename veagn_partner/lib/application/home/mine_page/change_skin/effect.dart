import 'package:fish_redux/fish_redux.dart';
import 'package:partner/application/home/index_page/action.dart';
import 'package:partner/application/home/message_page/action.dart';
import 'package:partner/utils/common/common_colors.dart';

import '../../action.dart';
import '../action.dart';
import 'action.dart';
import 'state.dart';

Effect<ChangeSkinState> buildEffect() {
  return combineEffects(<Object, Effect<ChangeSkinState>>{
    Lifecycle.initState: _init,
    ChangeSkinAction.changeSkinAction: _changeSkinAction,
  });
}

void _init(Action action, Context<ChangeSkinState> ctx) {
  ctx.state.list  = [
    {'title' : '少女粉' , 'color' : '#FA7298', 'isSelect': true},
    {'title' : '高能红' , 'color' : '#F44236', 'isSelect': false},
    {'title' : '咸蛋黄' , 'color' : '#FEC107', 'isSelect': false},
    {'title' : '草苗绿' , 'color' : '#8BC24A', 'isSelect': false},
    {'title' : '宝石蓝' , 'color' : '#2196F3', 'isSelect': false},
    {'title' : '罗兰紫' , 'color' : '#9C28B1', 'isSelect': false},
  ];
}

void _changeSkinAction(Action action, Context<ChangeSkinState> ctx) {

  int index = action.payload;
  ctx.state.list[ctx.state.lastIndex]['isSelect'] = false;
  ctx.state.list[index]['isSelect'] = true;

  ctx.state.lastIndex = index;
  CommonColors.defaultColors = ctx.state.list[index]['color'];

  ctx.dispatch(ChangeSkinActionCreator.onAction());
  ctx.broadcast(IndexActionCreator.onRefreshAction());
  ctx.broadcast(MessageActionCreator.onRefreshAction());
  ctx.broadcast(MineActionCreator.onRefreshAction());
  ctx.broadcast(HomeActionCreator.onRefreshAction());
}