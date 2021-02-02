import 'package:fish_redux/fish_redux.dart';

enum HotAction { action }

class HotActionCreator {
  static Action onAction() {
    return const Action(HotAction.action);
  }
}
