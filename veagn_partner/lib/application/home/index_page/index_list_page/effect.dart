import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Effect<IndexListState> buildEffect() {
  return combineEffects(<Object, Effect<IndexListState>>{
    IndexListAction.action: _onAction,
  });
}

void _onAction(Action action, Context<IndexListState> ctx) {
}
