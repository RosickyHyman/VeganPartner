import 'dart:math';

import 'package:fish_redux/fish_redux.dart';
import 'package:partner/widget/list/common/data/tu_chong_source.dart';
import 'package:partner/widget/list/common/model/pic_swiper_item.dart';

class PicInsectGalleryState implements Cloneable<PicInsectGalleryState> {
  int index;
  List<PicSwiperItem> pics;
  TuChongItem tuChongItem;

  @override
  PicInsectGalleryState clone() {
    return PicInsectGalleryState()
      ..index = index
      ..pics = pics
      ..tuChongItem = tuChongItem;
  }
}

PicInsectGalleryState initState(Map<String, dynamic> args) {
  List<PicSwiperItem> pics = args['pics'];
  int index = args['index'];
  TuChongItem tuChongItem = args['tuChongItem'];
  print(tuChongItem.toString());
  return PicInsectGalleryState()
    ..pics = pics
    ..index = index
    ..tuChongItem = tuChongItem;
}
