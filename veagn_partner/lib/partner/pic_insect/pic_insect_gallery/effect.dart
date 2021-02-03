import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/animation.dart';

import 'action.dart';
import 'state.dart';

Effect<PicInsectGalleryState> buildEffect() {
  return combineEffects(<Object, Effect<PicInsectGalleryState>>{
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
  });
}

void _init(Action action, Context<PicInsectGalleryState> ctx) {


}


void _dispose(Action action, Context<PicInsectGalleryState> ctx) {


}