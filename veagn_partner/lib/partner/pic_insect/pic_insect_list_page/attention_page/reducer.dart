import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<AttentionState> buildReducer() {
  return asReducer(
    <Object, Reducer<AttentionState>>{
      AttentionAction.action: _onAction,
    },
  );
}

AttentionState _onAction(AttentionState state, Action action) {
  final AttentionState newState = state.clone();
  return newState;
}
