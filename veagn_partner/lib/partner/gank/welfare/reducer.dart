import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<WelFareState> buildReducer() {
  return asReducer(
    <Object, Reducer<WelFareState>>{
      WelFareAction.action: _onAction,
    },
  );
}

WelFareState _onAction(WelFareState state, Action action) {
  final WelFareState newState = state.clone();
  return newState;
}
