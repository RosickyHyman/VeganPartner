import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<ChangeSkinState> buildReducer() {
  return asReducer(
    <Object, Reducer<ChangeSkinState>>{
      ChangeSkinAction.action: _onAction,
    },
  );
}

ChangeSkinState _onAction(ChangeSkinState state, Action action) {
  final ChangeSkinState newState = state.clone();
  return newState;
}
