import 'package:fish_redux/fish_redux.dart';
import 'package:partner/application/home/index_page/action.dart';
import 'package:partner/application/home/message_page/action.dart';
import 'package:partner/utils/common/common_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

Future<void> _init(Action action, Context<ChangeSkinState> ctx) async {
  ctx.state.list = [
    {'title': '少女粉', 'color': '#FA7298', 'isSelect': false},
    {'title': '高能红', 'color': '#F44236', 'isSelect': false},
    {'title': '咸蛋黄', 'color': '#FEC107', 'isSelect': false},
    {'title': '草苗绿', 'color': '#8BC24A', 'isSelect': false},
    {'title': '宝石蓝', 'color': '#2196F3', 'isSelect': false},
    {'title': '罗兰紫', 'color': '#9C28B1', 'isSelect': false},
  ];
  final prefs = await SharedPreferences.getInstance();

  final String color = prefs.getString('themeColor') == null || prefs.getString('themeColor') == '' ? CommonColors.defaultColors : prefs.getString('themeColor');

  for (int i = 0; i <  ctx.state.list.length; i++) {
    Map map = ctx.state.list[i];

    if (color == map['color']) {
      ctx.state.lastIndex = i;
      map['isSelect'] = true;
    } else {
      map['isSelect'] = false;
    }
  }

  ctx.dispatch(ChangeSkinActionCreator.onAction());
}

Future<void> _changeSkinAction(Action action, Context<ChangeSkinState> ctx) async {
  int index = action.payload;
  ctx.state.list[ctx.state.lastIndex]['isSelect'] = false;
  ctx.state.list[index]['isSelect'] = true;

  ctx.state.lastIndex = index;
  CommonColors.defaultColors = ctx.state.list[index]['color'];

  final prefs = await SharedPreferences.getInstance();

  prefs.setString('themeColor', ctx.state.list[index]['color']);

  ctx.dispatch(ChangeSkinActionCreator.onAction());
  ctx.broadcast(IndexActionCreator.onRefreshAction());
  ctx.broadcast(MessageActionCreator.onRefreshAction());
  ctx.broadcast(MineActionCreator.onRefreshAction());
  ctx.broadcast(HomeActionCreator.onRefreshAction());
}
