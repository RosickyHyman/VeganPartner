import 'package:fish_redux/fish_redux.dart';
import 'package:partner/widget/list/common/data/tu_chong_repository.dart';

class AttentionState implements Cloneable<AttentionState> {
  PicInsectRepository listSourceRepository;
  @override
  AttentionState clone() {
    return AttentionState()..listSourceRepository = listSourceRepository;
  }
}

AttentionState initState(Map<String, dynamic> args) {
  final state = AttentionState();
  return state;
}
