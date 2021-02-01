import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<MineState> buildEffect() {
  return combineEffects(<Object, Effect<MineState>>{
    Lifecycle.initState: _init,
    MineAction.onRefresh: _onRefreshAction,
  });
}

void _onRefreshAction(Action action, Context<MineState> ctx) {
  ctx.dispatch(MineActionCreator.onAction());
}

void _init(Action action, Context<MineState> ctx) {
}
