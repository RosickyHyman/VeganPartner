import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum IndexListAction { action }

class IndexListActionCreator {
  static Action onAction() {
    return const Action(IndexListAction.action);
  }
}
