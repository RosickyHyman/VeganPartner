import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:partner/utils/common/common_colors.dart';
import 'package:flutter_svg/svg.dart';

import 'state.dart';

Widget buildView(MineState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    body: Material(
      color: CommonColors.defaultColors,
      child: Column(
        children: <Widget>[
          _buildTopView(state, dispatch, viewService),
          Expanded(
            child: Container(
              color: CommonColors.yellowTheme,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildTopView(MineState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    child: Column(
      children: [
        Container(

          margin: const EdgeInsets.only(right: 10.0,top: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(child: SvgPicture.asset('images/home/mine/scan.svg', fit: BoxFit.cover), width: 25, height: 25),
              SizedBox(width: 10),
              Container(child: SvgPicture.asset('images/home/mine/painter.svg', fit: BoxFit.cover), width: 27, height: 27),
              SizedBox(width: 10),
              Container(child: SvgPicture.asset('images/home/mine/moon.svg', fit: BoxFit.cover), width: 23, height: 23),
            ],
          ),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: [
                    Container(
                      width: 75,
                      height: 75,
                      padding: const EdgeInsets.only(left: 0.0, top: 5.0, bottom: 5.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage('https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=4205192766,3222152012&fm=26&gp=0.jpg'),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                        child: Text(
                      '琴心剑魄',
                      style: TextStyle(color: CommonColors.mainBgColor, fontSize: 16.0),
                    )),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(right: 10.0),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15,
                color: CommonColors.bgColor,
              ),
            )
          ],
        ),
        SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildPersonDataView(state, dispatch, viewService, '动态', '7'),
            Center(
              child: Container(width: 1, height: 10, color: CommonColors.mainBgColor),
            ),
            _buildPersonDataView(state, dispatch, viewService, '关注', '10'),
            Center(
              child: Container(width: 1, height: 10, color: CommonColors.mainBgColor),
            ),
            _buildPersonDataView(state, dispatch, viewService, '粉丝', '6'),
          ],
        ),
        SizedBox(height: 15),
        Container(
            margin: const EdgeInsets.only(left: 15.0, right: 15.0),
            decoration: BoxDecoration(color: CommonColors.mineAdBgColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10.0, top: 8.0, bottom: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: Text(
                        '开通大会员',
                        style: TextStyle(color: CommonColors.white, fontSize: 15.0, fontWeight: FontWeight.w500),
                      )),
                      SizedBox(height: 3),
                      Container(
                          child: Text(
                        '超多内容，权益等你来',
                        style: TextStyle(color: CommonColors.mainBgColor, fontSize: 13.0),
                      )),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                    color: CommonColors.bgColor,
                  ),
                )
              ],
            )),
      ],
    ),
  );
}

Widget _buildPersonDataView(MineState state, Dispatch dispatch, ViewService viewService, String title, String data) {
  return Container(
    child: Column(
      children: [
        SizedBox(width: 10),
        Container(
            child: Text(
          data,
          style: TextStyle(color: CommonColors.mainBgColor, fontSize: 16.0),
        )),
        SizedBox(height: 5),
        Container(
            child: Text(
          title,
          style: TextStyle(color: CommonColors.mainBgColor, fontSize: 12.0),
        )),
      ],
    ),
  );
}
