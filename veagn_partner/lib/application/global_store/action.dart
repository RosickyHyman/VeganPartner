import 'package:fish_redux/fish_redux.dart';

enum GlobalAction {
  action,
  changeThemeColor,
  tokenInvalid,
}

class GlobalActionCreator {
  static Action onChangeThemeColor() {
    return const Action(GlobalAction.changeThemeColor);
  }

  static Action onTokenInvalid() {
    return const Action(GlobalAction.tokenInvalid);
  }
}
