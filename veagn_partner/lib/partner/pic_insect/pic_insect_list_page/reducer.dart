import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PicInsectListState> buildReducer() {
  return asReducer(
    <Object, Reducer<PicInsectListState>>{
      PicInsectListAction.action: _onAction,
    },
  );
}

PicInsectListState _onAction(PicInsectListState state, Action action) {
  final PicInsectListState newState = state.clone();
  return newState;
}
