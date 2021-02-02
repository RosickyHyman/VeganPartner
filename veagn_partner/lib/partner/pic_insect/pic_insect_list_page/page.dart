import 'package:fish_redux/fish_redux.dart';


import 'hot_page/state.dart';
import 'hot_page/component.dart';
import 'recommend_page/component.dart';
import 'recommend_page/state.dart';


import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PicInsectListPage extends Page<PicInsectListState, Map<String, dynamic>> with SingleTickerProviderMixin {
  PicInsectListPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<PicInsectListState>(
                adapter: null,
                slots: <String, Dependent<PicInsectListState>>{
                  'recommendComponent': RecommendConnector() + RecommendComponent(),
                  'hotComponent': HotConnector() + HotComponent(),
                }),
            middleware: <Middleware<PicInsectListState>>[
            ],);

}

class HotConnector extends ConnOp<PicInsectListState, HotState> {
  @override
  HotState get(PicInsectListState state) {
    return state.hotState;
  }

  @override
  void set(PicInsectListState state, HotState subState) {
    state.hotState = subState;
  }
}

class RecommendConnector extends ConnOp<PicInsectListState, RecommendState> {
  @override
  RecommendState get(PicInsectListState state) {
    return state.recommendState;
  }

  @override
  void set(PicInsectListState state, RecommendState subState) {
    state.recommendState = subState;
  }
}