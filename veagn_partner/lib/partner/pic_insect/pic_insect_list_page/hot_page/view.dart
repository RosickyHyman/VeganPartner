import 'dart:math';

import 'package:extended_image/extended_image.dart';
import 'package:extended_text/extended_text.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:partner/widget/list/common/data/tu_chong_source.dart';
import 'package:partner/widget/list/common/text/my_special_text_span_builder.dart';
import 'package:partner/widget/list/common/utils/screen_util.dart';
import 'package:partner/widget/list/item/item_builder.dart';
import 'package:partner/widget/list/item/pic_grid_view.dart';
import 'package:partner/widget/list/item/push_to_refresh_header.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';
import 'package:url_launcher/url_launcher.dart';

import 'state.dart';

Widget buildView(HotState state, Dispatch dispatch, ViewService viewService) {
  return _buildHotListView(state, dispatch, viewService);
}

Widget _buildHotListView(HotState state, Dispatch dispatch, ViewService viewService) {
  final double margin = ScreenUtil.instance.setWidth(22);
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
                            content += state.attachContent;

                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(margin),
                                  child: Row(
                                    children: <Widget>[
                                      ExtendedImage.network(
                                        item.avatarUrl,
                                        width: 40.0,
                                        height: 40.0,
                                        shape: BoxShape.circle,
                                        //enableLoadState: false,
                                        clearMemoryCacheWhenDispose: true,
                                        border: Border.all(color: Colors.grey.withOpacity(0.4), width: 1.0),
                                        loadStateChanged: (ExtendedImageState state) {
                                          if (state.extendedImageLoadState == LoadState.completed) {
                                            return null;
                                          }
                                          return Image.asset(
                                            'images/widget/list/avatar.jpg',
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        width: margin,
                                      ),
                                      Text(title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: ScreenUtil.instance.setSp(34),
                                          )),
                                    ],
                                  ),
                                ),
                                Padding(
                                  child: ExtendedText(
                                    content,
                                    onSpecialTextTap: (dynamic parameter) {
                                      if (parameter.toString().startsWith('\$')) {
                                        launch('https://github.com/fluttercandies');
                                      } else if (parameter.toString().startsWith('@')) {
                                        launch('mailto:zmtzawqlp@live.com');
                                      }
                                    },
                                    specialTextSpanBuilder: MySpecialTextSpanBuilder(),
                                    //overflow: ExtendedTextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                                    maxLines: 10,
                                    overflowWidget: kIsWeb
                                        ? null
                                        : TextOverflowWidget(
                                            //maxHeight: double.infinity,
                                            //align: TextOverflowAlign.right,
                                            //fixedOffset: Offset.zero,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                const Text('\u2026 '),
                                                RaisedButton(
                                                  child: const Text('more'),
                                                  onPressed: () {
                                                    launch('https://github.com/fluttercandies/extended_text');
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                    selectionEnabled: true,
                                    textSelectionControls: state.textSelectionControls,
                                  ),
                                  padding: EdgeInsets.only(left: margin, right: margin, bottom: margin),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: margin),
                                  child: buildTagsWidget(item),
                                ),
                                PicGridView(
                                  tuChongItem: item,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: margin),
                                  child: buildBottomWidget(item, showAvatar: false),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: margin),
                                  color: Colors.grey.withOpacity(0.2),
                                  height: margin,
                                )
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
