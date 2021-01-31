import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/animation.dart';
import 'action.dart';
import 'state.dart';

Effect<HomeState> buildEffect() {
  return combineEffects(<Object, Effect<HomeState>>{
    Lifecycle.initState: _init,
    HomeAction.setCurrentIndex: _setCurrentIndex,
  });
}

void _init(Action action, Context<HomeState> ctx) {

}

void _setCurrentIndex(Action action, Context<HomeState> ctx) {


  int index = action.payload;
  ctx.state.currentIndex = index;

  ctx.state.pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.easeInBack);
  ctx.dispatch(HomeActionCreator.onAction());
}