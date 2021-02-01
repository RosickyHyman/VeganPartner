import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<MessageState> buildEffect() {
  return combineEffects(<Object, Effect<MessageState>>{
    Lifecycle.initState: _init,
    MessageAction.onRefresh: _onRefreshAction,
  });
}

void _onRefreshAction(Action action, Context<MessageState> ctx) {
  ctx.dispatch(MessageActionCreator.onAction());
}

void _init(Action action, Context<MessageState> ctx) {
}
