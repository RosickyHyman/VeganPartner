import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:gesture_zoom_box/gesture_zoom_box.dart';
import 'package:partner/widget/public/refresh_list_widget.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(WelFareState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    child: PublicRefreshListWidget(
      onRefresh: () async {
        dispatch(WelFareActionCreator.onRefreshAction());
      },
      list: state.dataList,
      scrollController: state.scrollController,
      isShownMore: state.isShownMore,
      isShowFoot: state.isShowFoot,
      type: FlowType.STAGGERED_GRID,
      crossAxisCount: 2,
      footTitle: '共${state.total}份整改',
      divider: Container(height: 10),
      itemBuilder: (content, index) {
        final Map map = state.dataList[index];
        return _buildListItem(state: state, map: map, dispatch: dispatch, viewService: viewService);
      },
    ),
  );
}

/// 获取加载数据失败的布局
Widget _buildListItem({WelFareState state, Map map, Dispatch dispatch, ViewService viewService}) {
  // String imageUrl = 'https://photo.tuchong.com/${map['images'][0]['user_id']}/f/${map['images'][0]['img_id']}.jpg';

  String imageUrl = map['url'];

  print('==imageUrl==${imageUrl.toString()}');
  return GestureDetector(
    onTap: () {
      // 显示大图
      Navigator.push(
        viewService.context,
        MaterialPageRoute(
            builder: (context) => _createBigImagePage(imageUrl, () {
                  Navigator.pop(viewService.context);
                })),
      );
    },
    // 图片卡片
    child: Card(
      elevation: 1,
      margin: const EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Hero(
          tag: imageUrl,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) => Icon(Icons.image),
            errorWidget: (context, url, error) => Icon(Icons.broken_image),
          ),
        ),
      ),
    ),
  );
}

Widget _createBigImagePage(String url, Function onPressed) {
  return Scaffold(
    backgroundColor: Colors.black,
    body: Center(
      child: Hero(
        tag: url,
        child: GestureZoomBox(
          child: CachedNetworkImage(
            imageUrl: url,
            placeholder: (context, url) => Icon(Icons.image),
            errorWidget: (context, url, error) => Icon(Icons.broken_image_rounded),
          ),
          onPressed: onPressed,
        ),
      ),
    ),
  );
}
