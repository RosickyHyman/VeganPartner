import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<HotState> buildReducer() {
  return asReducer(
    <Object, Reducer<HotState>>{
      HotAction.action: _onAction,
    },
  );
}

HotState _onAction(HotState state, Action action) {
  final HotState newState = state.clone();
  return newState;
}
