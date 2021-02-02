import 'package:fish_redux/fish_redux.dart';
import 'package:partner/widget/list/common/data/tu_chong_repository.dart';

class RecommendState implements Cloneable<RecommendState> {

  RecommendState();
  PicInsectRepository waterfallsSource = PicInsectRepository();

  @override
  RecommendState clone() {
    return RecommendState()..waterfallsSource = waterfallsSource;
  }
}


