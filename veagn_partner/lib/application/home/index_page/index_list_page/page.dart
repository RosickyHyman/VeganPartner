import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class IndexListPage extends Page<IndexListState, Map<String, dynamic>> {
  IndexListPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<IndexListState>(
                adapter: null,
                slots: <String, Dependent<IndexListState>>{
                }),
            middleware: <Middleware<IndexListState>>[
            ],);

}
