import 'package:fish_redux/fish_redux.dart';


enum WelFareAction { action,onRefresh }

class WelFareActionCreator {
  static Action onAction() {
    return const Action(WelFareAction.action);
  }

  static Action onRefreshAction() {
    return const Action(WelFareAction.onRefresh);
  }
}
