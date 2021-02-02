import 'package:fish_redux/fish_redux.dart';
import 'package:partner/partner/pic_insect/pic_insect_list_page/hot_page/state.dart';
import 'package:partner/partner/pic_insect/pic_insect_list_page/recommend_page/state.dart';

class PicInsectListState implements Cloneable<PicInsectListState> {
  Map map;

  List list;

  HotState hotState;

  RecommendState recommendState;

  @override
  PicInsectListState clone() {
    return PicInsectListState()
      ..list = list
      ..map = map
      ..hotState = hotState
      ..recommendState = recommendState;
  }
}

PicInsectListState initState(Map<String, dynamic> args) {


  final state = PicInsectListState();
  state.map = args;
  state.hotState = HotState();
  state.recommendState = RecommendState();

  return state;
}


