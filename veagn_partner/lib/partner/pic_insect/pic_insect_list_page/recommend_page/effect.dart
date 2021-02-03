import 'package:fish_redux/fish_redux.dart';
import 'package:partner/utils/config/apis.dart';
import 'package:partner/utils/network/http_util.dart';
import 'package:partner/widget/list/common/data/tu_chong_repository.dart';
import 'package:partner/widget/list/common/text/my_extended_text_selection_controls.dart';

import 'action.dart';
import 'state.dart';

Effect<RecommendState> buildEffect() {
  return combineEffects(<Object, Effect<RecommendState>>{
    Lifecycle.initState: _init,
    Lifecycle.dispose: _dispose,
  });
}

void _init(Action action, Context<RecommendState> ctx) {

  ctx.state.listSourceRepository = PicInsectRepository();
  ctx.state.dateTimeNow =  DateTime.now();

  ctx.state.attachContent =
  '[love]Extended text help you to build rich text quickly. any special text you will have with extended text.It\'s my pleasure to invite you to join \$FlutterCandies\$ if you want to improve flutter .[love] if you meet any problem, please let me konw @zmtzawqlp .[sun_glasses]';
  ctx.state.textSelectionControls =  VeganExtendedMaterialTextSelectionControls();

  ctx.dispatch(RecommendActionCreator.onAction());
}

void _dispose(Action action, Context<RecommendState> ctx) {
  ctx.state.listSourceRepository?.dispose();
}
