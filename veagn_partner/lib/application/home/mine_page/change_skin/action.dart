import 'package:fish_redux/fish_redux.dart';

enum ChangeSkinAction { action, changeSkinAction, }

class ChangeSkinActionCreator {
  static Action onAction() {
    return const Action(ChangeSkinAction.action);
  }


  static Action onChangeSkinAction(int index) {
    return Action(ChangeSkinAction.changeSkinAction, payload: index);
  }
}
