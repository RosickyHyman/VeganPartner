import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'package:extended_text/extended_text.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:partner/widget/list/common/data/tu_chong_repository.dart';
import 'package:partner/widget/list/common/data/tu_chong_source.dart';
import 'package:partner/widget/list/common/model/pic_swiper_item.dart';
import 'package:partner/widget/list/common/utils/screen_util.dart';
import 'package:partner/widget/list/item/crop_image.dart';
import 'package:partner/widget/list/item/item_builder.dart';
import 'package:partner/widget/list/item/pic_grid_view.dart';
import 'package:partner/widget/list/item/push_to_refresh_header.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

import 'state.dart';

Widget buildView(VideoState state, Dispatch dispatch, ViewService viewService) {
  return _buildAttentionListView(state, dispatch, viewService);
}

Widget _buildAttentionListView(VideoState state, Dispatch dispatch, ViewService viewService) {
  const double fontSize = 12.0;
  final double margin = ScreenUtil.instance.setWidth(10);
  final Widget result = Material(
    child: Column(
      children: <Widget>[
        Expanded(
          child: LayoutBuilder(
            builder: (BuildContext c, BoxConstraints data) {
              final int crossAxisCount = max(data.maxWidth ~/ ScreenUtil.instance.screenWidthDp, 1);
              return PullToRefreshNotification(
                  pullBackOnRefresh: false,
                  maxDragOffset: maxDragOffset,
                  armedDragUpCancel: false,
                  onRefresh: () {
                    return state.listSourceRepository.refresh().whenComplete(() {
                      state.dateTimeNow = DateTime.now();
                    });
                  },
                  child: LoadingMoreCustomScrollView(
                    showGlowLeading: false,
                    physics: const ClampingScrollPhysics(),
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: PullToRefreshContainer((PullToRefreshScrollNotificationInfo info) {
                          return PullToRefreshHeader(info, state.dateTimeNow);
                        }),
                      ),
                      LoadingMoreSliverList<TuChongItem>(
                        SliverListConfig<TuChongItem>(
                          extendedListDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          itemBuilder: (BuildContext context, TuChongItem item, int index) {
                            String title = item.site.name;
                            if (title == null || title == '') {
                              title = 'Image$index';
                            }
                            String content = item.content ?? (item.excerpt ?? title);
                            final double left = (ScreenUtil.instance.width - 2 * margin - 4.0) / 3 + margin;
                            bool isMutPic =
                                item.images.map<PicSwiperItem>((ImageItem f) => PicSwiperItem(picUrl: f.imageUrl, des: f.title)).toList().length >= 9;

                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                PicGridView(tuChongItem: item, maxPicGridViewCount: isMutPic ? 3 : 1),
                                content == ''
                                    ? Container() :Padding(
                                        child: ExtendedText(
                                          content,
                                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                                          maxLines: 10,
                                          selectionEnabled: true,
                                          textSelectionControls: state.textSelectionControls,
                                        ),
                                        padding: EdgeInsets.only(left: 2* margin, right: 2* margin, bottom: margin),
                                      ),
                                Padding(
                                  padding: EdgeInsets.all(margin),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: margin),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              ExtendedImage.network(
                                                item.avatarUrl,
                                                width: 25.0,
                                                height: 25.0,
                                                shape: BoxShape.circle,
                                                clearMemoryCacheWhenDispose: true,
                                                border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1.0),
                                                loadStateChanged: (ExtendedImageState state) {
                                                  if (state.extendedImageLoadState == LoadState.completed) {
                                                    return null;
                                                  }
                                                  return Image.asset('images/widget/list/avatar.jpg');
                                                },
                                              ),
                                              SizedBox(
                                                width: margin,
                                              ),
                                              Text(title,
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: ScreenUtil.instance.setSp(18),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Row(
                                                children: <Widget>[
                                                  const Icon(Icons.comment, color: Colors.amberAccent, size: 18.0),
                                                  const SizedBox(
                                                    width: 3.0,
                                                  ),
                                                  Text(item.comments.toString(), style: const TextStyle(color: Colors.grey, fontSize: fontSize))
                                                ],
                                              ),
                                              const SizedBox(width: 3.0),
                                              LikeButton(
                                                size: 16.0,
                                                isLiked: item.isFavorite,
                                                likeCount: item.favorites,
                                                countBuilder: (int count, bool isLiked, String text) {
                                                  final ColorSwatch<int> color = isLiked ? Colors.pinkAccent : Colors.grey;
                                                  Widget result;
                                                  if (count == 0) {
                                                    result = Text(
                                                      'love',
                                                      style: TextStyle(color: color, fontSize: fontSize),
                                                    );
                                                  } else {
                                                    result = Text(
                                                      count >= 1000 ? (count / 1000.0).toStringAsFixed(1) + 'k' : text,
                                                      style: TextStyle(color: color, fontSize: fontSize),
                                                    );
                                                  }
                                                  return result;
                                                },
                                                likeCountAnimationType:
                                                    item.favorites < 1000 ? LikeCountAnimationType.part : LikeCountAnimationType.none,
                                                onTap: (bool isLiked) {
                                                  return onLikeButtonTap(isLiked, item);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: margin),
                                  color: Colors.grey.withOpacity(0.2),
                                  height: margin,
                                ),
                              ],
                            );
                          },
                          sourceList: state.listSourceRepository,
                        ),
                      )
                    ],
                  ));
            },
          ),
        )
      ],
    ),
  );

  return ExtendedTextSelectionPointerHandler(
    builder: (List<ExtendedTextSelectionState> states) {
      return Listener(
        child: result,
        behavior: HitTestBehavior.translucent,
        onPointerDown: (PointerDownEvent value) {
          for (final ExtendedTextSelectionState state in states) {
            if (!state.containsPosition(value.position)) {
              //clear other selection
              state.clearSelection();
            }
          }
        },
        onPointerMove: (PointerMoveEvent value) {
          //clear other selection
          for (final ExtendedTextSelectionState state in states) {
            state.clearSelection();
          }
        },
      );
    },
  );
}
