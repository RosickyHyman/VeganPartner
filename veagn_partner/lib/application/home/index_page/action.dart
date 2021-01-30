import 'package:fish_redux/fish_redux.dart';

enum IndexAction { action }

class IndexActionCreator {
  static Action onAction() {
    return const Action(IndexAction.action);
  }
}
