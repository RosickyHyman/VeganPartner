import 'package:flutter/material.dart';
import 'package:partner/utils/common/common_colors.dart';
import 'package:partner/utils/config/theme_style.dart';
import 'package:partner/utils/other/hex_color.dart';


class PublicAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PublicAppBar({
    Key key,
    this.context,
    this.title,
    this.showBack = true,
    this.actions,
    this.titleWidget,
    this.onBackTap,
  }) : super(key: key);

  @override
  Size get preferredSize {
    return const Size.fromHeight(VeganThemeStyle.kNavBarPersistentHeight);
  }

  /// 返回按钮使用
  final BuildContext context;

  /// 标题
  final String title;

  /// 是否显示返回按钮, 默认显示
  final bool showBack;

  /// 右边按钮
  final List<Widget> actions;
  final Widget titleWidget;

  /// 点击返回回调,默认Pop
  final GestureTapCallback onBackTap;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        backgroundColor: HexColor(CommonColors.defaultColors),
        elevation: 0,
        centerTitle: true,
        leading: showBack
            ? GestureDetector(
                child:  Icon(
                  Icons.arrow_back_ios_outlined,
                  size: 20,
                  color: HexColor(CommonColors.white),
                ),
                onTap: onBackTap ?? () => Navigator.pop(context),
              )
            : Container(),
        title: titleWidget ??
            Text(
              title ?? '',
              style: VeganThemeStyle.navTitleTextStyle(),
            ),
        actions: actions,
      ),
    );
  }
}
