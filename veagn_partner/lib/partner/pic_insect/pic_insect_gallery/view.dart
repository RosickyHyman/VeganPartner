import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:partner/partner/pic_insect/widget/gallery_photo/photo_gallery.dart';

import 'state.dart';

Widget buildView(PicInsectGalleryState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    body: PhotoGallery(state.pics, state.index, state.tuChongItem),
  );
}
