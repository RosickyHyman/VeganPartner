import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(SplashState state, Dispatch dispatch, ViewService viewService) {
  return _buildSplash(viewService);
}

Widget _buildSplash(ViewService viewService) {
  return Scaffold(
    body: Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 50.0),
      child: Image.asset(
        'images/splash/couple_read.png',
        fit: BoxFit.scaleDown,
      ),
    ),
  );
}
