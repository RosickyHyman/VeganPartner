import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class ChangeSkinPage extends Page<ChangeSkinState, Map<String, dynamic>> {
  ChangeSkinPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<ChangeSkinState>(
                adapter: null,
                slots: <String, Dependent<ChangeSkinState>>{
                }),
            middleware: <Middleware<ChangeSkinState>>[
            ],);

}
