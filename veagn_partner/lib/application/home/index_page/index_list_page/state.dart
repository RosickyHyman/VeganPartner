import 'package:fish_redux/fish_redux.dart';

class IndexListState implements Cloneable<IndexListState> {
  Map map;

  List list;

  @override
  IndexListState clone() {
    return IndexListState()
      ..list = list
      ..map = map;
  }
}

IndexListState initState(Map<String, dynamic> args) {
  return IndexListState()..map = args;
}
