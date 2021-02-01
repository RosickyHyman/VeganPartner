import 'package:flutter/material.dart';
import 'package:partner/utils/common/common_colors.dart';
import 'package:partner/utils/other/hex_color.dart';

class VeganThemeStyle {
  /// 导航栏高度
  static const kNavBarPersistentHeight = 50.0;

  /// iOS导航栏风格
  static TextStyle navTitleTextStyle() {
    return TextStyle(
      inherit: false,
      fontFamily: '.SF Pro Text',
      fontSize: 17.0,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.41,
      color: HexColor(CommonColors.appBarTitleColor),
    );
  }
}
