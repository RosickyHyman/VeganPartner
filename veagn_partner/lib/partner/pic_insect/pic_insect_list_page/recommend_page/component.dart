import 'package:fish_redux/fish_redux.dart';

import 'state.dart';
import 'reducer.dart';
import 'view.dart';



class RecommendComponent extends Component<RecommendState> {
  RecommendComponent()
      : super(
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<RecommendState>(
                adapter: null,
                slots: <String, Dependent<RecommendState>>{
                }),);

}
