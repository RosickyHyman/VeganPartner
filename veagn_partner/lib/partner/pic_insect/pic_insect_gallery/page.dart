import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class PicInsectGalleryPage extends Page<PicInsectGalleryState, Map<String, dynamic>> {
  PicInsectGalleryPage()
      : super(
            initState: initState,
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<PicInsectGalleryState>(
                adapter: null,
                slots: <String, Dependent<PicInsectGalleryState>>{
                }),
            middleware: <Middleware<PicInsectGalleryState>>[
            ],);

}
