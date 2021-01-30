import 'package:fish_redux/fish_redux.dart';

class IndexListState implements Cloneable<IndexListState> {

  @override
  IndexListState clone() {
    return IndexListState();
  }
}

IndexListState initState(Map<String, dynamic> args) {
  return IndexListState();
}
