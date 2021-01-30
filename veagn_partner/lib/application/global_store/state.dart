import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

abstract class GlobalBaseState {
  Color get themeColor;
  set themeColor(Color color);

  bool get isLogin;
  set isLogin(bool login);
}

class GlobalState implements GlobalBaseState, Cloneable<GlobalState> {
  @override
  Color themeColor;

  @override
  bool isLogin = false;

  @override
  GlobalState clone() {
    return GlobalState()
      ..themeColor = this.themeColor
      ..isLogin = this.isLogin;
  }
}
