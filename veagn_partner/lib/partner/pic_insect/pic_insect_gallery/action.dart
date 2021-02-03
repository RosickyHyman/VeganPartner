import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum PicInsectGalleryAction { action }

class PicInsectGalleryActionCreator {
  static Action onAction() {
    return const Action(PicInsectGalleryAction.action);
  }
}
