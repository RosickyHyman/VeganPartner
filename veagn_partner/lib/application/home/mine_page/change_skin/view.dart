import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:partner/utils/common/common_colors.dart';
import 'package:partner/utils/other/hex_color.dart';
import 'package:partner/widget/public/app_bar.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(ChangeSkinState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: PublicAppBar(
      context: viewService.context,
      title: '主题颜色',
    ),
    body: _buildSkinListView(state, dispatch, viewService),
  );
}

Widget _buildSkinListView(ChangeSkinState state, Dispatch dispatch, ViewService viewService) {
  return ListView.separated(
    itemCount: state.list.length,
    physics: const AlwaysScrollableScrollPhysics(),
    itemBuilder: (BuildContext context, int index) {
      return _buildItemView(state, viewService, dispatch, index);
    },
    separatorBuilder: (BuildContext context, int index) {
      return Container(height: 0);
    },
  );
}

Widget _buildItemView(
  ChangeSkinState state,
  ViewService viewService,
  Dispatch dispatch,
  int index,
) {
  final Map map = state.list[index];
  return InkWell(
    child: Container(

      margin: const EdgeInsets.only(left: 15.0, right: 15.0),
      height: 50.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(4.0)), color: HexColor(map['color'])),
              ),
              SizedBox(width: 20.0),
              Container(
                child: Text(map['title'],
                  style: TextStyle(color: HexColor(CommonColors.sixNineColor), fontSize: 18.0),),
              ),
            ],
          ),
          Container(
            child: map['isSelect'] ?? false
                ? Icon(
                    Icons.check_rounded,
                    size: 30,
                    color: HexColor(CommonColors.pinkTheme),
                  )
                : Container(),
          )
        ],
      ),
    ),
    onTap: () {
      dispatch(ChangeSkinActionCreator.onChangeSkinAction(index));
    },
  );
}
