import 'package:fish_redux/fish_redux.dart';
import 'package:partner/widget/list/common/data/tu_chong_repository.dart';
import 'package:partner/widget/list/common/text/my_extended_text_selection_controls.dart';

class RecommendState implements Cloneable<RecommendState> {
  PicInsectRepository listSourceRepository;
  bool knowImageSize = true;
  DateTime dateTimeNow = DateTime.now();
  VeganExtendedMaterialTextSelectionControls textSelectionControls;
  String attachContent = '';

  @override
  RecommendState clone() {
    return RecommendState()
      ..listSourceRepository = listSourceRepository
      ..knowImageSize = knowImageSize
      ..dateTimeNow = dateTimeNow
      ..attachContent = attachContent
      ..textSelectionControls = textSelectionControls;
  }
}

RecommendState initState(Map<String, dynamic> args) {
  final state = RecommendState();
  return state;
}