import 'package:fish_redux/fish_redux.dart';

enum AttentionAction { action }

class AttentionActionCreator {
  static Action onAction() {
    return const Action(AttentionAction.action);
  }
}
