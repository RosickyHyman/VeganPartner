import 'package:fish_redux/fish_redux.dart';

enum MineAction { action,onRefresh }

class MineActionCreator {
  static Action onAction() {
    return const Action(MineAction.action);
  }

  static Action onRefreshAction() {
    return const Action(MineAction.onRefresh);
  }
}
