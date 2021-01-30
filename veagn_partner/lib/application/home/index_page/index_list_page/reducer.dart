import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<IndexListState> buildReducer() {
  return asReducer(
    <Object, Reducer<IndexListState>>{
      IndexListAction.action: _onAction,
    },
  );
}

IndexListState _onAction(IndexListState state, Action action) {
  final IndexListState newState = state.clone();
  return newState;
}
