import 'package:fish_redux/fish_redux.dart';

enum SplashAction { action, onRefresh, }

class SplashActionCreator {
  static Action onAction() {
    return const Action(SplashAction.action);
  }

  static Action onRefreshAction() {
    return const Action(SplashAction.onRefresh);
  }
}
