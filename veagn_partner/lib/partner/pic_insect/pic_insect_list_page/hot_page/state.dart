import 'package:fish_redux/fish_redux.dart';
import 'package:partner/widget/list/common/data/tu_chong_repository.dart';
import 'package:partner/widget/list/common/text/my_extended_text_selection_controls.dart';

class HotState implements Cloneable<HotState> {
  HotState();

  PicInsectRepository listSourceRepository = PicInsectRepository();
  bool knowImageSize = true;
  DateTime dateTimeNow = DateTime.now();
  VeganExtendedMaterialTextSelectionControls textSelectionControls = VeganExtendedMaterialTextSelectionControls();

  String attachContent = '';

  @override
  HotState clone() {
    return HotState()
      ..listSourceRepository = listSourceRepository
      ..knowImageSize = knowImageSize
      ..dateTimeNow = dateTimeNow
      ..attachContent = attachContent
      ..textSelectionControls = textSelectionControls;
  }
}
