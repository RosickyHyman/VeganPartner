import 'package:fish_redux/fish_redux.dart';

import 'action.dart';
import 'state.dart';

Reducer<PicInsectGalleryState> buildReducer() {
  return asReducer(
    <Object, Reducer<PicInsectGalleryState>>{
      PicInsectGalleryAction.action: _onAction,
    },
  );
}

PicInsectGalleryState _onAction(PicInsectGalleryState state, Action action) {
  final PicInsectGalleryState newState = state.clone();
  return newState;
}
