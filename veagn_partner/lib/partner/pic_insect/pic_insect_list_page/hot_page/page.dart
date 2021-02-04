import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class HotPage extends Page<HotState, Map<String, dynamic>> {
  HotPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<HotState>(
                adapter: null,
                slots: <String, Dependent<HotState>>{
                }),
            middleware: <Middleware<HotState>>[
            ],);

}
