import 'package:fish_redux/fish_redux.dart';

enum MessageAction { action, onRefresh, }

class MessageActionCreator {
  static Action onAction() {
    return const Action(MessageAction.action);
  }

  static Action onRefreshAction() {
    return const Action(MessageAction.onRefresh);
  }
}
