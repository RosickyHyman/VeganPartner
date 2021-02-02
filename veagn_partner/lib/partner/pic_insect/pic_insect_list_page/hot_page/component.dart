import 'package:fish_redux/fish_redux.dart';

import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class HotComponent extends Component<HotState> {
  HotComponent()
      : super(
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<HotState>(
                adapter: null,
                slots: <String, Dependent<HotState>>{
                }),);

}
