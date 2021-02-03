import 'package:fish_redux/fish_redux.dart';
import 'package:partner/widget/list/common/data/tu_chong_repository.dart';

class HotState implements Cloneable<HotState> {
  HotState();


  PicInsectRepository waterfallsSource = PicInsectRepository();

  @override
  HotState clone() {
    return HotState()..waterfallsSource = waterfallsSource;
  }
}
