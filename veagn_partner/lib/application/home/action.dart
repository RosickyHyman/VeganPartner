import 'package:fish_redux/fish_redux.dart';

enum HomeAction { action, setCurrentIndex,onRefresh }

class HomeActionCreator {
  static Action onAction() {
    return const Action(HomeAction.action);
  }

  static Action onSetCurrentIndexAction(int index) {
    return  Action(HomeAction.setCurrentIndex, payload: index);
  }

  static Action onRefreshAction() {
    return const Action(HomeAction.onRefresh);
  }
}
