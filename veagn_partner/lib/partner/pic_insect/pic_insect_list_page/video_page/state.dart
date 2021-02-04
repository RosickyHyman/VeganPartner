import 'package:fish_redux/fish_redux.dart';
import 'package:partner/widget/list/common/data/tu_chong_repository.dart';
import 'package:partner/widget/list/common/text/my_extended_text_selection_controls.dart';

class VideoState implements Cloneable<VideoState> {
  PicInsectRepository listSourceRepository;
  bool knowImageSize = true;
  DateTime dateTimeNow = DateTime.now();
  VeganExtendedMaterialTextSelectionControls textSelectionControls;
  String attachContent = '';

  @override
  VideoState clone() {
    return VideoState()
      ..listSourceRepository = listSourceRepository
      ..knowImageSize = knowImageSize
      ..dateTimeNow = dateTimeNow
      ..attachContent = attachContent
      ..textSelectionControls = textSelectionControls;
  }
}

VideoState initState(Map<String, dynamic> args) {
  return VideoState();
}
