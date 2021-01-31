import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:partner/utils/common/common_colors.dart';

import 'state.dart';

Widget buildView(MessageState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
      appBar: PreferredSize(
      preferredSize: Size.fromHeight(50.0),
  child:AppBar(
      backgroundColor: CommonColors.greenTheme)),
    body: Container(
      color: CommonColors.greenTheme,
    ),

  );
}
