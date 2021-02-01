import 'package:fish_redux/fish_redux.dart';

enum IndexListAction { action }

class IndexListActionCreator {
  static Action onAction() {
    return const Action(IndexListAction.action);
  }
}
