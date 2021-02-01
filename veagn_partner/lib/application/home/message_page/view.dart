import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:partner/utils/common/common_colors.dart';
import 'package:partner/utils/config/theme_style.dart';
import 'package:partner/utils/other/hex_color.dart';

import 'state.dart';

Widget buildView(MessageState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: PreferredSize(
      preferredSize: Size.fromHeight(VeganThemeStyle.kNavBarPersistentHeight),
      child: AppBar(backgroundColor: HexColor(CommonColors.greenTheme)),
    ),
    body: Container(
      color: HexColor(CommonColors.greenTheme),
    ),
  );
}
