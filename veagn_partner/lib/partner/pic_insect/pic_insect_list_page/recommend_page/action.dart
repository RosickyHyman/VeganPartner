import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum RecommendAction { action }

class RecommendActionCreator {
  static Action onAction() {
    return const Action(RecommendAction.action);
  }
}
