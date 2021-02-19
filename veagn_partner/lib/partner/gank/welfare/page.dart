import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class WelFarePage extends Page<WelFareState, Map<String, dynamic>> {
  WelFarePage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<WelFareState>(
                adapter: null,
                slots: <String, Dependent<WelFareState>>{
                }),
            middleware: <Middleware<WelFareState>>[
            ],);

}
