import 'package:fish_redux/fish_redux.dart';

enum IndexAction { action,onRefresh }

class IndexActionCreator {
  static Action onAction() {
    return const Action(IndexAction.action);
  }

  static Action onRefreshAction() {
    return const Action(IndexAction.onRefresh);
  }
}
