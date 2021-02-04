import 'package:fish_redux/fish_redux.dart';
import 'package:partner/widget/list/common/data/tu_chong_repository.dart';

class HotState implements Cloneable<HotState> {
  PicInsectRepository listSourceRepository;

  @override
  HotState clone() {
    return HotState()..listSourceRepository = listSourceRepository;
  }


}
HotState initState(Map<String, dynamic> args) {
  final state = HotState();
  return state;
}