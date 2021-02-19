import 'package:flutter/cupertino.dart' hide RefreshCallback;
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/// 流式布局的类型
enum FlowType { LIST, GRID, STAGGERED_GRID }

class PublicRefreshListWidget extends StatelessWidget {
  const PublicRefreshListWidget({
    Key key,
    this.list,
    this.onRefresh,
    this.scrollController,
    this.isShownMore,
    this.isShowFoot,
    this.footTitle,
    this.divider,
    this.itemBuilder,
    this.itemCount,
    this.footPaddingTop,
    this.type = FlowType.LIST,
    this.crossAxisCount = 2,
  }) : super(key: key);
  final List list;
  final RefreshCallback onRefresh;
  final ScrollController scrollController;
  final bool isShownMore;
  final bool isShowFoot;
  final String footTitle;
  final Widget divider;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final int crossAxisCount;
  final double footPaddingTop;
  final FlowType type;

  @override
  Widget build(BuildContext context) {
    if (type == FlowType.LIST) {
      return RefreshIndicator(
          onRefresh: onRefresh,
          child: ListView.separated(
              itemCount: itemCount ?? list.length + 1,
              physics: const AlwaysScrollableScrollPhysics(),
              controller: scrollController,
              separatorBuilder: (context, index) {
                return divider ??
                    const Divider(
                      height: 1,
                      color: Color(0xffF2F2F2),
                    );
              },
              itemBuilder: (context, index) {
                if (itemCount == null && index == list.length) {
                  return isShownMore
                      ? _moreWidget()
                      : isShowFoot
                          ? Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top: footPaddingTop ?? 8, bottom: 8),
                              child: Text(
                                footTitle,
                                style: const TextStyle(color: Color(0xff999999), fontSize: 12),
                              ),
                            )
                          : Container();
                } else {
                  return itemBuilder(context, index);
                }
              }));
    } else {
      return RefreshIndicator(
          onRefresh: onRefresh,
          child: StaggeredGridView.countBuilder(
              itemCount: itemCount ?? list.length + 1,
              physics: const AlwaysScrollableScrollPhysics(),
              controller: scrollController,
              staggeredTileBuilder: (index) {
                if (index == list.length) {
                  return StaggeredTile.fit(2);
                } else {
                  return StaggeredTile.fit(1);
                }
              },
              itemBuilder: (context, index) {
                if (itemCount == null && index == list.length) {
                  return isShownMore
                      ? _moreWidget()
                      : isShowFoot
                          ? Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.only(top: footPaddingTop ?? 8, bottom: 8),
                              child: Text(
                                footTitle,
                                style: const TextStyle(color: Color(0xff999999), fontSize: 12),
                              ),
                            )
                          : Container();
                } else {
                  return itemBuilder(context, index);
                }
              }, crossAxisCount: 2,));
    }
  }
}

Widget _moreWidget() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const <Widget>[
          CupertinoActivityIndicator(
            animating: true,
            radius: 15,
          ),
          SizedBox(width: 8),
          Text(
            '加载中...     ',
            style: TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    ),
  );
}
