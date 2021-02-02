import 'package:fish_redux/fish_redux.dart';

enum PicInsectListAction { action }

class PicInsectListActionCreator {
  static Action onAction() {
    return const Action(PicInsectListAction.action);
  }

}
