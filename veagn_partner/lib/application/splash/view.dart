import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'state.dart';

Widget buildView(SplashState state, Dispatch dispatch, ViewService viewService) {
  return _buildSplash();
}

Widget _buildSplash() {
  return Scaffold(
    backgroundColor: Colors.white,
    body: Container(
      alignment: Alignment.center,
      child:
        Container(
          child: SvgPicture.asset(
            'images/splash/couple.svg',
            width: 446,
            height: 459,
            fit: BoxFit.scaleDown,
          ),
        ),

    ),
  );
}
