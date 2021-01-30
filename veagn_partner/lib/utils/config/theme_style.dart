import 'package:flutter/material.dart';

class ZQThemeStyle {
  /// 导航栏高度
  static const kNavBarPersistentHeight = 44.0;

  /// iOS导航栏风格
  static TextStyle navTitleTextStyle() {
    return const TextStyle(
      inherit: false,
      fontFamily: '.SF Pro Text',
      fontSize: 17.0,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.41,
      color: Colors.white,
    );
  }
}
