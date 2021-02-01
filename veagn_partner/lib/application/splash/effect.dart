import 'package:flutter/material.dart' hide Action;
import 'package:fish_redux/fish_redux.dart';
import 'package:partner/utils/common/common_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'action.dart';
import 'state.dart';

Effect<SplashState> buildEffect() {
  return combineEffects(<Object, Effect<SplashState>>{
    Lifecycle.initState: _init,
    SplashAction.onRefresh: _onRefreshAction,
  });
}

void _onRefreshAction(Action action, Context<SplashState> ctx) {
  ctx.dispatch(SplashActionCreator.onAction());
}

void _init(Action action, Context<SplashState> ctx) {
  _initSp(ctx);
}

Future<void> _initSp(Context<SplashState> ctx) async {
  final prefs = await SharedPreferences.getInstance();

  final String color = prefs.getString('themeColor')== null || prefs.getString('themeColor') == ''? CommonColors.defaultColors : prefs.getString('themeColor');

  CommonColors.defaultColors = color;

  Navigator.of(ctx.context).pushReplacementNamed('home_page');
}