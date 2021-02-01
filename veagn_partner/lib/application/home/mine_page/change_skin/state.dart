import 'package:fish_redux/fish_redux.dart';

class ChangeSkinState implements Cloneable<ChangeSkinState> {
  List list;
  int lastIndex = 0;
  @override
  ChangeSkinState clone() {
    return ChangeSkinState()
      ..list = list
      ..lastIndex = lastIndex;
  }
}

ChangeSkinState initState(Map<String, dynamic> args) {
  return ChangeSkinState();
}
